#!/bin/sh
# Setup trial: run /workflow:setup headless in a throwaway repo and check what it wrote.
#
# Usage: tools/trial-setup.sh <work dir> fresh|existing
#   fresh     a new .NET + React shaped repo with no workflow files
#   existing  the same, plus a CLAUDE.md, .claude/settings.json and .gitignore that must be kept
#
# Writes the session output to <work dir>/claude-<kind>.txt and prints a summary. Exit code 0 means
# every check passed. Claude Code asks a human before writes under .claude/, so a headless run cannot
# write .claude/settings.json; the session prints the intended content instead (checked below).
set -e
here="$(cd "$(dirname "$0")/.." && pwd)"
plugin="$here/plugins/workflow"
templates="$plugin/skills/setup/templates"
work="$1"; kind="$2"
[ -n "$work" ] && { [ "$kind" = fresh ] || [ "$kind" = existing ]; } || {
  echo "usage: $0 <work dir> fresh|existing" >&2; exit 2; }

repo="$work/trial-$kind"
rm -rf "$repo"; mkdir -p "$repo"; cd "$repo"
git init -q -b main
git config user.email trial@example.com; git config user.name Trial
git config core.autocrlf false
mkdir -p src/Api web
printf '<Project Sdk="Microsoft.NET.Sdk.Web"></Project>\n' > src/Api/Api.csproj
printf '{ "name": "web", "scripts": { "test": "vitest" } }\n' > web/package.json
if [ "$kind" = existing ]; then
  printf '# Trial App\n\nAn existing project.\n\n## Conventions\n\n- Keep this line.\n' > CLAUDE.md
  mkdir -p .claude
  printf '{\n  "permissions": { "allow": ["Bash(dotnet test)"], "deny": ["Read(**/bin/**)"] },\n  "env": { "TRIAL_KEEP": "1" }\n}\n' > .claude/settings.json
  printf 'bin/\nobj/\n' > .gitignore
fi
git add -A; git commit -q -m "Trial start"

prompt="/workflow:setup Trial web app (.NET API, React front end, SQL Server, Azure). Shared files: EF Core migrations and model snapshot, appsettings*.json, package-lock.json. Generated folders: bin, obj, node_modules. Check commands: dotnet build, dotnet test, npm test. Runbooks: deploy to the Azure test slot, run database migrations. Do not ask questions: these are all the answers. Do not commit."
claude -p "$prompt" --plugin-dir "$plugin" --permission-mode acceptEdits \
  --allowedTools "Read" "Write" "Edit" "Glob" "Grep" "Edit(.claude/settings.json)" \
    "Bash(git *)" "Bash(wc *)" "Bash(ls *)" "Bash(mkdir *)" "Bash(cat *)" \
  > "$work/claude-$kind.txt" 2>&1 || echo "claude exit: $?"

fail=0
check() { if eval "$2"; then echo "ok    $1"; else echo "FAIL  $1"; fail=1; fi; }
same() { diff -q --strip-trailing-cr "$templates/$1" "$2" > /dev/null 2>&1; }

check "task template matches"       'same task-template.md docs/tasks/_TEMPLATE.md'
check "backlog matches"             'same BACKLOG.md docs/tasks/BACKLOG.md'
check "runbooks README matches"     'same runbooks-README.md docs/runbooks/README.md'
check "runbook template matches"    'same runbook-template.md docs/runbooks/_TEMPLATE.md'
check "roadmap written"             '[ -f docs/ROADMAP.md ]'
check "process log has setup row"   'grep -q "| setup |" docs/PROCESS-LOG.md'
check "CLAUDE.md has How we work"   'grep -q "^## How we work" CLAUDE.md'
check "CLAUDE.md under 200 lines"   '[ "$(wc -l < CLAUDE.md)" -lt 200 ]'
check "no placeholders left"        '! grep -q "{{" CLAUDE.md docs/ROADMAP.md docs/PROCESS-LOG.md'
check "worktrees ignored"           'grep -q "^/.claude/worktrees/" .gitignore'
check "settings content proposed"   'grep -q "baseRef" "$work/claude-$kind.txt"'
check "nothing committed"           '[ "$(git rev-list --count HEAD)" -eq 1 ]'
if [ "$kind" = existing ]; then
  check "tracked files: additions only" '[ -z "$(git diff --numstat | awk "\$2 != 0")" ]'
  check "existing section kept"         'grep -q "^## Conventions" CLAUDE.md && grep -q "Keep this line" CLAUDE.md'
  check "settings file untouched"       'git diff --quiet -- .claude/settings.json'
fi
echo "CLAUDE.md: $(wc -l < CLAUDE.md) lines"
exit $fail
