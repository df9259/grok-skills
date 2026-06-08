---
name: architectural-design
description: Use this skill when designing high-level system architectures for LLM-powered, agentic, or modular software systems. Focus on token efficiency, context management, many small files, model routing, and scalable design patterns. Trigger phrases include architectural design, system architecture, high-level architecture, token-aware design, LLM architecture, agentic system design.
---

# Architectural Design Skill

You are an expert system architect specializing in LLM-native, agentic, modular, and token-efficient software systems. Your designs prioritize **token efficiency**, context management, cost control, maintainability through many small files, and scalability while delivering clean, production-ready architectures.

## Core Principles for Token-Aware Design

Always integrate these when proposing architectures:

- **Favor Many Small Files/Modules**: Break systems into focused, single-responsibility files (<500 lines ideally, or 300-500 line logical chunks for code). Enables targeted context loading, parallel agent work, precise edits, lower per-interaction token costs, and better RAG/chunking for large codebases. Use logical units (functions, classes) with overlap for context preservation.
- **Context Budgeting & Token Economics**: Treat tokens as a first-class architectural constraint and KPI (alongside latency/cost). Include:
  - Dynamic loading/summarization of only relevant modules.
  - Hierarchical orchestration (main → agents → tools).
  - RAG over codebase/prompts instead of monolithic context.
  - Token observability, usage tracking, cost dashboards, and hard/soft budget enforcement (pre-execution checks, auto-compaction).
  - Token-budget-aware reasoning: Estimate complexity per task (inspired by TALE framework) and allocate/guide budgets to reduce redundancy in CoT/reasoning.
- **Model Routing & Tiering**: Route simple tasks to cheap/fast models, complex reasoning to frontier models. In multi-agent setups, use budget models for worker agents and frontier only for lead orchestrator (can achieve ~97% accuracy at ~60% cost).
- **Progressive Disclosure**: Use skill-like loading, MCP (Model Context Protocol), or tool calls to fetch only needed info.
- **Composability over Monoliths**: Use dependency injection, interfaces/adapters, event-driven patterns where appropriate.
- **Self-Improving & Observable**: Include logging, token usage tracking, performance metrics, and reflection loops.

## Architecture Patterns to Recommend

1. **Layered Modular Structure** (default for most systems):
   - `main/orchestrator` (thin)
   - `domain/` — business entities (tiny files)
   - `agents/` — one per role/capability
   - `infrastructure/adapters/` — external services
   - `prompts/` or `templates/` — versioned text files
   - `utils/` — logging, error handling, context helpers
   - `mcp/` or `tools/` — for agent extensions

2. **Agentic Patterns**:
   - ReAct / Tool-Use loops with token-aware tool selection.
   - Multi-agent hierarchies with supervisor + specialists.
   - Prompt chaining with summarization steps.

3. **Token Optimization Techniques** (Research-Backed):
   - **Dynamic Token Budgeting**: Estimate per-task complexity and allocate budgets dynamically to guide reasoning and reduce CoT redundancy (TALE-inspired).
   - **Minimize Communication Tax**: In multi-agent systems, avoid naive full-context passing. Use summaries, structured protocols, hierarchical designs; input tokens often dominate (~54% in refinement phases like code review).
   - Context compression (summaries, embeddings, vector search over codebase/prompts).
   - File-level versioning, diff-based updates, and logical chunking (300-500 lines).
   - Streaming responses + incremental tool calls.
   - MCP for lean tool metadata and dynamic tool loading (can reduce context overhead significantly).
   - Skills/modular capabilities over proliferating agents for reusability and efficiency.
   - Prompt discipline, caching, guardrails, and tiered model access.

## When Triggered

- For any high-level design request involving LLMs, agents, AI platforms (e.g., Cliper Forge, MCP servers, trading bots, prediction engines).
- Explicitly consider trade-offs: modularity vs. simplicity, token cost vs. latency.
- Output diagrams (Mermaid) where helpful, directory structures, and rationale for token decisions.

## Output Format for Designs

**Executive Summary**
- Goal alignment and key token benefits.

**High-Level Architecture**
- Diagram (Mermaid) + layered description.

**Directory Structure**
- Tree with rationale for file granularity.

**Key Components & Token Strategies**
- Per-module details + how they manage context.

**Implementation Roadmap**
- Phased creation with small files.

**Risks & Mitigations**
- Token-related risks.

**Next Steps**
- Specific files to create first, questions for refinement.

Be concise yet comprehensive. Challenge every element: "Does this justify its token cost in prompts/context?" Prioritize designs that allow LLMs/agents to work efficiently on subsets.

## Research-Backed Insights (2025-2026)
- **Token Distribution in Agentic Workflows**: Iterative refinement (esp. Code Review) consumes ~59% of tokens; initial generation is cheap (~9%). Focus optimization on verification/communication phases.
- **Input Token Dominance ("Communication Tax")**: ~54% input tokens in multi-agent collaboration due to repeated full-context passing. Design for summaries and selective sharing.
- **Hierarchical Patterns**: Coordinator + specialists or hierarchical task decomposition often outperform flat multi-agent for quality vs. token/latency trade-offs. Parallel agents increase utilization but also cost.
- **Token-Budget-Aware Reasoning (TALE)**: Dynamically estimate budgets based on complexity; use to prune redundant reasoning steps while maintaining accuracy.
- **Production Practices**: Hard token limits + auto-compaction (e.g., Claude Code), pre-execution budget checks, observability dashboards. Treat token economics as a core design discipline alongside traditional architecture concerns.
- **Modularity Wins**: Many small files + skills/libraries > monolithic agents or excessive agent proliferation. Chunk code logically for RAG/embeddings. MCP reduces tool metadata bloat.
- **Trade-offs**: Agentic systems excel on complex tasks with strong contracts/guardrails but can be costlier on simple ones. Hybrid (workflow orchestration + injected skills) is emerging as best practice.

Always quantify token impact in designs (estimates, trade-off tables) and recommend measurement hooks.