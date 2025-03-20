# mega-linter-plugin-repolinter

[![MegaLinter](https://github.com/wesley-dean/mega-linter-plugin-repolinter/actions/workflows/megalinter.yml/badge.svg)](https://github.com/wesley-dean/mega-linter-plugin-repolinter/actions/workflows/megalinter.yml)
[![Dependabot Updates](https://github.com/wesley-dean/mega-linter-plugin-repolinter/actions/workflows/dependabot/dependabot-updates/badge.svg)](https://github.com/wesley-dean/mega-linter-plugin-repolinter/actions/workflows/dependabot/dependabot-updates)
[![Scorecard supply-chain security](https://github.com/wesley-dean/mega-linter-plugin-repolinter/actions/workflows/scorecard.yml/badge.svg)](https://github.com/wesley-dean/mega-linter-plugin-repolinter/actions/workflows/scorecard.yml)

This is a MegaLinter plugin for Repolinter

## Introduction

[MegaLinter](https://github.com/oxsecurity/megalinter) by
[OxSecurity](https://github.com/oxsecurity) is a linter tool that supports
various programming languages and file formats. This repository contains a
MegaLinter plugin for
[repolinter](https://github.com/togogroup/repolinter) by
[TODO Group](https://github.com/todogroup/).

Repolinter is a tool that checks repositories for common issues and best
practices. It is designed to be run as part of a CI/CD pipeline to ensure that
repositories are following best practices.


## Usage

To use this plugin, you need to have MegaLinter installed. Please refer to the
[MegaLinter documentation](https://nvuillam.github.io/megalinter/) for
installation instructions.

### MegaLinter Configuration

To use this plugin, add the following to your MegaLinter configuration:

```yaml
PLUGINS:
  - "https://raw.githubusercontent.com/wesley-dean/mega-linter-plugin-repolinter/refs/heads/main/mega-linter-plugin-repolinter/repolinter.megalinter-descriptor.yml
```

Simply adding the plugin to the `PLUGINS` section will cause MegaLiner to read
the descriptor and make it available for use.  However, depending on your
MegaLinter configuration, you may need to enable the linter in the `ENABLE_LINTERS`
section as well.  For example:

```yaml
ENABLE_LINTERS:
  - "REPOSITORY_REPOLINTER"
```
