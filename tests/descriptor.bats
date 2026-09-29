#!/usr/bin/env bats

setup() {
  DESCRIPTOR="${BATS_TEST_DIRNAME}/../mega-linter-plugin-repolinter/repolinter.megalinter-descriptor.yml"
}

@test "descriptor pins the final upstream Repolinter release" {
  grep -Fq 'RUN npm install --global repolinter@0.12.0' "${DESCRIPTOR}"
}

@test "descriptor identifies the upstream linter repository" {
  grep -Fq 'linter_repo: "https://github.com/todogroup/repolinter"' "${DESCRIPTOR}"
}

@test "descriptor pins upstream rules documentation to Repolinter 0.12.0" {
  grep -Fq 'linter_rules_url: "https://github.com/todogroup/repolinter/blob/063fd3578ffd6ce4d95580adb1368a7e25075fc1/docs/rules.md"' "${DESCRIPTOR}"
}

@test "descriptor accepts Repolinter symbol output with or without emoji variation selectors" {
  grep -Fq 'cli_lint_warnings_regex: "(?m)^⚠(?:️)?\\s"' "${DESCRIPTOR}"
  grep -Fq 'cli_lint_errors_regex: "(?m)^✖(?:️)?\\s"' "${DESCRIPTOR}"
}

@test "descriptor exposes project mode only" {
  grep -Fq 'cli_lint_mode: "project"' "${DESCRIPTOR}"
  grep -Fq 'supported_cli_lint_modes:' "${DESCRIPTOR}"
  grep -Fq '      - "project"' "${DESCRIPTOR}"
}

@test "descriptor uses the documented lint subcommand" {
  grep -Fq '      - "lint"' "${DESCRIPTOR}"
  grep -Fq '      - "--dryRun"' "${DESCRIPTOR}"
  grep -Fq '      - "--format=console"' "${DESCRIPTOR}"
}

@test "descriptor leaves ruleset discovery to Repolinter" {
  grep -Fq 'cli_config_arg_name: ""' "${DESCRIPTOR}"
}
