---
name: git-commit-practices
description: Use when preparing commits, commit messages, branches or a push for a git repository, to keep commits atomic and messages in Conventional Commits format with clear why.
---
# Git Commit Practices

## Before committing
1. `git status` and `git diff` — know exactly what changed.
2. Split unrelated changes into separate commits (one logical change each). Stage with `git add -p` when a file mixes changes. If the commit message needs the word "and", split it.
3. Check nothing secret or generated is staged: env files, keys, keystores, `local.properties`, build outputs, large binaries. Fix `.gitignore` first if needed.
4. Run the project's tests/linters if they are quick.

## Message format (Conventional Commits)
```
<type>(<optional scope>): <imperative summary, <= 50-72 chars>

<optional body: what and why, wrapped at 72>

<optional footer: BREAKING CHANGE: ..., Refs #123>
```
- Use imperative mood ("add feature" not "added feature" or "adds feature").
- Subject summarizes the change; body explains **why** (not just what).
- Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert.
- Examples: `fix(location): stop duplicate geofence alerts`, `feat(api): add candle fetch retry`.

## Branches and pushing
- Work on a branch (`feat/...`, `fix/...`), not directly on the default branch, unless the repo owner says otherwise.
- Pushing, force-pushing, rewriting pushed history, merging and opening PRs are visible to others: get the owner's OK first, and never force-push a shared branch without explicit confirmation.
- Prefer squash-merge for clean history when the team uses it; write PR titles in the same Conventional Commits style.

## Best practices
- One change, one commit. Atomic commits make history readable and reverts safe.
- Write the commit message before or while coding so the code matches the intent.
- Avoid "WIP", "fix stuff", or vague messages. If you can't explain why, the change may not be ready.

Source: Conventional Commits specification, Git documentation (50/72 rule), and common team practices as of 2026.
