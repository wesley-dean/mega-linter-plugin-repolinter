# ADR-002: Publish Versioned Repolinter Descriptor Release Assets

Date: 2026-09-29

## Status

Accepted

## Context

The repository already publishes semantic GitHub releases, but historical
releases contain no plugin descriptor assets.  Documentation previously pointed
consumers at the mutable descriptor on `main`.

Historical release automation also created both `0.0.x` and `v0.0.x` tags for
the same commits.  GitHub Releases are attached to the unprefixed `0.0.x` tags.

A plugin descriptor is executable configuration: MegaLinter loads it and runs its
installation commands.  Normal consumers therefore benefit from an explicit,
reviewed release boundary rather than silently following development state.

## Decision Drivers

- Consumers should be able to pin an immutable plugin version in CI.
- Consumers who deliberately follow releases should have a stable latest-release
  URL that is distinct from `main`.
- Distributed descriptor bytes should be validated directly before publication.
- Publication authority should be isolated from jobs that execute repository
  source and plugin tests.
- Existing visible release numbering should remain continuous.
- Historical duplicate tag creation should not continue.

## Decision

Every future GitHub release SHALL include:

```text
repolinter.megalinter-descriptor.yml
repolinter.megalinter-descriptor.yml.sha256
```

The release build SHALL generate the distributed descriptor from the maintained
descriptor, record the release version and exact 40-character source commit SHA
in YAML comments, and generate the accompanying SHA-256 checksum.

The generated descriptor SHALL retain the explicit `repolinter@0.12.0`
installation pin established by ADR-001.

Release validation SHALL test the generated descriptor itself, including schema
validation, checksum verification, a passing local repository fixture, and a
failing local repository fixture through MegaLinter.

Only after validation succeeds SHALL a separate publication job receive the
release files.  That job SHALL re-verify the exact file set and checksum before
creating the GitHub release.

The repository SHALL continue using unprefixed semantic versions for GitHub
release tags, consistent with existing releases such as `0.0.17`.  New release
automation SHALL NOT intentionally create the duplicate `vX.Y.Z` tag that the
historical workflow also produced.

Documentation SHALL recommend a version-pinned release asset for reproducible CI:

```text
https://github.com/wesley-dean/mega-linter-plugin-repolinter/releases/download/X.Y.Z/repolinter.megalinter-descriptor.yml
```

Documentation MAY also offer the following URL when a consumer intentionally
wants the newest published plugin release:

```text
https://github.com/wesley-dean/mega-linter-plugin-repolinter/releases/latest/download/repolinter.megalinter-descriptor.yml
```

MegaLinter validates the configured plugin string before downloading it.  Both
documented HTTPS forms satisfy the required `/mega-linter-plugin-` substring
because the repository name is `mega-linter-plugin-repolinter`.

Local integration testing SHALL stage a byte-identical copy of the generated
descriptor beneath a temporary `mega-linter-plugin-` directory because the
natural `file://dist/...` path does not satisfy MegaLinter's local-plugin path
check.  That staging path is a test accommodation and does not change the public
release artifact filename.

## Alternatives Considered

### Continue Recommending main

Rejected because branch content is mutable and does not represent an explicit
release decision.

### Publish Releases Without Descriptor Assets

Rejected because the GitHub Release would remain disconnected from the actual
configuration MegaLinter consumes.

### Continue Creating Duplicate Prefixed and Unprefixed Tags

Rejected because one release identity is sufficient.  Existing GitHub Releases
already establish the unprefixed tag convention.

### Build and Publish in One Privileged Job

Rejected because validation does not need release-publishing authority.
Separating those capabilities narrows the publication trust boundary.

## Consequences

### Positive

- Consumers can pin plugin descriptor versions.
- The latest-release URL follows releases rather than development state.
- Published descriptor bytes are tested before publication.
- Release assets include an integrity checksum and source provenance comments.
- Future releases stop adding duplicate tag identities.

### Negative

- Release automation becomes more involved.
- Historical releases remain asset-less unless deliberately backfilled.
- A checksum distributed beside an asset detects byte changes but is not an
  independent authentication mechanism.

## Compatibility and Migration

Existing release tags remain untouched.  Existing consumers of the raw `main`
descriptor continue to work, but documentation now recommends release assets.

The PR containing this decision is feature-bearing, so under the repository's
semantic-release governance its expected next release is 0.1.0 after 0.0.17,
subject to the reviewed merge title and release workflow.

## Expected Outcome

A consumer can choose explicitly between a version-pinned Repolinter plugin and
automatic adoption of newly published plugin releases without following
development state.
