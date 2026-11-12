# ADR-003: Consolidate GitHub Actions Dependabot Version Updates

Date: 2026-11-12

## Status

Accepted

## Decision

Retain weekly GitHub Actions Dependabot routine version updates with
the existing seven-day cooldown. Replace the minor/patch-only group
with a broad `actions-version-updates` group specifying
`applies-to: version-updates`, `patterns: ["*"]`, and no
`update-types` limitation. Eligible major, minor, and patch versions
can appear in one routine group.

Keep Dependabot security updates independent of this group and its
schedule/cooldown. Retain the existing non-major-only auto-merge
condition using `dependabot/fetch-metadata`. Any major-containing
group must receive targeted manual review of each dependency.

## Context and Constraints

Separate major-update PRs increase review effort despite the weekly
minor/patch group. The verified `coding_standards@v3.2.0` release
recommends broad weekly per-ecosystem version grouping with a seven-day
cooldown, without weakening security-update handling or major review.

Repolinter upstream was archived; ADR-001 pins its final published
`repolinter@0.12.0` dependency, project-mode invocation, documented
`lint` subcommand, and local deterministic fixtures. The plugin
maintains its adapter rather than assuming upstream maintenance.
ADR-002 governs the validated published descriptor and checksum,
separate publication job, and **unprefixed** version tag convention.
These contracts must remain unchanged.

Only the GitHub Actions ecosystem is currently configured for
Dependabot. Existing workflow permissions and release authority are
unchanged. GitHub-side CODEOWNERS/required reviews, branch protections,
security alerts, and security-update settings need separate live
verification rather than inference from YAML.

## Alternatives Considered

1. **Keep minor/patch grouping.** Rejected because major updates
   continue to create separate routine PRs without automatically
   improving their review.
2. **Group all routine SemVer levels per ecosystem.** Selected
   with manual scrutiny for major-containing changes.
3. **Use monthly scheduling or longer cooldown.** Rejected without
   evidence that slower dependency visibility is appropriate.
4. **Auto-merge major-containing groups.** Rejected due to potential
   breaking changes and altered CI/release privileges.
5. **Close existing Dependabot PRs on configuration change.** Rejected
   because replacement coverage and tests have not been established.

## Tradeoffs and Consequences

The broader group may reduce PR count but does not guarantee one PR
weekly or automatically reconcile existing PRs. A grouped failure may
be harder to diagnose. Incompatible or privileged actions may justify
a narrowly documented group exclusion rather than an ignore rule.

Each changed action still requires inspection of release notes, workflow
authority, compatibility, and test evidence. A passing linter is not
proof that archived Repolinter still works or the descriptor publishing
boundary is safe. Existing Dependabot PRs #78, #80, and #96 remain
untouched until actually superseded and independently verified.

## Expected Outcomes and Verification

Observe subsequent Dependabot updates, verify that any major-containing
group is held out of automatic merging, and examine actual tests and
security-update configuration. Measure PR volume and review effort
without making unsupported reduction claims.

This policy does not modify the pinned Repolinter package, public
`REPOSITORY_REPOLINTER` interface, descriptor, test fixtures,
release assets, or unprefixed semantic tag lineage.

## Related Decisions

ADR-001 governs the archived upstream compatibility contract;
ADR-002 governs descriptor release assets and publication authority.
Neither is superseded here.
