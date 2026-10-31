---
name: token-aware-agent-architecture
description: Use when designing or reviewing the architecture of an LLM-powered or multi-agent system (including local-model setups) where context window, token cost, latency and many-small-files maintainability matter.
---
# Token-Aware Agent Architecture

Design LLM and agent systems that treat tokens and context as first-class constraints, next to latency and cost.

## Core principles
- **Many small files.** One responsibility per file, ideally under 300-500 lines, so agents load only what they need and edits stay precise.
- **Context budget.** Write down the window size (e.g. 32k, 128k) and allocate it: system prompt/persona, tools, memory/retrieval, conversation, reply headroom. Per-slot budgets matter when a local server splits context across parallel slots.
- **Progressive disclosure.** Load skills, tools and documents on demand (tool calls, MCP, retrieval) instead of stuffing everything into the prompt.
- **Hierarchy.** Thin orchestrator, then specialist agents, then tools. Each agent gets only its own instructions and data.
- **Model routing.** Cheap/fast or local models for routine work; larger models only for hard reasoning. Turn heavy reasoning ("thinking") on per task, not globally, when latency matters (voice, chat).
- **Memory, not transcripts.** Summarize and store facts in a memory/vector store; retrieve the few relevant ones per turn. Compact long chats.
- **Caching.** Keep stable prefixes (system prompt, tool list) first and unchanged so prompt/KV caches hit.
- **Observability.** Log tokens in/out, latency and cache hits per call; set soft and hard budgets with a defined fallback.

## Default layout
```
orchestrator/   thin entry point and routing
agents/         one file per role
prompts/        versioned prompt and persona files
tools/ or mcp/  tool adapters
memory/         summarization, retrieval
adapters/       external services
utils/          logging, token accounting
```

## Workflow
1. State the goal, the models available, window sizes, latency target and hardware limits.
2. Draw the flow (Mermaid) and the context budget table.
3. For every component ask: does this justify its token cost in every call? If not, move it to on-demand loading.
4. List risks (context overflow, cache misses, slow first token, memory drift) and mitigations.
5. Give a phased roadmap starting with the smallest working loop, and measure before optimizing.

## Output
Executive summary · diagram · context budget table · directory tree · per-component token strategy · roadmap · risks · open questions.

Safety: architecture work is advisory. Do not install software, download models, change services or edit secret/config files as part of this skill without the owner's explicit approval.

Source: merged from the owner's grok-skills repo (architectural-design + hermes-token-aware-architecture).
