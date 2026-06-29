# Engineering Roadmap

Living roadmap for the Timeless Hayoka portfolio — not a feature wish list, but **what phase we are in**, **what ships next**, and **what we deliberately defer**.

Companion docs:

- [ARCHITECTURE.md](ARCHITECTURE.md) — canonical ownership, data flow, merge policy
- [docs/REPO_CONSOLIDATION_PLAN.md](docs/REPO_CONSOLIDATION_PLAN.md) — GitHub tiers and archive history

---

## Architecture freeze

**Do not add new top-level repositories** without updating ARCHITECTURE.md and this roadmap.

| Repo | Role |
|------|------|
| **ANCHOR** | Evidence, benchmarks, outcome ledger, trend + strategy engines |
| **AI-Forge-Protocol** | Validation infrastructure, Forge V5 gatekeeper |
| **infj-bot** | Reasoning layer, dashboard, operator interface |
| **timeless-hayoka** | Public documentation and portfolio index |

---

## Phase overview

| Phase | Status | Theme |
|-------|--------|--------|
| **A** | ✅ Complete | Repository consolidation |
| **B** | ✅ Complete | Governance, proof gate, regression reporting |
| **C** | 🟡 In progress | Operational maturity — connect existing components |
| **D** | ⬜ Planned | Corpus expansion after learning loop is credible |

---

## Phase C progress

| Deliverable | Status |
|-------------|:------:|
| Canonical trend engine (`anchor_trends.py`) | ✅ |
| CLI trends (`anchor benchmark trends`) | ✅ |
| HTTP trends (`/api/anchor/benchmark/trends`) | ✅ |
| Snapshot integration (`benchmark_trends`) | ✅ |
| Stability metrics in trends (benchmark + challenge bars) | ✅ |
| Strategy engine (`anchor_strategy.py`) | ✅ |
| CLI strategy (`anchor strategy`) | ✅ |
| HTTP strategy (`/api/anchor/strategy`) | ✅ |
| Enhanced outcome analytics (grouped patterns) | 🟡 |
| Independent reproduction guide | ✅ [ANCHOR/docs/REPRODUCTION.md](https://github.com/timeless-hayoka/ANCHOR/blob/main/docs/REPRODUCTION.md) |
| Dashboard trend visuals (consume API, no local math) | ✅ snapshot panels |

---

## Recommended build order

1. ✅ **Canonical trend engine** — single source for historical comparison
2. ✅ **`anchor strategy`** — consumes trends + ledger; never recomputes trends
3. 🟡 **Outcome insights** — grouped failure patterns + recommendations (partial)
4. ✅ **Independent reproduction guide** — validate on clean machine/container (doc shipped; external validation pending)
5. ⏳ **Dashboard visuals** — read `benchmark_trends` / `benchmark_strategy` from API
6. ⬜ **Phase D** — new benchmark families only after Phase C exit criteria

---

## Phase C exit criteria

- [x] Benchmark trends implemented and exposed (CLI + HTTP + snapshot)
- [x] Strategy recommendations implemented (CLI + HTTP + snapshot)
- [x] Stability surfaced in trend output
- [ ] Outcome insights surfaces recurring causes with evidence links (grouping shipped; ledger lessons still sparse)
- [ ] Independent install guide verified without prior `/home/crexs` layout
- [ ] Dashboard surfaces trends/strategy read-only from ANCHOR API
- [ ] ARCHITECTURE.md and ANCHOR README agree on CLI/API surface

---

## Dependency graph (Phase C)

```text
anchor_trends.py
        │
        ├──────── anchor benchmark trends (CLI)
        ├──────── /api/anchor/benchmark/trends
        ├──────── snapshot.benchmark_trends
        │
        └──────── anchor_strategy.py
                    │
                    ├──────── anchor strategy (CLI)
                    ├──────── /api/anchor/strategy
                    └──────── snapshot.benchmark_strategy
```

Strategy **consumes** `compute_benchmark_trends()` and `load_outcome_entries()` — it does not duplicate trend math.

---

## Phase D ⬜ — After Phase C

- Additional benchmark families (Ethernaut, DeFiHackLabs, ScaBench expansion)
- Cross-benchmark analytics
- Adaptive prioritization in Trinity (consume ANCHOR strategy JSON)

---

## Branch policy

- **Active development:** `infj-bot` branch `anchor`
- **Release to `master`:** [ARCHITECTURE.md merge checklist](ARCHITECTURE.md#branch-policy-anchor-vs-master)

---

## Retired local directories

Hold until ~2026-07-11, then delete if nothing breaks:

| Retired | Canonical |
|---------|-----------|
| `/home/crexs/infj-bot.retired.20260627` | `/home/crexs/infj_bot` |
| `/home/crexs/ai_forge_protocol.retired.20260627` | `/home/crexs/AI-Forge-Protocol` |

---

*Last updated: 2026-06-27 — strategy engine shipped; connecting components is Phase C focus.*
