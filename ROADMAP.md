# Engineering Roadmap

Living roadmap for the Timeless Hayoka portfolio — not a feature wish list, but **what phase we are in**, **what ships next**, and **what we deliberately defer**.

Companion docs:

- [ARCHITECTURE.md](ARCHITECTURE.md) — canonical ownership, data flow, merge policy
- [docs/REPO_CONSOLIDATION_PLAN.md](docs/REPO_CONSOLIDATION_PLAN.md) — GitHub tiers and archive history

---

## Phase overview

| Phase | Status | Theme |
|-------|--------|--------|
| **A** | ✅ Complete | Repository consolidation (GitHub hygiene, archives, branch cleanup) |
| **B** | ✅ Complete | Proof gate, outcome ledger, regression reporting, governance docs |
| **C** | 🟡 In progress | Operational maturity — learning loop before corpus expansion |
| **D** | ⬜ Planned | Cross-benchmark analytics, adaptive prioritization, new benchmark families |

---

## Phase A ✅ — Repository consolidation

**Goal:** One canonical tree per repo; noise archived; default branches sane.

Delivered:

- Tier 2 upstream forks archived on GitHub
- **infj-bot** default branch → `anchor`
- Stale `cursor/*` / `claude/*` branches pruned
- Private drift docs merged into `infj_bot/docs/legacy/`
- Forge V5 gatekeeper canonical in **AI-Forge-Protocol**; infj-bot uses shim

---

## Phase B ✅ — Governance and proof surface

**Goal:** Reproducible proof gate with reviewable artifacts and explicit repo boundaries.

Delivered:

- [ARCHITECTURE.md](ARCHITECTURE.md) — responsibilities, dependency diagram, ownership rules
- ANCHOR: benchmark runs, publish flow, regression reports (`REGRESSION_REPORT.md`)
- Outcome ledger CLI (`anchor outcome history|summary|insights|add`)
- Duplicate local dirs verified and retired (`.retired.20260627` suffix; hold ~2 weeks before delete)
- `anchor` → `master` merge gated by objective checklist (not merged until green)

---

## Phase C 🟡 — Operational maturity

**Goal:** Close the feedback loop from benchmark to strategy **using existing benchmark families** before adding more corpus surface area.

```text
Benchmark  →  Regression  →  Outcome  →  Insight  →  Strategy
   │              │              │           │            │
What happened?  What changed?  Result?    Why?      What next?
```

### Principle: learning loop before expansion

ANCHOR already has enough methodology surface:

- DVD (Damn Vulnerable DeFi)
- Ethernaut scaffold
- ScaBench
- DeFiHackLabs scaffold

**Do not add new benchmark families until Phase C deliverables below are credible.** Richer insights from current runs beat a wider but shallow corpus.

### Priority deliverables (ANCHOR-led)

| # | CLI / artifact | Status | Description |
|---|----------------|--------|-------------|
| 1 | `anchor benchmark trends` | ⬜ Planned | Historical pass/fail and timing trends from published runs |
| 2 | `anchor outcome insights` | 🟡 Partial | Exists today; expand beyond counts to recurring causes and actionable lessons |
| 3 | `anchor strategy` | ⬜ Planned | Rank targets by ROI; emit recommendations (timeout, search strategy, skip/retry) |
| 4 | **Independent reproduction guide** | ⬜ Planned | Fresh machine: clone ANCHOR → one published benchmark end-to-end |

Example target output for `anchor strategy`:

```text
Highest ROI benchmark:
  Wallet Mining

Reason:
  Repeated timeout (3/5 runs)

Recommendation:
  Increase timeout to 180s or switch to deterministic search path.
```

### Supporting work (infj-bot + portfolio)

| Deliverable | Owner | Notes |
|-------------|-------|-------|
| Hunt prioritization from vault + cases | infj-bot | Consumes ANCHOR strategy output; does not duplicate ledger |
| Dashboard trend panels | infj-bot | Read-only; ANCHOR remains source of truth |
| `verify_duplicate_repo_deps.sh` in CI habit | timeless-hayoka | Run before any local tree deletion |

### Phase C exit criteria

- [ ] `anchor benchmark trends` produces chartable history from published manifests
- [ ] `anchor outcome insights` surfaces top recurring lessons with evidence links
- [ ] `anchor strategy` emits at least one actionable recommendation from real ledger data
- [ ] Reproduction guide verified on a machine without prior `/home/crexs` layout
- [ ] ARCHITECTURE.md and ANCHOR README agree on CLI surface

---

## Phase D ⬜ — Scale and adapt

**Goal:** Expand corpus and automate prioritization **after** Phase C loop is trustworthy.

Planned:

- Additional benchmark families (beyond DVD / Ethernaut / ScaBench / DeFiHackLabs scaffolds)
- Cross-benchmark analytics (compare families, shared failure modes)
- Adaptive hunt prioritization (learning-based ranking integrated with Trinity)
- Shared library extraction per [REPO_CONSOLIDATION_PLAN.md](docs/REPO_CONSOLIDATION_PLAN.md) Phase D

---

## Branch and release policy

- **Active development:** `infj-bot` branch `anchor` (GitHub default)
- **Release to `master`:** only when [ARCHITECTURE.md merge checklist](ARCHITECTURE.md#branch-policy-anchor-vs-master) is satisfied
- **Portfolio docs:** `timeless-hayoka` `main` is the index; update ROADMAP when a phase completes

---

## Retired local directories

Renamed 2026-06-27 after `verify_duplicate_repo_deps.sh` passed. **Hold ~2 weeks**, then delete if nothing breaks:

| Retired path | Canonical replacement |
|--------------|----------------------|
| `/home/crexs/infj-bot.retired.20260627` | `/home/crexs/infj_bot` |
| `/home/crexs/ai_forge_protocol.retired.20260627` | `/home/crexs/AI-Forge-Protocol` |

---

*Last updated: 2026-06-27*
