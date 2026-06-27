#!/usr/bin/env bash
# Audit timeless-hayoka GitHub repos: forks, sizes, stale branches, local duplicates.
set -euo pipefail

OUT="${1:-docs/REPO_AUDIT_LATEST.md}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

mkdir -p docs

{
  echo "# Repo audit — $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo
  echo "## GitHub (timeless-hayoka)"
  echo
  echo "| Repo | Fork | KB | Updated | Action |"
  echo "|------|------|-----|---------|--------|"

  gh repo list timeless-hayoka --limit 100 --json name,isFork,diskUsage,updatedAt,url \
    | python3 -c "
import json, sys
repos = json.load(sys.stdin)
TIER1 = {
  'ANCHOR','infj-bot','AI-Forge-Protocol','LOTUS-ACADEMY','bounty-bot',
  'cyber-tools','llm-minify','crex','ebpHphi','timeless-hayoka'
}
for r in sorted(repos, key=lambda x: x['name']):
    name = r['name']
    fork = r.get('isFork')
    kb = r.get('diskUsage') or 0
    upd = (r.get('updatedAt') or '')[:10]
    if fork:
        action = 'archive fork'
    elif name in TIER1:
        action = 'keep / finish'
    elif name.startswith('drift') or name in {'Phi','apex-mothership','jarvis-omega'}:
        action = 'merge → infj-bot, archive'
    else:
        action = 'review / likely archive'
    print(f\"| [{name}]({r['url']}) | {'yes' if fork else 'no'} | {kb} | {upd} | {action} |\")
"

  echo
  echo "## infj-bot branches (count)"
  echo
  BR_COUNT=$(gh api repos/timeless-hayoka/infj-bot/branches --paginate --jq 'length' 2>/dev/null || echo "?")
  echo "- Total branches: **${BR_COUNT}** (recommend: default \`anchor\`, delete stale \`cursor/*\`)"
  echo
  echo "## Local duplicate trees"
  echo
  echo "| Path | Remote | Branch | Size |"
  echo "|------|--------|--------|------|"

  for d in \
    /home/crexs/infj_bot \
    /home/crexs/infj-bot \
    /home/crexs/lotus-academy \
    /home/crexs/LOTUS-ACADEMY \
    /home/crexs/AI-Forge-Protocol \
    /home/crexs/ai_forge_protocol; do
    if [[ -d "$d/.git" ]]; then
      remote=$(git -C "$d" remote get-url origin 2>/dev/null || echo "-")
      branch=$(git -C "$d" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "-")
      size=$(du -sh "$d" 2>/dev/null | cut -f1)
      echo "| \`$d\` | \`$remote\` | $branch | $size |"
    fi
  done

  echo
  echo "## Next commands"
  echo
  echo '```bash'
  echo "./scripts/github_repo_cleanup.sh --dry-run"
  echo "./scripts/github_repo_cleanup.sh --archive-forks"
  echo 'gh api -X PATCH repos/timeless-hayoka/infj-bot -f default_branch=anchor'
  echo '```'
} > "$OUT"

echo "Wrote $OUT"
