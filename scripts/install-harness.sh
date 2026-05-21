#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: install-harness.sh [options] [path]

Apply the Crisp Harness v0 files and folders to a target project directory.

Options:
  -d, --directory <path>  Target directory. Defaults to the current directory.
  -y, --yes              Accepted for compatibility; no prompts are shown.
      --merge            Explicitly use the default merge behavior: create
                         missing Harness files, augment existing AGENTS.md,
                         and skip other existing files.
      --dry-run          Show what would change without writing files.
  -h, --help             Show this help.

Safety:
  Existing files are never overwritten. If AGENTS.md already exists, a marked
  Crisp Harness section is appended once. Other existing files are skipped, and
  missing files are created.

Examples:
  curl -fsSL https://raw.githubusercontent.com/dzungbk156/crispy-framework/main/scripts/install-harness.sh | bash
  scripts/install-harness.sh
  scripts/install-harness.sh --directory /path/to/project --yes
  scripts/install-harness.sh ./my-project --merge
EOF
}

log() {
  printf '%s\n' "$*"
}

fail() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

expand_path() {
  case "$1" in
    "~")
      printf '%s\n' "$HOME"
      ;;
    "~/"*)
      printf '%s/%s\n' "$HOME" "${1#~/}"
      ;;
    /*)
      printf '%s\n' "$1"
      ;;
    *)
      printf '%s/%s\n' "$PWD" "$1"
      ;;
  esac
}

make_absolute_parent() {
  local path="$1"
  local parent
  parent="$(dirname "$path")"
  [ -d "$parent" ] || fail "Parent directory does not exist: $parent"
  (cd "$parent" && printf '%s/%s\n' "$(pwd -P)" "$(basename "$path")")
}

copy_file() {
  local relative="$1"
  local target="$TARGET_DIR/$relative"
  local source_relative
  source_relative="$(source_relative_for_target "$relative")"

  if [ -e "$target" ]; then
    if [ "$SOURCE_MODE" = "local" ] && [ "$SOURCE_ROOT/$source_relative" -ef "$target" ]; then
      log "skip     $relative (source file)"
      SKIPPED=$((SKIPPED + 1))
      return
    fi

    if [ "$relative" = "AGENTS.md" ]; then
      merge_agents_file "$target"
      return
    fi

    log "skip     $relative (already exists)"
    SKIPPED=$((SKIPPED + 1))
    return
  fi

  if [ "$DRY_RUN" -eq 1 ]; then
    log "create   $relative"
  else
    mkdir -p "$(dirname "$target")"
    write_source_file "$source_relative" "$target"
    log "created  $relative"
  fi
  CREATED=$((CREATED + 1))
}

merge_agents_file() {
  local target="$1"

  if grep -Fq "<!-- crisp-harness:start -->" "$target"; then
    log "skip     AGENTS.md (Crisp Harness section already present)"
    SKIPPED=$((SKIPPED + 1))
    return
  fi

  if [ "$DRY_RUN" -eq 1 ]; then
    log "merge    AGENTS.md (append Crisp Harness instructions)"
  else
    cat >> "$target" <<'EOF'

<!-- crisp-harness:start -->
## Crisp Harness

This project also uses Crisp Harness for AI-agent collaboration.

Keep the existing project instructions above authoritative. Use the harness as
the local workflow for intake, story packets, validation expectations,
decisions, and handoffs.

Start every task by reading:

- `README.md`
- `AGENTS.md`
- `docs/WORK_INTAKE.md`

If `docs/ADOPTION_STATUS.md` says `not_started`, route through
`docs/FIRST_ADOPTION.md` before normal feature work. If it says `ready`, use the
source router in this file and read only the task-relevant product docs, stories,
test matrix rows, decisions, or handoffs.

Do not read or print secrets such as `.env` values. Do not overwrite existing
project conventions just to fit the harness; adapt the harness around local
truth.
<!-- crisp-harness:end -->
EOF
    log "merged   AGENTS.md (appended Crisp Harness instructions)"
  fi

  MERGED=$((MERGED + 1))
}

source_relative_for_target() {
  case "$1" in
    AGENTS.md)
      printf '%s\n' "docs/templates/seed/AGENTS.md"
      ;;
    README.md)
      printf '%s\n' "docs/templates/seed/README.md"
      ;;
    docs/HARNESS_BACKLOG.md)
      printf '%s\n' "docs/templates/seed/HARNESS_BACKLOG.md"
      ;;
    docs/TEST_MATRIX.md)
      printf '%s\n' "docs/templates/seed/TEST_MATRIX.md"
      ;;
    docs/stories/README.md)
      printf '%s\n' "docs/templates/seed/stories-README.md"
      ;;
    docs/stories/backlog.md)
      printf '%s\n' "docs/templates/seed/stories-backlog.md"
      ;;
    *)
      printf '%s\n' "$1"
      ;;
  esac
}

write_source_file() {
  local source_relative="$1"
  local target="$2"

  if [ "$SOURCE_MODE" = "local" ]; then
    local source="$SOURCE_ROOT/$source_relative"
    [ -f "$source" ] || fail "Source file missing: $source"
    cp -p "$source" "$target"
    return
  fi

  local url="$SOURCE_BASE_URL/$source_relative"
  curl -fsSL "$url" -o "$target" || fail "Could not download $url"
}

check_protected_target_paths() {
  local conflicts=()

  [ -e "$TARGET_DIR/AGENTS.md" ] && conflicts+=("AGENTS.md")
  [ -e "$TARGET_DIR/docs" ] && conflicts+=("docs/")
  [ "${#conflicts[@]}" -gt 0 ] || return 0

  local joined=""
  local item
  for item in "${conflicts[@]}"; do
    if [ -n "$joined" ]; then
      joined="$joined, $item"
    else
      joined="$item"
    fi
  done

  log "Existing Harness paths found: $joined. Existing AGENTS.md will be augmented once; other existing files will be skipped; missing files will be created."
}

TARGET_INPUT="${HARNESS_TARGET_DIR:-$PWD}"
DRY_RUN=0
POSITIONAL_TARGET=""

while [ "$#" -gt 0 ]; do
  case "$1" in
    -d|--directory)
      [ "$#" -ge 2 ] || fail "$1 requires a path"
      TARGET_INPUT="$2"
      shift 2
      ;;
    -y|--yes)
      shift
      ;;
    --merge)
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --)
      shift
      break
      ;;
    -*)
      fail "Unknown option: $1"
      ;;
    *)
      [ -z "$POSITIONAL_TARGET" ] || fail "Only one target path is supported"
      POSITIONAL_TARGET="$1"
      shift
      ;;
  esac
done

if [ "$#" -gt 0 ]; then
  [ -z "$POSITIONAL_TARGET" ] || fail "Only one target path is supported"
  POSITIONAL_TARGET="$1"
  shift
fi

[ "$#" -eq 0 ] || fail "Unexpected extra arguments"

if [ -n "$POSITIONAL_TARGET" ]; then
  TARGET_INPUT="$POSITIONAL_TARGET"
fi

SCRIPT_PATH="${BASH_SOURCE[0]:-$0}"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" 2>/dev/null && pwd -P || printf '')"
SOURCE_ROOT=""
SOURCE_MODE="remote"
DEFAULT_SOURCE_BASE_URL="https://raw.githubusercontent.com/dzungbk156/crispy-framework/main"
SOURCE_BASE_URL="${HARNESS_SOURCE_BASE_URL:-$DEFAULT_SOURCE_BASE_URL}"
SOURCE_BASE_URL="${SOURCE_BASE_URL%/}"

if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/../AGENTS.md" ] && [ -f "$SCRIPT_DIR/../docs/HARNESS.md" ]; then
  SOURCE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
  SOURCE_MODE="local"
fi

TARGET_DIR="$(make_absolute_parent "$(expand_path "$TARGET_INPUT")")"
CREATED=0
SKIPPED=0
MERGED=0

if [ "$DRY_RUN" -eq 1 ]; then
  log "Dry run: no files will be written."
elif [ ! -d "$TARGET_DIR" ]; then
  mkdir -p "$TARGET_DIR"
fi

if [ ! -d "$TARGET_DIR" ]; then
  [ "$DRY_RUN" -eq 1 ] || fail "Target directory could not be created: $TARGET_DIR"
  log "Target directory would be created: $TARGET_DIR"
fi

if [ -d "$TARGET_DIR" ]; then
  [ -w "$TARGET_DIR" ] || fail "Target directory is not writable: $TARGET_DIR"
else
  [ -w "$(dirname "$TARGET_DIR")" ] || fail "Target parent directory is not writable: $(dirname "$TARGET_DIR")"
fi

if [ -d "$TARGET_DIR" ]; then
  check_protected_target_paths
fi

if [ "$SOURCE_MODE" = "local" ]; then
  log "Harness source: $SOURCE_ROOT"
else
  command -v curl >/dev/null 2>&1 || fail "curl is required for remote installation"
  [ -n "$SOURCE_BASE_URL" ] || fail "HARNESS_SOURCE_BASE_URL is required when running install-harness.sh without a local repository checkout"
  log "Harness source: $SOURCE_BASE_URL"
fi
log "Target project: $TARGET_DIR"

while IFS= read -r relative; do
  copy_file "$relative"
done <<'EOF'
AGENTS.md
README.md
docs/ARCHITECTURE.md
docs/ADOPTION_STATUS.md
docs/FIRST_ADOPTION.md
docs/agents/README.md
docs/agents/domain-docs.md
docs/agents/issue-tracker.md
docs/agents/work-states.md
docs/AGENT_ROLES.md
docs/EVALUATION.md
docs/AGENT_ONBOARDING.md
docs/CONTINUITY.md
docs/GLOSSARY.md
docs/HARNESS.md
docs/HARNESS_BACKLOG.md
docs/PROJECT_ADOPTION.md
docs/PROJECT_GOVERNANCE.md
docs/PROJECT_START.md
docs/README.md
docs/TEST_MATRIX.md
docs/WORK_INTAKE.md
docs/decisions/README.md
docs/handoffs/README.md
docs/intake/README.md
docs/product/README.md
docs/stories/README.md
docs/stories/backlog.md
docs/templates/decision.md
docs/templates/context-questions.md
docs/templates/design-concept.md
docs/templates/handoff.md
docs/templates/mission-plan.md
docs/templates/product-glossary.md
docs/templates/prototype.md
docs/templates/research-facts.md
docs/templates/spec-intake.md
docs/templates/structure-outline.md
docs/templates/story.md
docs/templates/validation-contract.md
docs/templates/validation-report.md
docs/templates/high-risk-story/design.md
docs/templates/high-risk-story/execplan.md
docs/templates/high-risk-story/overview.md
docs/templates/high-risk-story/validation.md
EOF

log ""
log "Done. Created: $CREATED, merged: $MERGED, skipped: $SKIPPED."

if [ "$SKIPPED" -gt 0 ]; then
  log "Existing non-AGENTS files were left untouched."
fi
