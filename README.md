# Grok Skills Repository

Central repository for custom skills used with Grok AI agents.

## Features
- Collection of domain-specific skills (architectural design, code review, etc.)
- Automatic validation via GitHub Actions on every push/PR
- Conventional Commits enforced
- Ready for MCP integration and agent loading

## Validation
Skills are automatically validated for:
- Proper SKILL.md frontmatter
- Naming conventions
- Description rules
- No control tokens, etc.

See `.github/workflows/validate-skills.yml` for details.

Clone and contribute!