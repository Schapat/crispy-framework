-- Crisp Harness v0 schema - migration 005
-- Align durable intake records with docs/WORK_INTAKE.md input types.

PRAGMA foreign_keys = OFF;

CREATE TABLE intake_new (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at    TEXT    NOT NULL DEFAULT (datetime('now')),
    input_type    TEXT    NOT NULL
                         CHECK(input_type IN (
                           'new_spec','spec_slice','change_request',
                           'new_initiative','maintenance',
                           'existing_project_adoption',
                           'first_existing_project_adoption',
                           'harness_improvement','prototype','resume_request'
                         )),
    summary       TEXT    NOT NULL,
    risk_lane     TEXT    NOT NULL
                         CHECK(risk_lane IN ('tiny','normal','high_risk')),
    risk_flags    TEXT,
    affected_docs TEXT,
    story_id      TEXT,
    notes         TEXT
);

INSERT INTO intake_new (
    id, created_at, input_type, summary, risk_lane, risk_flags,
    affected_docs, story_id, notes
)
SELECT
    id, created_at, input_type, summary, risk_lane, risk_flags,
    affected_docs, story_id, notes
FROM intake;

DROP TABLE intake;
ALTER TABLE intake_new RENAME TO intake;

PRAGMA foreign_keys = ON;

INSERT INTO schema_version (version) VALUES (5);
