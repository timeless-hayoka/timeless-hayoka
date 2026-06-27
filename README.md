# Timeless Hayoka

I build evidence gates for AI and security workflows.

The pattern is simple: take a claim, run it through a reproducible harness, and promote it only when the evidence holds. Proof before ship. If it cannot be rerun, reviewed, or signed, it is not done yet.

## Flagship: ANCHOR

ANCHOR is the flagship because it has the clearest audience and the most finished artifact: a local-first proof gate for authorized smart-contract security research.

It turns raw tool signal into a structured case and keeps the full trail:

- `seeded false claim` -> rejected with `REJECTED - INSUFFICIENT EVIDENCE`
- `FIXTURE CORPUS - REAL TOOL EXECUTION` -> reproducible specimen run
- `REPRODUCED_REAL` -> a Foundry proof actually runs against the target
- `NEGATIVE_CONTROL_PASSED` -> the control stayed clean without pretending it was tested

ANCHOR is built to leave behind a reviewable artifact, not just a verdict:

- source
- evidence
- failed attempts
- successful reproduction
- remediation

That is the public story I want to be known for: signal to evidence, not signal to hype.

Visible repo:

- [ANCHOR](https://github.com/timeless-hayoka/ANCHOR)

## Supporting Work

These projects are all variations of the same core idea, applied in different places:

- [AI-Forge-Protocol](https://github.com/timeless-hayoka/AI-Forge-Protocol) - validation and patch-gating for safer iterative code changes
- [bounty-bot](https://github.com/timeless-hayoka/bounty-bot) - evidence tracking and structured bug bounty workflow
- [infj-bot](https://github.com/timeless-hayoka/infj-bot) - companion reasoning layer and internal AI workflow surface
- [LOTUS-ACADEMY](https://github.com/timeless-hayoka/LOTUS-ACADEMY) - hands-on security training and operator practice
- [cyber-tools](https://github.com/timeless-hayoka/cyber-tools) - scoped utilities for research and validation

ANCHOR is the cockpit. The other repos are proof that the idea generalizes.

## Repo cleanup

**Start here:** [ARCHITECTURE.md](ARCHITECTURE.md) — canonical repo ownership, data flow, and merge policy.

Consolidating GitHub and local trees so only finished, reusable code stays public:

- [ARCHITECTURE.md](ARCHITECTURE.md) — definitive component map (ANCHOR / AFP / infj-bot)
- [REPO_CONSOLIDATION_PLAN.md](docs/REPO_CONSOLIDATION_PLAN.md) — tiers, archive list, phases
- [SCRIPT_REUSE_MAP.md](docs/SCRIPT_REUSE_MAP.md) — which scripts move into which repo
- `./scripts/github_repo_audit.sh` — refresh audit markdown
- `./scripts/github_repo_cleanup.sh --dry-run` — preview fork archives
- `./scripts/verify_duplicate_repo_deps.sh` — before deleting local duplicate dirs

## How I Work

- Reproducibility over assertion
- Honest states over polished fiction
- Scope and authorization first
- Evidence does the heavy lifting
- Smaller claims, stronger proof

## What I Care About

- structured reasoning systems
- reproducible validation
- evidence-first workflows
- security research tooling
- local-first systems that people can actually run

## Verification

`SHA256:CwsTnS0/92Ymo/TXGQ+iRVfILLN2Q2GZBpN/WFLxOMI`

## Connect

- Immunefi: `timeless-hayoka`
- X: `@timelesshayoka`
- Portfolio: [web3-security-portfolio](https://github.com/timeless-hayoka/web3-security-portfolio)
