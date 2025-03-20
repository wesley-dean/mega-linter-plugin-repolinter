#!/usr/bin/env bash

set -euo pipefail

run_megalinter() {
  docker run \
    --rm \
    -it \
    -v "$(pwd):/tmp/lint" \
    -w "/tmp/lint" \
    -e VALIDATE_ALL_CODEBASE=true \
    -e REPORT_OUTPUT_FOLDER=none \
    -e DISABLE_ERRORS=true \
    -e PRINT_ALPACA=false \
    -e SARIF_REPORTER=false \
    -e PLUGINS="[\"file://mega-linter-plugin-repolinter/repolinter.megalinter-descriptor.yml\"]" \
    -e ENABLE_LINTERS="[\"REPOSITORY_REPOLINTER\"]" \
    -e REPOSITORY_REPOLINTER_ARGUMENTS="$*" \
    docker.io/oxsecurity/megalinter-ci_light:latest
}

echo -e "###\n###\n### Running Mega-Linter with repolinter on an error-free repository\n###\n###"
run_megalinter -g "https://github.com/todogroup/repolinter.git"
echo -e "###\n###\n### Running Mega-Linter with repolinter on repository known to have errors\n###\n###"
run_megalinter -g "https://github.com/wesley-dean/aws-openbsd.git"
