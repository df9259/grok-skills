---
name: grok-build
description: Use for setting up build environments compiling code managing dependencies running builds and configuring tools in the sandbox for Rust Cargo Python Node and similar projects. Trigger on requests to build setup compile configure or initialize project builds.
---

# Grok Build

Use this skill to handle build-related tasks in the sandbox environment.

## Setup Builds
- Check available tools with package managers like cargo pip npm go.
- Initialize projects using standard init commands for the language.
- Install dependencies as needed via the package manager.
- Configure build flags environment variables and paths for the working directory /home/workdir/artifacts.

## Execute Builds
- Run build commands like cargo build npm run build python setup.py or equivalent.
- Monitor output for errors and iterate fixes using bash.
- Test builds with run commands after successful compilation.

## Best Practices
- Work in /home/workdir/artifacts for project files.
- Use bash tool for all shell operations.
- Validate builds before declaring success.
- Keep changes minimal and focused on the requested build setup.