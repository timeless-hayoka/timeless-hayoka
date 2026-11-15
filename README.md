# Timeless Hayoka | Security Researcher

**Independent ethical hacker · Web3 security research · Evidence-driven vulnerability validation**

I build tools that turn security hypotheses into reproducible evidence. My focus is authorized smart-contract research, adversarial testing, AI-assisted analysis, and engineering workflows that distinguish a promising signal from a demonstrated finding.

**Principle:** *Question assumptions. Reproduce the behavior. Preserve the evidence.*

[ANCHOR source](https://github.com/timeless-hayoka/ANCHOR) · [ANCHOR browser demo](https://timeless-hayoka.github.io/ANCHOR/) · [Portfolio architecture](ARCHITECTURE.md)

## Flagship: ANCHOR

[ANCHOR](https://github.com/timeless-hayoka/ANCHOR) is a local-first, proof-gated research platform for authorized smart-contract investigations. It tracks signals, benchmark outcomes, case evidence, and reproduction status rather than treating scanner output as proof.

**Inspectable starting points:**
- [Getting started](https://github.com/timeless-hayoka/ANCHOR/blob/main/docs/GETTING_STARTED.md) — local setup and a labeled SARIF corpus.
- [Proof gate](https://github.com/timeless-hayoka/ANCHOR/blob/main/docs/PROOF_GATE.md) — promotion criteria and evidence states.
- [Reproduction guide](https://github.com/timeless-hayoka/ANCHOR/blob/main/docs/REPRODUCTION.md) — separate, authorized local reproduction workflow.
- [Benchmark index](https://github.com/timeless-hayoka/ANCHOR/blob/main/benchmarks/index.json) — published benchmark references.

The documented SARIF quickstart expects **four labeled cases (3 true positives, 1 true negative)**. This is a *fixture-level signal-processing check*, **not** evidence of a live exploit, external audit, or bounty acceptance. The [static browser demo](https://timeless-hayoka.github.io/ANCHOR/) does not scan live targets.

## Supporting projects

| Repository | Scope | What to inspect |
| --- | --- | --- |
| [infj-bot](https://github.com/timeless-hayoka/infj-bot) | PHI/DRIFT companion reasoning, Trinity orchestration, dashboard, and knowledge integration | [README](https://github.com/timeless-hayoka/infj-bot) |
| [AI-Forge-Protocol](https://github.com/timeless-hayoka/AI-Forge-Protocol) | Validation harnesses, patch gates, and Forge V5 syntax checks | [README](https://github.com/timeless-hayoka/AI-Forge-Protocol) |
| [bounty-bot](https://github.com/timeless-hayoka/bounty-bot) | Structured bug-bounty workflow and evidence tracking | [Repository](https://github.com/timeless-hayoka/bounty-bot) |
| [LOTUS-ACADEMY](https://github.com/timeless-hayoka/LOTUS-ACADEMY) | Cybersecurity learning tracks and hands-on labs | [README](https://github.com/timeless-hayoka/LOTUS-ACADEMY) |
| [cyber-tools](https://github.com/timeless-hayoka/cyber-tools) | Scoped security research utilities | [Repository](https://github.com/timeless-hayoka/cyber-tools) |
| [crex](https://github.com/timeless-hayoka/crex) | Cognitive middleware hooks | [Repository](https://github.com/timeless-hayoka/crex) |

The [architecture map](ARCHITECTURE.md) defines ownership boundaries: ANCHOR owns evidence and benchmark lifecycle; AI Forge owns code validation gates; infj-bot owns Trinity and companion surfaces. These projects are under active development; repository presence does not establish production readiness.

## How I investigate

1. Confirm scope and authorization before testing.
2. Define an explicit threat model, hypothesis, and expected invariant.
3. Collect source, tool output, and relevant environmental provenance.
4. Test in a controlled environment; keep failed attempts and negative controls.
5. Reproduce a claimed issue independently where possible.
6. Separate **detected**, **correlated**, **PoC executed**, and **reproduced** states.
7. Write a clear report with limitations, impact evidence, and remediation.

**No exploit claim is promoted merely because an AI model, scanner, or fixture flags it.** Public benchmarks are not substitutes for verified live findings.

## Research interests

Smart-contract security · Solidity · Python · Linux · Fuzzing · Static and dynamic analysis · Foundry-based reproduction · Threat modeling · AI-assisted security tooling · Cognitive architectures

## Responsible disclosure

I work only within authorized testing scopes and follow program rules and coordinated disclosure practices. Private findings, target-sensitive details, and unverified impact claims are not published here. Public case studies will link to reproducible evidence only when disclosure is permitted.

## Connect

- **GitHub:** [@timeless-hayoka](https://github.com/timeless-hayoka)
- **Immunefi:** `timeless-hayoka` (handle listed in previous profile)
- **X:** `@timelesshayoka` (handle listed in previous profile)

For technical context, start with [ARCHITECTURE.md](ARCHITECTURE.md), then the linked repositories and their reproducible instructions.

---

*Evidence before hype. Smaller claims, stronger proof.*
