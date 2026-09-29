#!/usr/bin/env bats

setup() {
  DESCRIPTOR="${BATS_TEST_DIRNAME}/../mega-linter-plugin-repolinter/repolinter.megalinter-descriptor.yml"
}

@test "descriptor pins the final upstream Repolinter release" {
  grep -Fq 'RUN npm install --global repolinter@0.12.0' "${DESCRIPTOR}"
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
