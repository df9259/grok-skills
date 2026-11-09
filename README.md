# Grok Skills Repository

Central repository for custom skills used with Grok AI agents.

## Features
- Collection of domain-specific skills (architectural design, code review, mobile app development, etc.)
- Automatic validation via GitHub Actions on every push/PR
- Conventional Commits enforced
- Ready for MCP integration and agent loading

## Skills
- `bot-instruction-design`: writing a bot's role, permissions, approval line and group handoffs
- `prompt-engineer`: writing and scoring system prompts
- `persona-voice-file`: writing a character or persona voice file
- `token-aware-agent-architecture`: laying out agents and tools without overloading context
- `file-blueprint-planner`: planning files before code is written
- `code-review`: code review checklist, with Kotlin/Android and Rust notes
- `git-commit-practices`: commit, branch and pull request habits
- `claim-and-assumption-check`: checking claims, backtests and numbers before relying on them
- `grok-build`: Grok Build readiness and workflows
- `create-mobile-apps`: ordered workflow for high-quality iOS (Xcode/Swift/SwiftUI) and Android (Kotlin/Jetpack Compose) apps
- `audit-mobile-apps`: systematic review against platform quality guidelines, store policies, and coding standards

## Validation
Skills are automatically validated for:
- Proper SKILL.md frontmatter
- Naming conventions
- Description rules
- No control tokens, etc.

See `.github/workflows/validate-skills.yml` for details.

Clone and contribute!
