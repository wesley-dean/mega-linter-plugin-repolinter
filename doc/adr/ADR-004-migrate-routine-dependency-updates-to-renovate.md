# ADR-004: Migrate Routine Dependency Updates to Central Renovate

Date: 2026-11-26

## Status

Accepted

## Decision

The repository SHALL enroll explicitly in the existing centrally managed
Jenkins Renovate service using the minimal root `renovate.json`. The
scheduled GitHub Actions Dependabot version-update ecosystem SHALL set
`open-pull-requests-limit: 0` while retaining its existing directory,
schedule, cooldown, grouping, and commit metadata.

GitHub Dependabot vulnerability alerts and advisory-driven security PRs
remain separate. The existing non-major Dependabot auto-merge workflow
remains restricted to `dependabot[bot]`; no action in this migration may
bypass required checks, code-owner review, or branch protection.

This decision **partially supersedes ADR-003** regarding Dependabot as
the active routine-update provider, the ordinary update PR limit, and
retirement of old routine Dependabot PRs. ADR-003's independent
security response, review of major and privileged dependencies, and
supply-chain governance remain applicable. The historical ADR stays intact.

## Context and Constraints

The maintainer operates a centralized Jenkins Renovate instance for
`wesley-dean/*`. Retaining scheduled Dependabot version-update PRs would
duplicate routine proposals. The repo-specific trust boundary includes
archived Repolinter 0.12.0 compatibility and unprefixed version tag lineage. This change does not alter public runtime interfaces,
artifact generation, locked dependencies, release permissions, or imported
`coding_standards` snapshots.

## Assumptions

- The external runner already discovers the repository and uses root
  enrollment, without requiring repository-specific credentials or jobs.
- Machine account access will be provisioned by the maintainer when
  approving this PR.
- Native auto-merge remains subject to mandatory human review and CI.
- Dependabot security features are configured independently and must be
  verified operationally.
- A merged enrollment file does not establish that Renovate has run.

## Alternatives Considered

1. Keep Dependabot routine scheduling: rejected because it duplicates
   the central Renovate workflow.
2. Delete Dependabot configuration: rejected in order to preserve the
   ecosystem metadata and independent security-update controls.
3. Add repository-local Renovate Actions or secrets: rejected because the
   centrally hosted runner already owns scheduling and signing.
4. Extend Dependabot auto-merge to Renovate: rejected because it blurs
   identity-specific security and approval boundaries.
5. Convert verified immutable action SHA pins to floating tags: rejected
   as an unnecessary supply-chain downgrade.

## Migration, Consequences, and Threats

Enroll Renovate, disable ordinary Dependabot proposals, and normalize
GitHub Actions SHA annotation comments only when their release mapping
is verified against upstream Git tags. When a SHA cannot be mapped to a
valid upstream version, it MAY be replaced by a syntactically valid
moving `@version` reference without an obsolete `# pin@` comment,
documenting the temporary trust downgrade until Renovate proposes a
reviewed and verified immutable replacement. Never emit a `uses:`
reference without an `@ref`.

After the migration PR exists, conclusively routine Dependabot PRs may
be closed with an explanatory migration link. Security-specific or
ambiguous PRs remain open. The change does not assert successful
Renovate execution, dependency compatibility, or security alerting.

The central bot has repository branch-writing authority, and an upstream
action, signing credential, or release workflow could be compromised.
Retain least privilege, signed changes, required checks, human CODEOWNER
approval, verified pins, and risk-based review of privileged publishing.
Any temporary moving reference requires targeted review before relying
on its behavior.

## Related Decisions

ADR-003 governs previous grouped Dependabot maintenance.
Other accepted ADRs governing archived Repolinter 0.12.0 compatibility and unprefixed version tag lineage remain authoritative.
