#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$ROOT_DIR/scripts/governance-intake"

fail() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

assert_file() {
  [ -f "$1" ] || fail "expected file: $1"
}

assert_no_path() {
  [ ! -e "$1" ] || fail "unexpected path: $1"
}

assert_contains() {
  local file="$1"
  local pattern="$2"
  rg -q "$pattern" "$file" || fail "expected pattern '$pattern' in $file"
}

TMP_ROOT="$(mktemp -d /tmp/governance-intake-test.XXXXXX)"
ANSWERS="$TMP_ROOT/answers.env"
DRY_TARGET="$TMP_ROOT/dry"
REAL_TARGET="$TMP_ROOT/real"

cat > "$ANSWERS" <<'EOF'
PROJECT_NAME=Neighborhood Clinic Scheduler
PROJECT_PURPOSE=Help clinics define slots and patients request appointments.
TARGET_USERS=clinic staff and patients
MAIN_WORKFLOWS=slot setup; patient booking; confirmation review
CORE_CONCEPTS=clinic; slot; appointment; patient
SURFACES=browser, API
SENSITIVE_DATA=patient contact details and appointment times
RISK_AREAS=auth, personal data, external notifications
STACK_DECISIONS=not decided
STACK_UNKNOWNS=database, hosting, notification provider
PROOF_EXPECTATIONS=document review first, then integration and e2e after implementation exists
FIRST_SLICE=patient requests an available appointment slot
EOF

mkdir -p "$DRY_TARGET" "$REAL_TARGET"

"$SCRIPT" --directory "$DRY_TARGET" --answers "$ANSWERS" --dry-run --yes > "$TMP_ROOT/dry.out"
assert_no_path "$DRY_TARGET/docs/intake"
assert_contains "$TMP_ROOT/dry.out" "DRY-RUN create docs/intake/"
assert_contains "$TMP_ROOT/dry.out" "DRY-RUN create docs/product/overview.md"

"$SCRIPT" --directory "$REAL_TARGET" --answers "$ANSWERS" --yes > "$TMP_ROOT/real.out"

assert_file "$REAL_TARGET/docs/intake/INTAKE-project-start.md"
assert_file "$REAL_TARGET/docs/product/overview.md"
assert_file "$REAL_TARGET/docs/stories/backlog.md"
assert_file "$REAL_TARGET/docs/TEST_MATRIX.md"
assert_file "$REAL_TARGET/docs/decisions/0001-project-start-governance.md"

assert_contains "$REAL_TARGET/docs/intake/INTAKE-project-start.md" "Neighborhood Clinic Scheduler"
assert_contains "$REAL_TARGET/docs/product/overview.md" "Help clinics define slots"
assert_contains "$REAL_TARGET/docs/stories/backlog.md" "patient requests an available appointment slot"
assert_contains "$REAL_TARGET/docs/TEST_MATRIX.md" "GOV-001"
assert_contains "$REAL_TARGET/docs/decisions/0001-project-start-governance.md" "not decided"

assert_no_path "$REAL_TARGET/src"
assert_no_path "$REAL_TARGET/app"
assert_no_path "$REAL_TARGET/package.json"
assert_no_path "$REAL_TARGET/.github/workflows"

if "$SCRIPT" --directory "$REAL_TARGET" --answers "$ANSWERS" --yes > "$TMP_ROOT/repeat.out" 2>&1; then
  fail "expected repeat run without --force to fail"
fi
assert_contains "$TMP_ROOT/repeat.out" "Refusing to overwrite"

printf 'governance-intake validation passed: %s\n' "$TMP_ROOT"
