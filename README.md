# mega-linter-plugin-repolinter

[![MegaLinter](https://github.com/wesley-dean/mega-linter-plugin-repolinter/actions/workflows/megalinter.yml/badge.svg)](https://github.com/wesley-dean/mega-linter-plugin-repolinter/actions/workflows/megalinter.yml)
[![Dependabot Updates](https://github.com/wesley-dean/mega-linter-plugin-repolinter/actions/workflows/dependabot/dependabot-updates/badge.svg)](https://github.com/wesley-dean/mega-linter-plugin-repolinter/actions/workflows/dependabot/dependabot-updates)
[![Scorecard supply-chain security](https://github.com/wesley-dean/mega-linter-plugin-repolinter/actions/workflows/scorecard.yml/badge.svg)](https://github.com/wesley-dean/mega-linter-plugin-repolinter/actions/workflows/scorecard.yml)

This repository provides a MegaLinter plugin for
[Repolinter](https://github.com/todogroup/repolinter) by the TODO Group.

> [!IMPORTANT]
> The upstream Repolinter project was archived by the TODO Group on February 6,
> 2026, and is no longer actively maintained.  This plugin intentionally pins
> the final upstream release, Repolinter 0.12.0.  This repository maintains the
> MegaLinter integration only; it does not fork or assume maintenance of
> Repolinter itself.

Repolinter checks repositories for policy and best-practice expectations defined
in a ruleset.  Because the upstream tool is archived, users should evaluate
whether a frozen upstream dependency is appropriate for their compatibility and
security requirements.

## MegaLinter Configuration

Released descriptors are the supported distribution channel for normal
MegaLinter use.  For reproducible CI and production workflows, pin the plugin to
a specific release:

```yaml
PLUGINS:
  - "https://github.com/wesley-dean/mega-linter-plugin-repolinter/releases/download/0.1.0/repolinter.megalinter-descriptor.yml"
```

When deliberately following the newest released plugin version, use the
latest-release asset:

```yaml
PLUGINS:
  - "https://github.com/wesley-dean/mega-linter-plugin-repolinter/releases/latest/download/repolinter.megalinter-descriptor.yml"
```

Pinning a release is preferred when build reproducibility matters.  The
`releases/latest/download/` form trades that reproducibility for automatic
adoption of newly published plugin releases.

Depending on the rest of the MegaLinter configuration, explicitly enable the
linter when necessary:

```yaml
ENABLE_LINTERS:
  - "REPOSITORY_REPOLINTER"
```

The descriptor runs Repolinter in project mode with the documented `lint`
subcommand and `--dryRun` by default.  When MegaLinter is explicitly configured
to apply fixes, the descriptor permits MegaLinter to remove `--dryRun` using
its normal fix-mode behavior.

## Repolinter Configuration

Repolinter 0.12.0 discovers rulesets in the target repository.  Upstream supports
`repolint.json`, `repolinter.json`, `repolint.yaml`, and
`repolinter.yaml`, as well as explicit ruleset arguments.

See the archived upstream documentation for rule syntax:

- [Rules](https://github.com/todogroup/repolinter/blob/main/docs/rules.md)
- [Repolinter README](https://github.com/todogroup/repolinter)

## Releases

Each plugin release publishes:

```text
repolinter.megalinter-descriptor.yml
repolinter.megalinter-descriptor.yml.sha256
```

The distributed descriptor records the plugin release version and exact source
commit that produced it.  It also contains the explicit
`repolinter@0.12.0` installation pin.

Release validation exercises the generated descriptor through MegaLinter before
publication.  The validated files cross into a separate publication job, where
the exact file set and checksum are verified again before GitHub creates the
release.

The descriptor stored on `main` remains useful for plugin development and
testing, but normal consumers should use a release asset rather than development
state.

## Development

Behavioral tests use deterministic local fixture repositories.  They do not clone
live third-party repositories, so a test result changes only when this repository,
the pinned MegaLinter image, or the pinned Repolinter package changes.

Useful targets are:

```bash
make test
make validate
make build
make validate-release
make integration-test
make clean
```

`make test` runs Bats assertions for the descriptor and release build.
`make validate` validates the maintained descriptor against the schema from
MegaLinter 10.1.0.  `make integration-test` loads the generated descriptor
through MegaLinter 10.1.0 and verifies that a compliant fixture passes while a
noncompliant fixture fails.

For a local release-style build:

```bash
make build VERSION=0.1.0 BUILD_REF="$(git rev-parse HEAD)"
```

## Repository Governance

This repository adopts released engineering standards from
[`wesley-dean/coding_standards`](https://github.com/wesley-dean/coding_standards).
The complete pinned snapshot is committed beneath `doc/standards/`, while
`.codingstandardrc` records the adopted release and verified archive digest.

Applicable files beneath `doc/standards/` are project requirements, subject to
accepted repository-specific ADRs and explicit local policy.  Imported standards
are managed as a release snapshot and are not edited locally to create
project-specific exceptions.
