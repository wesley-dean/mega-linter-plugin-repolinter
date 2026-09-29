# ADR-001: Support the Archived Repolinter 0.12.0 Release

Date: 2026-09-29

## Status

Accepted

## Context

This repository exists to expose TODO Group Repolinter as a MegaLinter plugin.
The upstream repository is `todogroup/repolinter`, and its final published
release is 0.12.0, released on May 9, 2025.

The TODO Group archived Repolinter on February 6, 2026.  The upstream repository
is read-only and explicitly states that the project has been archived.  Continued
upstream compatibility, dependency maintenance, and security fixes therefore
cannot be assumed.

The plugin previously installed `repolinter` from npm without a version, tested
against live Git repositories, and relied on older CLI examples.  Those choices
made plugin behavior depend on external state even though the upstream
implementation is now frozen.

## Decision Drivers

- Existing MegaLinter users should retain `REPOSITORY_REPOLINTER`.
- Plugin behavior should identify exactly which archived upstream implementation
  it runs.
- Tests should remain meaningful even when unrelated GitHub repositories change.
- The plugin should use Repolinter's documented CLI contract rather than relying
  on wildcard command behavior.
- Maintaining a MegaLinter adapter must not silently become ownership of the
  archived JavaScript project and its dependency tree.
- The archive status and maintenance boundary should be visible to users.

## Decision

The plugin SHALL support Repolinter 0.12.0 and SHALL install that package
explicitly as `repolinter@0.12.0`.

The descriptor SHALL use Repolinter's documented `lint` subcommand and SHALL
support MegaLinter `project` mode only.  It SHALL run with `--dryRun` by
default while preserving MegaLinter's existing fix-mode mechanism that removes
that argument when fixes are explicitly enabled.

Repolinter SHALL perform its own ruleset discovery.  The descriptor SHALL set
`cli_config_arg_name` to an empty value so MegaLinter does not apply its generic
`-c` configuration argument.  Repolinter defines `-c` as `--rulesetEncoded`, so
passing a discovered `repolinter.json` path through that flag would misinterpret
the filename as a base64-encoded ruleset.

Integration tests SHALL use repository-owned local fixtures with deterministic
rulesets.  Tests SHALL NOT depend on cloning live external repositories merely to
obtain pass/fail examples.

Project documentation SHALL state that upstream Repolinter was archived on
February 6, 2026, identify 0.12.0 as the pinned final upstream release, and link
to the canonical `todogroup/repolinter` repository.

This repository SHALL maintain the MegaLinter integration.  It SHALL NOT claim to
maintain Repolinter itself.  A future decision to fork, patch, or replace the
archived upstream implementation requires a new ADR.

## Alternatives Considered

### Continue Installing Unversioned repolinter

Rejected because an unversioned package request is an unnecessary mutable input.
The plugin's intended upstream implementation is now known and frozen.

### Continue Testing Against Live GitHub Repositories

Rejected because changes, deletion, availability, rate limits, or policy changes
in unrelated repositories can change the plugin test result without a plugin
commit.

### Fork Repolinter

Rejected for the current scope.  A fork would transfer responsibility for an
archived JavaScript application and its dependency graph into this project,
which is materially larger than maintaining a MegaLinter descriptor.

### Retire the Plugin Immediately

Rejected because Repolinter 0.12.0 remains usable and existing consumers benefit
from a stable, explicit integration.  The archive status is disclosed so users
can make their own maintenance and security decision.

## Consequences

### Positive

- Plugin installations consistently request Repolinter 0.12.0.
- Tests are deterministic with respect to repository contents.
- The CLI shape matches the archived upstream documentation.
- Users receive an explicit warning about the upstream maintenance state.
- The scope of this repository remains bounded to MegaLinter integration.

### Negative

- Repolinter's transitive npm dependencies remain governed by the archived
  package's dependency declarations and npm resolution behavior.
- Upstream defects or compatibility problems may have no upstream fix.
- Future Node.js or MegaLinter changes may eventually make Repolinter 0.12.0
  unusable without a new architectural decision.

## Compatibility and Migration

The public MegaLinter linter key remains `REPOSITORY_REPOLINTER`, and the
descriptor path remains
`mega-linter-plugin-repolinter/repolinter.megalinter-descriptor.yml`.

Existing Repolinter rulesets remain upstream Repolinter configuration and are not
rewritten by this decision.

## Expected Outcome

The plugin provides a transparent, deterministic MegaLinter integration for the
final archived Repolinter release without implying that this repository has
taken ownership of upstream Repolinter maintenance.
