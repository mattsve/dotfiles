#!/bin/bash
set -euo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# shellcheck source=../lib.sh
source "${SCRIPT_DIR}/../lib.sh"

AGENT_TOML="${HOME}/.config/1Password/ssh/agent.toml"
if [[ ! -f "${AGENT_TOML}" ]]; then
    mkdir -p "$(dirname "${AGENT_TOML}")"
    cat > "${AGENT_TOML}" <<'EOF'
[[ssh-keys]]
vault = "Private"

[[ssh-keys]]
vault = "Borgbase"
EOF
    echo "  Created ${AGENT_TOML}"
fi
