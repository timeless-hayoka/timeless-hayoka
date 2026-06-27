#!/usr/bin/env bash
# Scan active code trees for references to duplicate local repo paths before removal.
set -euo pipefail

ROOT="${1:-/home/crexs}"
CANONICAL_INFJ="/home/crexs/infj_bot"
CANONICAL_AFP="/home/crexs/AI-Forge-Protocol"
DUPLICATE_INFJ="/home/crexs/infj-bot"
DUPLICATE_AFP="/home/crexs/ai_forge_protocol"
RETIRED_INFJ="/home/crexs/infj-bot.retired.20260627"
RETIRED_AFP="/home/crexs/ai_forge_protocol.retired.20260627"

# Only scan paths that could break if duplicates are removed (not docs/transcripts).
SCAN_PATHS=(
  "$ROOT/ANCHOR"
  "$ROOT/infj_bot"
  "$ROOT/AI-Forge-Protocol"
  "$ROOT/bounty-bot"
  "$ROOT/cyber-tools"
  "$ROOT/LOTUS-ACADEMY"
  "$ROOT/upgrade_all_repos.sh"
  "$ROOT/phi_launcher.py"
)

echo "=== Duplicate repo dependency check ==="
echo "Canonical:  infj_bot=$CANONICAL_INFJ  AFP=$CANONICAL_AFP"
if [[ -d "$DUPLICATE_INFJ" || -d "$DUPLICATE_AFP" ]]; then
  echo "Duplicates: infj-bot=$DUPLICATE_INFJ  ai_forge_protocol=$DUPLICATE_AFP"
else
  echo "Duplicates: (renamed — see ROADMAP.md retired paths)"
  [[ -d "$RETIRED_INFJ" ]] && echo "  retired infj-bot: $RETIRED_INFJ"
  [[ -d "$RETIRED_AFP" ]] && echo "  retired ai_forge: $RETIRED_AFP"
fi
echo

FOUND=0
scan_path() {
  local label="$1"
  local path="$2"
  echo "--- References to $label ---"
  local hits=""
  for scan in "${SCAN_PATHS[@]}"; do
    [[ -e "$scan" ]] || continue
    part=$(rg -l --glob '!.git' --glob '!venv' --glob '!.venv' --glob '!node_modules' \
      -F "$path" "$scan" 2>/dev/null || true)
    hits+=$'\n'"$part"
  done
  hits=$(echo "$hits" | sed '/^$/d' | sort -u)
  if [[ -z "$hits" ]]; then
    echo "  (none in active trees)"
  else
    FOUND=1
    echo "$hits" | while read -r f; do
      [[ -n "$f" ]] || continue
      echo "  $f"
      rg -n -F "$path" "$f" 2>/dev/null | head -3 | sed 's/^/    /'
    done
  fi
  echo
}

scan_path "DUPLICATE infj-bot" "$DUPLICATE_INFJ"
scan_path "DUPLICATE ai_forge_protocol" "$DUPLICATE_AFP"

if [[ "$FOUND" -eq 0 ]]; then
  echo "✅ No active code depends on duplicate trees."
  if [[ -d "$DUPLICATE_INFJ" || -d "$DUPLICATE_AFP" ]]; then
    echo "Safe to retire after spot-check (rename, do not rm -rf):"
    echo "  mv $DUPLICATE_INFJ ${DUPLICATE_INFJ}.retired.$(date +%Y%m%d)"
    echo "  mv $DUPLICATE_AFP ${DUPLICATE_AFP}.retired.$(date +%Y%m%d)"
  else
    echo "Retired trees on disk; hold ~2 weeks before rm -rf (see ROADMAP.md)."
  fi
  exit 0
fi

echo "⚠️  Fix references above before removing duplicate directories."
exit 1
