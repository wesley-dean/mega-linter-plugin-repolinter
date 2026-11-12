# Architectural Decisions

This digest summarizes Accepted ADRs. The complete ADR text governs where
a summary is incomplete; applicable released standards and explicit local
policy also apply.

## ADR-001: Support the Archived Repolinter 0.12.0 Release

The plugin pins the archived upstream `repolinter@0.12.0`, uses the
documented `lint` subcommand in project mode, and preserves dry-run
behavior and local deterministic fixture tests. The repository owns the
MegaLinter adapter only and does not imply maintenance of the archived
upstream project.

See [ADR-001](adr/ADR-001-support-archived-repolinter-0.12.0.md).

## ADR-002: Publish Versioned Descriptor Release Assets

The generated descriptor and SHA-256 companion are validated before a
separate release-publication job publishes them. Normal consumers can
pin released descriptors, and future GitHub Releases retain the
repository's unprefixed semantic version tag lineage.

See [ADR-002](adr/ADR-002-publish-versioned-descriptor-release-assets.md).

## ADR-003: Consolidate GitHub Actions Dependabot Version Updates

Routine GitHub Actions version updates remain weekly, retain a seven-day
cooldown, and group eligible major, minor, and patch versions. Security
updates remain independent, while groups containing a major upgrade
require review outside the existing non-major-only auto-merge path.
Existing open Dependabot PRs are not presumed replaced.

See [ADR-003](adr/ADR-003-consolidate-github-actions-dependabot-maintenance.md).
