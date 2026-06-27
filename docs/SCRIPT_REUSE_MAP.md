# Script & Module Reuse Map

Extract **once**, import everywhere. Target repos should depend on packages or git submodules — not copy-paste.

## ANCHOR (proof gate)

| Asset | Path | Reuse in |
|-------|------|----------|
| CLI entry | `anchor_cli.py` | infj-bot bootstrap scripts |
| HTTP server | `anchor_server.py` | infj-bot `scripts/run_anchor_web.sh` |
| Storage layout | `anchor_storage.py` | All Trinity case writers |
| Benchmark runners | `benchmarks/*/run_phase1_benchmark.py` | AI-Forge-Protocol tournament adapter |
| SCabench adapter | `scabench_adapter.py` | bounty-bot fidelity reports |

## infj-bot (Drift runtime)

| Asset | Path | Reuse in |
|-------|------|----------|
| V5 syntax gate | `forge_v5_gatekeeper.py` | **→ AI-Forge-Protocol** (canonical copy) |
| Anchor vault context | `core/anchor_context.py` | ANCHOR server prompts / MCP |
| Cognitive orchestrator | `core/cognitive_orchestrator.py` | AI-Forge-Protocol forge_harness |
| Validation harness | `scripts/validate.py`, `scripts/causality_harness.py` | AI-Forge-Protocol CI |
| Web/API launcher | `scripts/run_web.sh`, `scripts/bootstrap_anchor.sh` | LOTUS-ACADEMY dev docs |
| MCP tooling | `scripts/mcp_client.py`, `core/mcp_server.py` | cyber-tools (thin wrappers only) |

## AI-Forge-Protocol

| Asset | Path | Reuse in |
|-------|------|----------|
| Forge harness | `src/forge_harness.py` | infj-bot evals (replace hardcoded `/home/crexs`) |
| Testforge core | `src/drift_testforge/core/harness.py` | ANCHOR benchmark scoring |
| Adapters | `src/adapters/*.py` | Plug-in surface for LOTUS-ACADEMY labs |
| Reliability metrics | `src/metrics/reliability_metrics.py` | bounty-bot report cards |

**Fix first:** `forge_harness.py` uses `sys.path.append("/home/crexs")` — replace with `pip install -e ../infj_bot` or env `DRIFT_ROOT`.

## bounty-bot

| Asset | Path | Reuse in |
|-------|------|----------|
| Fidelity runner | `scripts/fidelity_runner.py` | ANCHOR negative-control checks |
| H1 selector | `scripts/h1_program_selector.py` | cyber-tools (optional) |
| Reporter | `scripts/reporter.py` | ANCHOR case ledger export |

**Remove from git:** `fidelity_test_env/lib/forge-std/` — use Foundry install instead.

## cyber-tools

| Asset | Path | Reuse in |
|-------|------|----------|
| dolphin-chat | `bin/dolphin-chat.py` | LOTUS-ACADEMY voice-server experiments |

Keep this repo **small** (<20 files). Move heavy scripts into Tier 1 repos.

## llm-minify

| Asset | Path | Reuse in |
|-------|------|----------|
| compress API | `llm_minify/` package | infj-bot prompt builder (pre-LLM) |
| Decorator harness | `harness.py` | AI-Forge-Protocol token budget tests |

## crex

| Asset | Path | Reuse in |
|-------|------|----------|
| Prompt hooks | `drift_ft/prompt_hook.py` | infj-bot cognitive_orchestrator (already imported dynamically) |

## LOTUS-ACADEMY

| Asset | Path | Reuse in |
|-------|------|----------|
| Sandbox runner | `lotus_academy/run_sandbox.sh` | ANCHOR damn-vulnerable-defi benchmark docs |
| Main lab UI | `src/` | Public LOTUS-ACADEMY repo only |

## Duplicates to delete locally (not extract)

- `/home/crexs/infj-bot` after `anchor` is default on GitHub
- `/home/crexs/ai_forge_protocol` (venv-only duplicate)
- Home-root `enhanced_harness_results/` copies (keep under ANCHOR or `.drift_os/` only)
- Contract vendor trees under `/home/crexs` when not actively hunting (use git submodule in ANCHOR benchmarks)
