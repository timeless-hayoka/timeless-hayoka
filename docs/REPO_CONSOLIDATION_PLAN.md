# GitHub Repo Consolidation Plan

Goal: fewer, **finished** public repos by archiving noise, deduplicating local copies, and moving reusable scripts into the repos that actually ship.

## Tier 1 — Ship these (keep active)

| Repo | Role | Finish line |
|------|------|-------------|
| [ANCHOR](https://github.com/timeless-hayoka/ANCHOR) | Flagship proof gate | Stable CLI + server + benchmark adapters |
| [infj-bot](https://github.com/timeless-hayoka/infj-bot) | Drift / companion runtime | `anchor` branch → default; trim dev branches |
| [AI-Forge-Protocol](https://github.com/timeless-hayoka/AI-Forge-Protocol) | Patch / cognitive validation harness | Extract hardcoded paths; publish forge adapters only |
| [LOTUS-ACADEMY](https://github.com/timeless-hayoka/LOTUS-ACADEMY) | Security training UI | Canonical copy is `lotus-academy/` locally (sync to GitHub) |
| [bounty-bot](https://github.com/timeless-hayoka/bounty-bot) | Bounty workflow + fidelity runner | Keep `scripts/` only; drop vendored forge-std test env from git |
| [cyber-tools](https://github.com/timeless-hayoka/cyber-tools) | Scoped recon utilities | Thin bin/ + README; no large dumps |
| [llm-minify](https://github.com/timeless-hayoka/llm-minify) | Token/prompt minimization | Package + harness; wire into infj-bot as optional dep |
| [crex](https://github.com/timeless-hayoka/crex) | Cognitive middleware hooks | Merge drift-specific hooks into infj-bot over time |
| [ebpHphi](https://github.com/timeless-hayoka/ebpHphi) | eBPF prototype | Keep if still referenced; else archive |
| [timeless-hayoka](https://github.com/timeless-hayoka/timeless-hayoka) | Portfolio hub | This doc + audit scripts |

## Tier 2 — Archive on GitHub (upstream forks)

These are **forks** of upstream projects. They add maintenance noise and duplicate what Foundry/npm already vendored locally. Archive them; link upstream in ANCHOR benchmarks instead.

- Atomic-Chat (fork — use upstream or a thin integration repo)
- awesome-cognitive-sciencephi
- damn-vulnerable-defi
- langgraphphi
- openzeppelin-contracts
- silo-contracts-v3
- solady
- solmate
- v4-core

Run (dry-run first):

```bash
./scripts/github_repo_cleanup.sh --dry-run
./scripts/github_repo_cleanup.sh --archive-forks
```

## Tier 3 — Private / stale (merge then archive)

| Repo | Action |
|------|--------|
| drift, drift-engine, drift-wiki, drift-aiprm-prompt | Merge docs + prompts into infj-bot; archive private repos |
| Phi | Merge identity/prompt assets into infj-bot or ANCHOR docs |
| apex-*, jarvis-omega, stim-flow*, cyber-shadows, whitehatthings | Archive unless actively developed this quarter |
| archer-firmware-lab, samsung-flipper-mastery, pure-ftpd | Archive — hardware/FTP experiments, not portfolio core |

## Local duplicates (pick one canonical tree)

| GitHub | Canonical local path | Notes |
|--------|---------------------|-------|
| infj-bot | `/home/crexs/infj_bot` | **`anchor` branch** is live dev (7GB with venv — never push venv) |
| infj-bot (stale) | `/home/crexs/infj-bot` | 15MB snapshot on `master`; retire after default branch switch |
| LOTUS-ACADEMY | `/home/crexs/lotus-academy` | Has build artifacts; sync clean tree to GitHub |
| LOTUS-ACADEMY (clean) | `/home/crexs/LOTUS-ACADEMY` | 1.2MB — closer to what GitHub should look like |
| AI-Forge-Protocol | `/home/crexs/AI-Forge-Protocol` | Push from here (18MB) |
| AI-Forge-Protocol (bloated) | `/home/crexs/ai_forge_protocol` | 5GB venv — delete local copy after sync |

## Never push to GitHub

- `venv/`, `.venv/`, `node_modules/`
- `chroma_db/`, `logs/`, `ABLATION_RESULTS/`, benchmark run outputs
- `AnchorVault/` knowledge corpus ( lives on `/mnt/anchor-hdd` )
- `.env`, keys, `*.deb`, voice packs, HF caches

## Reuse map (where scripts land)

See [SCRIPT_REUSE_MAP.md](./SCRIPT_REUSE_MAP.md).

## Execution phases

### Phase A — GitHub hygiene (1 hour)

1. Archive Tier 2 forks (`github_repo_cleanup.sh`)
2. Set **infj-bot** default branch to `anchor`
3. Delete stale `cursor/*` and `claude/*` branches on infj-bot (keep `anchor`, `main`/`master` until merged)
4. Add/update `.gitignore` on every Tier 1 repo

### Phase B — Canonical sync (1–2 days)

1. Push infj_bot `anchor` → infj-bot (no venv)
2. Merge lotus-academy useful `src/` into LOTUS-ACADEMY; drop node_modules from git
3. Point AI-Forge-Protocol imports at installable `drift` package path, not `/home/crexs`

### Phase C — Extract shared libraries (ongoing)

1. **forge-gate** — move `forge_v5_gatekeeper.py` from infj_bot → AI-Forge-Protocol (or shared `timeless-hayoka/tools/`)
2. **anchor-cli** — ANCHOR already owns `anchor_cli.py`; infj_bot scripts call it, don’t duplicate
3. **llm-minify** — optional dependency in infj-bot prompt builder
4. **bounty fidelity** — `fidelity_runner.py` consumed by ANCHOR case export format

### Phase D — Finish lines

- ANCHOR: README quickstart + one benchmark path green in CI
- infj-bot: ANCHOR vault context + `/api/anchor/snapshot` documented
- LOTUS-ACADEMY: single-command dev server
- bounty-bot: one Immunefi workflow script documented end-to-end

## Audit

```bash
./scripts/github_repo_audit.sh
```

Generates `docs/REPO_AUDIT_LATEST.md` with sizes, fork status, and recommended actions.
