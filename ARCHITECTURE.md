# Portfolio Architecture

Definitive reference for **where code lives**, **how data flows**, and **who owns what**. Read this before adding a feature, copying a script, or deleting a local directory.

Related docs:

- [REPO_CONSOLIDATION_PLAN.md](docs/REPO_CONSOLIDATION_PLAN.md) — GitHub tiers, archive list, phase history
- [SCRIPT_REUSE_MAP.md](docs/SCRIPT_REUSE_MAP.md) — script-level extraction map

---

## Canonical components

Each capability has **one owner repo**. Do not re-implement in a sibling repo; import, call, or document a dependency instead.

### ANCHOR

**GitHub:** [timeless-hayoka/ANCHOR](https://github.com/timeless-hayoka/ANCHOR)  
**Local:** `/home/crexs/ANCHOR`

| Owns | Does not own |
|------|----------------|
| Benchmark framework (DVD, Ethernaut, SCabench adapters) | Trinity chat / companion UI |
| Outcome ledger and case artifacts | Forge syntax gatekeeper |
| Evidence lifecycle (claim → reproduce → sign) | Long-term knowledge corpus storage |
| `anchor_cli.py`, `anchor_server.py`, `anchor_storage.py` | Dashboard front-end (lives in infj-bot) |

**External data:** benchmark corpora under `ANCHOR/benchmarks/`; archived outcomes on `ANCHOR_DATA_ROOT` / AnchorVault when configured.

---

### AI-Forge-Protocol

**GitHub:** [timeless-hayoka/AI-Forge-Protocol](https://github.com/timeless-hayoka/AI-Forge-Protocol)  
**Local:** `/home/crexs/AI-Forge-Protocol`

| Owns | Does not own |
|------|----------------|
| Forge validation harness (`src/forge_harness.py`) | Trinity caseflow / ANCHOR ledger |
| **Forge V5 gatekeeper** (`src/forge_v5_gatekeeper.py`, `scripts/forge_v5_gatekeeper.py`) | ANCHOR benchmark runners |
| Testforge / tournament / perturbation pipeline | infj-bot web dashboard |
| Patch-gating and reliability metrics | AnchorVault knowledge files |

**Env:** `AFP_ROOT` → repo root. Consumers (infj-bot) import via `core/forge_gate.py` shim.

---

### infj-bot

**GitHub:** [timeless-hayoka/infj-bot](https://github.com/timeless-hayoka/infj-bot) — default branch **`anchor`**  
**Local:** `/home/crexs/infj_bot` (underscore — canonical)

| Owns | Does not own |
|------|----------------|
| Trinity engine (`drift/trinity/`) | ANCHOR CLI / standalone proof gate |
| Dashboard & HTTP API (`interfaces/api.py`, anchor dashboard) | Forge V5 gatekeeper implementation |
| CLI / TUI / companion runtime | AI-Forge tournament harness |
| Knowledge integration (AnchorVault paths, Chroma, vault search) | Raw benchmark fixture repos (ANCHOR) |
| MCP tools (`core/mcp_server.py`) | Outcome ledger schema (ANCHOR + Trinity share; ANCHOR is source for benchmark runs) |

**Env:** `ANCHOR_DATA_ROOT`, `ANCHOR_VAULT_ROOT`, `DRIFT_ROOT` / `INFJ_BOT_ROOT`, `AFP_ROOT`.

**Legacy docs:** private drift repos merged under `docs/legacy/` (read-only archive).

---

## Supporting repos (thin, no overlap with core trio)

| Repo | Role |
|------|------|
| [LOTUS-ACADEMY](https://github.com/timeless-hayoka/LOTUS-ACADEMY) | Training UI and labs |
| [bounty-bot](https://github.com/timeless-hayoka/bounty-bot) | Bounty workflow + fidelity runner |
| [cyber-tools](https://github.com/timeless-hayoka/cyber-tools) | Small scoped utilities |
| [llm-minify](https://github.com/timeless-hayoka/llm-minify) | Prompt/token minimization |
| [crex](https://github.com/timeless-hayoka/crex) | Cognitive middleware hooks consumed by infj-bot |

---

## Dependency diagram

```mermaid
flowchart TB
  subgraph storage [External storage]
    AV[AnchorVault on ANCHOR_DATA_ROOT]
    AL[ANCHOR archive / ledger paths]
  end

  subgraph anchor [ANCHOR]
    AB[Benchmark framework]
    OL[Outcome ledger]
    EL[Evidence lifecycle]
  end

  subgraph afp [AI-Forge-Protocol]
    FG[Forge V5 gatekeeper]
    FH[Forge harness / Testforge]
  end

  subgraph drift [infj-bot]
    TE[Trinity engine]
    DB[Dashboard / API]
    CLI[CLI / MCP]
    KS[Knowledge system]
  end

  AB --> OL
  OL --> EL
  EL --> AL
  FH --> FG
  TE --> FG
  TE --> OL
  DB --> TE
  CLI --> TE
  KS --> AV
  DB --> AV
  AB -.->|benchmark fixtures| AB
  drift -->|AFP_ROOT import| afp
  anchor -.->|case export format| drift
```

---

## Data flow

```mermaid
flowchart LR
  signal[Tool / model signal]
  bench[ANCHOR benchmark run]
  case[Trinity case + ledger]
  forge[AI-Forge validation]
  vault[AnchorVault knowledge]
  ui[infj-bot dashboard / chat]

  signal --> bench
  bench --> case
  case --> forge
  forge -->|pass / fail gate| case
  vault --> ui
  case --> ui
  ui -->|vault_knowledge_search| vault
```

1. **Benchmark** — ANCHOR runs authorized corpora; writes structured outcomes.
2. **Case** — Trinity ingests evidence, DMU scoring, council/forge schema (infj-bot).
3. **Validation** — AI-Forge-Protocol gatekeeper checks generated code before promotion.
4. **Knowledge** — AnchorVault on disk; infj-bot resolves paths via `config_adapter` / `anchor_context`.
5. **Surface** — Dashboard and chat expose snapshot, paths, and search (port 8765 by default).

---

## Ownership rules

1. **One home per feature** — If it appears in two repos, delete the copy or replace with an import + link in ARCHITECTURE.md.
2. **ANCHOR owns proof** — Anything that must be reproducible for security research outcomes lives in or is invoked by ANCHOR.
3. **AI-Forge owns gates** — Syntax validation, harness tournaments, and patch-gating metrics stay in AFP.
4. **infj-bot owns experience** — UI, agent loop, memory, MCP, Trinity orchestration stay in infj-bot.
5. **No hardcoded `/home/crexs/...` paths** — Use `AFP_ROOT`, `DRIFT_ROOT`, `ANCHOR_DATA_ROOT`, or package install.
6. **Vault is not git** — Knowledge corpus and Chroma data live on `ANCHOR_DATA_ROOT`; never commit them.
7. **Legacy is read-only** — `docs/legacy/` in infj-bot is archive; new docs go in active trees.

---

## Canonical local paths

| GitHub repo | Canonical directory | Retire (do not delete until verified) |
|-------------|---------------------|-------------------------------------|
| infj-bot | `/home/crexs/infj_bot` | `/home/crexs/infj-bot` |
| AI-Forge-Protocol | `/home/crexs/AI-Forge-Protocol` | `/home/crexs/ai_forge_protocol` |
| ANCHOR | `/home/crexs/ANCHOR` | — |
| LOTUS-ACADEMY | `/home/crexs/LOTUS-ACADEMY` (prefer clean tree) | `/home/crexs/lotus-academy` if bloated |

Run dependency check before removing a duplicate tree:

```bash
./scripts/verify_duplicate_repo_deps.sh
```

---

## Branch policy: `anchor` vs `master`

**Default branch on GitHub:** `anchor` (active development).

**Do not merge `anchor` → `master` until all are true:**

- [ ] CI / pytest green on `anchor` (excluding known flaky/integration skips)
- [ ] README and quickstart match running behavior (vault paths, ports, env vars)
- [ ] No debug artifacts staged (logs, `.benchmarks/`, venv, ablation dumps)
- [ ] No experimental code without feature flag or doc callout
- [ ] ARCHITECTURE.md and repo READMEs agree on ownership

If any item fails, keep maturing on `anchor`. Merging is a release decision, not a hygiene shortcut.

---

## Phase C — Operational maturity

Next major milestone: closed loop from benchmark to strategy.

```mermaid
flowchart TB
  B[Benchmark]
  R[Regression]
  O[Outcome]
  I[Insight]
  S[Strategy]

  B --> R --> O --> I --> S
  S -.->|prioritize next hunt| B
```

| Stage | Owner | Deliverable |
|-------|-------|-------------|
| **Benchmark** | ANCHOR | Historical trend store; DVD → Ethernaut → additional families |
| **Regression** | ANCHOR + AFP | Re-run gate on prior cases; fail on drift |
| **Outcome** | ANCHOR + infj-bot | Automatic outcome analytics from ledger |
| **Insight** | infj-bot | Learning-based hunt prioritization from vault + cases |
| **Strategy** | Portfolio | Independent install/repro guide; one-command demo |

Concrete Phase C tasks:

1. **Historical benchmark trends** — timestamped runs under ANCHOR; chart pass/fail over time.
2. **Automatic outcome analytics** — aggregate Trinity/ANCHOR ledger JSONL into summary reports.
3. **Hunt prioritization** — rank targets from outcomes + vault signals (infj-bot / Trinity).
4. **Install guide** — single doc: ANCHOR + infj-bot + AFP + vault mount, verified on clean machine.
5. **Benchmark expansion** — DVD (done path) → Ethernaut → next family with same adapter pattern.

---

## When in doubt

| Question | Answer |
|----------|--------|
| Where does a new benchmark adapter go? | ANCHOR |
| Where does syntax validation for LLM output go? | AI-Forge-Protocol |
| Where does a dashboard panel go? | infj-bot |
| Can I copy `forge_v5_gatekeeper.py`? | No — depend on AFP |
| Which infj-bot folder is canonical? | `infj_bot` with underscore |
| Safe to delete `infj-bot/` duplicate? | Only after `verify_duplicate_repo_deps.sh` is clean |

---

*Last updated: 2026-06-27 — portfolio consolidation Phase B complete.*
