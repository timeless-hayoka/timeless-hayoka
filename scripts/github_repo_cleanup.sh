#!/usr/bin/env bash
# GitHub hygiene: archive upstream forks under timeless-hayoka account.
set -euo pipefail

DRY_RUN=1
ARCHIVE_FORKS=0

usage() {
  echo "Usage: $0 [--dry-run] [--archive-forks]"
  exit 1
}

for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --archive-forks) ARCHIVE_FORKS=1; DRY_RUN=0 ;;
    -h|--help) usage ;;
    *) echo "Unknown: $arg"; usage ;;
  esac
done

FORKS=(
  Atomic-Chat
  awesome-cognitive-sciencephi
  damn-vulnerable-defi
  langgraphphi
  openzeppelin-contracts
  silo-contracts-v3
  solady
  solmate
  v4-core
)

echo "=== Fork archive plan ==="
for repo in "${FORKS[@]}"; do
  if [[ "$ARCHIVE_FORKS" -eq 1 ]]; then
    echo "Archiving timeless-hayoka/${repo}..."
    gh repo archive "timeless-hayoka/${repo}" --yes
  else
    echo "[dry-run] would archive timeless-hayoka/${repo}"
  fi
done

if [[ "$ARCHIVE_FORKS" -eq 0 ]]; then
  echo
  echo "Dry run only. Re-run with --archive-forks to execute."
fi
