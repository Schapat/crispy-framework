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
      --no-cli           Skip installing scripts/bin/harness-cli.
      --require-cli      Fail if scripts/bin/harness-cli cannot be installed.
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
  scripts/install-harness.sh ./my-project --no-cli
  scripts/install-harness.sh ./my-project --require-cli
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

  if [ "$relative" = ".gitignore" ]; then
    merge_gitignore "$target"
    return
  fi

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

merge_gitignore() {
  local target="$1"
  local existed=0
  local marker="# Crisp Harness durable layer"
  local rules="harness.db
harness.db-wal
harness.db-shm
scripts/bin/harness-cli
scripts/bin/harness-cli.exe"

  [ -e "$target" ] && existed=1

  if [ -e "$target" ] &&
     grep -Fxq "harness.db" "$target" &&
     grep -Fxq "harness.db-wal" "$target" &&
     grep -Fxq "harness.db-shm" "$target" &&
     grep -Fxq "scripts/bin/harness-cli" "$target" &&
     grep -Fxq "scripts/bin/harness-cli.exe" "$target"; then
    log "skip     .gitignore (harness rules already present)"
    SKIPPED=$((SKIPPED + 1))
    return
  fi

  if [ "$DRY_RUN" -eq 1 ]; then
    if [ -e "$target" ]; then
      log "update   .gitignore (append harness rules)"
    else
      log "create   .gitignore"
    fi
  else
    mkdir -p "$(dirname "$target")"
    {
      [ -e "$target" ] && [ -s "$target" ] && printf '\n'
      printf '%s\n%s\n' "$marker" "$rules"
    } >> "$target"
    if [ "$existed" -eq 1 ]; then
      log "updated  .gitignore (appended harness rules)"
    else
      log "created  .gitignore"
    fi
  fi
  MERGED=$((MERGED + 1))
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

detect_cli_platform() {
  local os arch
  os="$(uname -s)"
  arch="$(uname -m)"

  case "$os:$arch" in
    Darwin:arm64)  printf 'macos-arm64' ;;
    Darwin:x86_64) printf 'macos-x64' ;;
    Linux:x86_64)  printf 'linux-x64' ;;
    Linux:aarch64|Linux:arm64) printf 'linux-arm64' ;;
    *)
      fail "Unsupported Harness CLI platform: $os/$arch."
      ;;
  esac
}

sha256_file() {
  local file="$1"
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$file" | awk '{ print $1 }'
  elif command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$file" | awk '{ print $1 }'
  else
    fail "shasum or sha256sum is required to verify the Harness CLI download"
  fi
}

download_file() {
  local url="$1"
  local target="$2"
  curl -fsSL "$url" -o "$target" || fail "Could not download $url"
}

read_cli_release_tag() {
  local tag_file="scripts/harness-cli-release-tag"
  local tag=""

  if [ "$SOURCE_MODE" = "local" ]; then
    if [ -f "$SOURCE_ROOT/$tag_file" ]; then
      tag="$(awk 'NF && $1 !~ /^#/ { print $1; exit }' "$SOURCE_ROOT/$tag_file")"
    fi
  else
    local tmp_file
    tmp_file="$(mktemp)"
    if curl -fsSL "$SOURCE_BASE_URL/$tag_file" -o "$tmp_file" 2>/dev/null; then
      tag="$(awk 'NF && $1 !~ /^#/ { print $1; exit }' "$tmp_file")"
    fi
    rm -f "$tmp_file"
  fi

  printf '%s\n' "$tag"
}

default_cli_base_url() {
  local release_tag="${HARNESS_CLI_RELEASE_TAG:-}"

  if [ -z "$release_tag" ]; then
    release_tag="$(read_cli_release_tag)"
  fi

  if [ -n "$release_tag" ] && [ "$release_tag" != "latest" ]; then
    printf 'https://github.com/dzungbk156/crispy-framework/releases/download/%s\n' "$release_tag"
  else
    printf 'https://github.com/dzungbk156/crispy-framework/releases/latest/download\n'
  fi
}

install_harness_cli_binary() {
  [ "$INSTALL_RUST_CLI" -eq 1 ] || return 0

  local platform binary_name binary_url checksum_url target tmp_dir binary_tmp checksum_tmp expected actual
  platform="${HARNESS_CLI_PLATFORM:-$(detect_cli_platform)}"
  binary_name="harness-cli-$platform"
  binary_url="$CLI_BASE_URL/$binary_name"
  checksum_url="$binary_url.sha256"
  target="$TARGET_DIR/scripts/bin/harness-cli"

  if [ -e "$target" ]; then
    log "skip     scripts/bin/harness-cli (already exists)"
    SKIPPED=$((SKIPPED + 1))
    return 0
  fi

  if [ "$DRY_RUN" -eq 1 ]; then
    if [ "$SOURCE_MODE" = "local" ] && [ -f "$SOURCE_ROOT/scripts/bin/harness-cli" ]; then
      log "copy     scripts/bin/harness-cli"
    else
      log "download $binary_name -> scripts/bin/harness-cli"
      log "verify   $binary_name.sha256"
    fi
    CREATED=$((CREATED + 1))
    return 0
  fi

  if [ "$SOURCE_MODE" = "local" ] && [ -f "$SOURCE_ROOT/scripts/bin/harness-cli" ]; then
    mkdir -p "$(dirname "$target")"
    cp "$SOURCE_ROOT/scripts/bin/harness-cli" "$target"
    chmod 755 "$target"
    log "created  scripts/bin/harness-cli"
    CREATED=$((CREATED + 1))
    return 0
  fi

  command -v curl >/dev/null 2>&1 || fail "curl is required to download the Harness CLI"

  tmp_dir="$(mktemp -d)"
  binary_tmp="$tmp_dir/$binary_name"
  checksum_tmp="$tmp_dir/$binary_name.sha256"

  if ! curl -fsSL "$binary_url" -o "$binary_tmp"; then
    rm -rf "$tmp_dir"
    if [ "$REQUIRE_RUST_CLI" -eq 1 ]; then
      fail "Could not download required Harness CLI: $binary_url"
    fi
    log "warning  Harness CLI unavailable at $binary_url"
    log "warning  continuing without scripts/bin/harness-cli; re-run with --require-cli to make this fatal"
    SKIPPED=$((SKIPPED + 1))
    return 0
  fi

  if ! curl -fsSL "$checksum_url" -o "$checksum_tmp"; then
    rm -rf "$tmp_dir"
    if [ "$REQUIRE_RUST_CLI" -eq 1 ]; then
      fail "Could not download required Harness CLI checksum: $checksum_url"
    fi
    log "warning  Harness CLI checksum unavailable at $checksum_url"
    log "warning  continuing without scripts/bin/harness-cli; re-run with --require-cli to make this fatal"
    SKIPPED=$((SKIPPED + 1))
    return 0
  fi

  expected="$(awk '{ print $1; exit }' "$checksum_tmp")"
  [ -n "$expected" ] || fail "Checksum file is empty: $checksum_url"
  actual="$(sha256_file "$binary_tmp")"
  if [ "$actual" != "$expected" ]; then
    rm -rf "$tmp_dir"
    fail "Checksum mismatch for $binary_name: expected $expected, got $actual"
  fi

  mkdir -p "$(dirname "$target")"
  cp "$binary_tmp" "$target"
  chmod 755 "$target"
  rm -rf "$tmp_dir"
  log "created  scripts/bin/harness-cli"
  log "verified scripts/bin/harness-cli ($platform)"
  CREATED=$((CREATED + 1))
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
INSTALL_RUST_CLI=1
REQUIRE_RUST_CLI=0
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
    --no-cli)
      INSTALL_RUST_CLI=0
      shift
      ;;
    --require-cli)
      INSTALL_RUST_CLI=1
      REQUIRE_RUST_CLI=1
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
CLI_BASE_URL="${HARNESS_CLI_BASE_URL:-}"
CLI_BASE_URL="${CLI_BASE_URL%/}"

if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/../AGENTS.md" ] && [ -f "$SCRIPT_DIR/../docs/HARNESS.md" ]; then
  SOURCE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
  SOURCE_MODE="local"
fi

if [ -z "$CLI_BASE_URL" ]; then
  CLI_BASE_URL="$(default_cli_base_url)"
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
if [ "$INSTALL_RUST_CLI" -eq 1 ]; then
  log "Harness CLI source: $CLI_BASE_URL"
else
  log "Harness CLI source: skipped"
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
docs/HARNESS_AUDIT.md
docs/HARNESS_COMPONENTS.md
docs/HARNESS_MATURITY.md
docs/IMPROVEMENT_PROTOCOL.md
docs/CONTEXT_RULES.md
docs/PROJECT_ADOPTION.md
docs/PROJECT_GOVERNANCE.md
docs/PROJECT_START.md
docs/README.md
docs/TEST_MATRIX.md
docs/TOOL_REGISTRY.md
docs/TRACE_SPEC.md
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
scripts/schema/001-init.sql
scripts/schema/002-story-verify.sql
scripts/schema/003-tool-registry.sql
scripts/schema/004-intervention.sql
scripts/schema/005-crisp-intake-types.sql
.gitignore
EOF

install_harness_cli_binary

log ""
log "Done. Created: $CREATED, merged: $MERGED, skipped: $SKIPPED."

if [ "$SKIPPED" -gt 0 ]; then
  log "Existing non-AGENTS files were left untouched."
fi
