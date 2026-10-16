#!/bin/sh
# Run both setup trials and report each exit code.
#
# Usage: tools/run-trials.sh <scratch dir>
#
# Runs tools/trial-setup.sh fresh and existing, each writing its summary to
# <scratch dir>/<kind>/summary-<kind>.txt, then prints the summaries and a `<kind> exit=` line for
# each. Exit code 0 means both trials passed. One plain command, so its exit code can't be hidden by
# a pipe and worktree isolation has no compound command to refuse.
here="$(cd "$(dirname "$0")/.." && pwd)"
scratch="$1"
[ -n "$scratch" ] || { echo "usage: $0 <scratch dir>" >&2; exit 2; }

fail=0
for kind in fresh existing; do
  dir="$scratch/$kind"
  rm -rf "$dir"; mkdir -p "$dir"
  sh "$here/tools/trial-setup.sh" "$dir" "$kind" > "$dir/summary-$kind.txt"
  code=$?
  cat "$dir/summary-$kind.txt"
  echo "$kind exit=$code"
  [ "$code" -eq 0 ] || fail=1
done
exit $fail
