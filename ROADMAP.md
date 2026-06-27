# Engineering Roadmap

Living roadmap for the Timeless Hayoka portfolio — not a feature wish list, but **what phase we are in**, **what ships next**, and **what we deliberately defer**.

Companion docs:

- [ARCHITECTURE.md](ARCHITECTURE.md) — canonical ownership, data flow, merge policy
- [docs/REPO_CONSOLIDATION_PLAN.md](docs/REPO_CONSOLIDATION_PLAN.md) — GitHub tiers and archive history

---

## Architecture freeze

**Do not add new top-level repositories** without updating ARCHITECTURE.md and this roadmap.

Current boundaries are sufficient:

| Repo | Role |
|------|------|
| **ANCHOR** | Evidence, benchmarks, outcome ledger, trend engine |
| **AI-Forge-Protocol** | Validation infrastructure, Forge V5 gatekeeper |
| **infj-bot** | Reasoning layer, dashboard, operator interface |
| **timeless-hayoka** | Public documentation and portfolio index |

Every additional repo increases coordination overhead. New capabilities belong in one of these four unless there is an exceptional, documented reason.

---

## Phase overview

| Phase | Status | Theme |
|-------|--------|--------|
| **A** | ✅ Complete | Repository consolidation (GitHub hygiene, archives, branch cleanup) |
| **B** | ✅ Complete | Proof gate, outcome ledger, regression reporting, governance docs |
| **C** | 🟡 In progress | Operational maturity — learning loop before corpus expansion |
| **D** | ⬜ Planned | Cross-benchmark analytics, adaptive prioritization, new benchmark families |

---

## Phase A ✅ — Done when

- [x] Tier 2 upstream forks archived on GitHub
- [x] **infj-bot** default branch → `anchor`
- [x] Stale agent branches pruned
- [x] One canonical local tree per core repo documented

---

## Phase B ✅ — Done when

- [x] [ARCHITECTURE.md](ARCHITECTURE.md) published (ownership, diagrams, merge policy)
- [x] ANCHOR publish flow + regression reports (`REGRESSION_REPORT.md`)
- [x] Outcome ledger CLI (`anchor outcome history|summary|insights|add`)
- [x] Duplicate local dirs verified and retired (`.retired.20260627`)
- [x] `anchor` → `master` merge gated by objective checklist

---

## Phase C 🟡 — Operational maturity

**Goal:** Close the feedback loop from benchmark to strategy **using existing benchmark families** before adding corpus surface area.

```text
Benchmark  →  Regression  →  Outcome  →  Insight  →  Strategy
   │              │              │           │            │
What happened?  What changed?  Result?    Why?      What next?
```

### Principle: learning loop before expansion

Existing methodology surface is enough for Phase C:

- DVD (Damn Vulnerable DeFi)
- Ethernaut scaffold
- ScaBench
- DeFiHackLabs scaffold

**Do not add new benchmark families until Phase C exit criteria are met.**

### Canonical trend engine

Historical comparison lives in **`ANCHOR/anchor_trends.py`** — one module, multiple consumers:

| Consumer | Interface |
|----------|-----------|
| CLI | `anchor benchmark trends` (`--json` for machines) |
| HTTP | `GET /api/anchor/benchmark/trends` |
| Snapshot | `benchmark_trends` field in `/api/anchor/snapshot` |
| Strategy (planned) | imports `compute_benchmark_trends` — no duplicate math |
| Dashboard (planned) | read-only from API or JSON — no local recompute |

### Priority order

| Priority | Deliverable | Status |
|----------|-------------|--------|
| 1 ⭐ | `anchor benchmark trends` | ✅ Implemented (`anchor_trends.py`) |
| 2 ⭐ | `anchor strategy` | ⬜ Planned (consumes trends + outcome ledger) |
| 3 | Expand `anchor outcome insights` | 🟡 Partial |
| 4 | Independent reproduction guide | ⬜ Planned |

Example target for `anchor strategy`:

```text
Highest ROI Next Hunt

Wallet Mining

Reason

Repeated timeout

Expected payoff

Completes DVD Phase 1 benchmark

Confidence

High
```

### Phase C exit criteria (objective)

- [x] Benchmark trends implemented (`anchor_trends.py` + CLI + HTTP)
- [ ] Strategy recommendations implemented (`anchor strategy`)
- [ ] Outcome insights expanded (recurring causes with evidence links, not just counts)
- [ ] Independent install guide verified on clean machine (no prior `/home/crexs` layout)
- [ ] Dashboard surfaces trend information (read-only from trend API)
- [ ] CLI and README document trends + strategy surface
- [ ] ARCHITECTURE.md agrees with shipped CLI/API

---

## Phase D ⬜ — Done when

- [ ] Phase C exit criteria all checked
- [ ] Additional benchmark families beyond current scaffolds
- [ ] Cross-benchmark analytics (shared failure modes across families)
- [ ] Adaptive hunt prioritization integrated with Trinity
- [ ] Shared library extraction per [REPO_CONSOLIDATION_PLAN.md](docs/REPO_CONSOLIDATION_PLAN.md)

---

## Branch and release policy

- **Active development:** `infj-bot` branch `anchor` (GitHub default)
- **Release to `master`:** only when [ARCHITECTURE.md merge checklist](ARCHITECTURE.md#branch-policy-anchor-vs-master) is satisfied
- **Portfolio docs:** `timeless-hayoka` `main` is the index; update this file when a phase completes

---

## Retired local directories

Renamed 2026-06-27 after `verify_duplicate_repo_deps.sh` passed. **Hold ~2 weeks**, then delete if nothing breaks:

| Retired path | Canonical replacement |
|--------------|----------------------|
| `/home/crexs/infj-bot.retired.20260627` | `/home/crexs/infj_bot` |
| `/home/crexs/ai_forge_protocol.retired.20260627` | `/home/crexs/AI-Forge-Protocol` |

---

*Last updated: 2026-06-27 — Phase C started; trend engine shipped.*
