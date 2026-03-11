#!/bin/bash
set -euo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# shellcheck source=../lib.sh
source "${SCRIPT_DIR}/../lib.sh"

append_if_missing "${HOME}/.zshenv" 'export OPENCODE_EXPERIMENTAL_PLAN_MODE=1'
