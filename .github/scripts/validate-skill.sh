#!/usr/bin/env bash
# Validate a single skill directory for the agent. Mirrors the rules
# enforced by `server/scripts/validate-skills.mjs` (which gates every
# commit in CI), so that what passes here also passes there.
#
# Usage:
#   validate-skill.sh <skill-directory>

set -euo pipefail

die() { echo "FAIL: $*" >&2; exit 1; }

[[ $# -ne 1 ]] && die "Usage: validate-skill.sh <skill-directory>"

SKILL_DIR="$1"
SKILL_MD="$SKILL_DIR/SKILL.md"
EXPECTED_NAME=$(basename "$SKILL_DIR")

[[ -d "$SKILL_DIR" ]] || die "Directory does not exist: $SKILL_DIR"
[[ -f "$SKILL_MD" ]]  || die "SKILL.md not found in $SKILL_DIR"

CONTENT=$(<"$SKILL_MD")

# Check frontmatter delimiter
if [[ "$CONTENT" != ---* ]]; then
  FIRST3=$(echo "$CONTENT" | head -c 12)
  if echo "$FIRST3" | LC_ALL=C grep -qP '[\x{2010}-\x{2015}\x{FE58}\x{FE63}\x{FF0D}]' 2>/dev/null; then
    die "SKILL.md starts with typographic dashes (em-dash/en-dash) instead of three ASCII hyphens (---) — fix the frontmatter delimiter"
  fi
  die "SKILL.md must start with --- (YAML frontmatter)"
fi

# Extract frontmatter (between the first pair of `---` lines)
FRONTMATTER=$(echo "$CONTENT" | awk '/^---$/{n++; next} n==1')
[[ -n "$FRONTMATTER" ]] || die "Empty or malformed frontmatter"

BODY=$(echo "$CONTENT" | awk '/^---$/{n++; next} n>=2')
BODY_TRIMMED=$(echo "$BODY" | sed '/^[[:space:]]*$/d')
[[ -n "$BODY_TRIMMED" ]] || die "SKILL.md body is empty (no content after frontmatter)"

# name check
NAME_LINE=$(echo "$FRONTMATTER" | grep -m1 '^name:' || true)
[[ -n "$NAME_LINE" ]] || die "Missing 'name' in frontmatter"
NAME_RAW=$(echo "$NAME_LINE" | sed 's/^name:[[:space:]]*//')
if [[ "$NAME_RAW" =~ ^\".*\"$ ]] || [[ "$NAME_RAW" =~ ^\'.*\'$ ]]; then
  die "'name' must not be wrapped in quotes"
fi
NAME="$NAME_RAW"

[[ ${#NAME} -ge 2 ]]  || die "Name '$NAME' is too short"
[[ ${#NAME} -le 64 ]] || die "Name '$NAME' is too long"
if echo "$NAME" | grep -qE '\-\-'; then
  die "Name contains consecutive hyphens"
fi
if ! echo "$NAME" | grep -qE '^[a-z0-9][a-z0-9-]*[a-z0-9]$'; then
  die "Name '$NAME' is invalid format"
fi
if [[ "$NAME" != "$EXPECTED_NAME" ]]; then
  die "Name must match directory name"
fi

# description checks (simplified for CI)
DESC_LINE=$(echo "$FRONTMATTER" | grep -m1 '^description:' || true)
[[ -n "$DESC_LINE" ]] || die "Missing 'description'"
DESC_RAW=$(echo "$DESC_LINE" | sed 's/^description:[[:space:]]*//')
if echo "$DESC_RAW" | grep -q ': '; then
  die "Description contains ': ' - reword"
fi
if echo "$DESC_RAW" | grep -qE '[<>]'; then
  die "Description contains angle brackets"
fi

# More checks can be added
LINE_COUNT=$(echo "$CONTENT" | wc -l | tr -d ' ')
echo "OK: Skill '$NAME' is valid ($LINE_COUNT lines)"