#!/usr/bin/env bash

set -e
set -u
set -o pipefail

is_app_installed() {
    type "$1" &>/dev/null
}

INSTALL_DIR="${HOME}/.config"
PLUGINS_DIR="${INSTALL_DIR}/tmux/plugins"

REPODIR="$(
    cd "$(dirname "$0")"
    pwd -P
)"
cd "$REPODIR"

if ! is_app_installed tmux; then
    printf "ERROR: \"tmux\" not found\!\n"
    printf "       Please install it first.\n"
    exit 1
fi

TMUX_VERSION=$(tmux -V | awk '{gsub(/[^0-9.]/, "", $2); print ($2+0) * 100}')

if [ "$TMUX_VERSION" -lt 320 ]; then
    printf "ERROR: $(tmux -V) not supported\!\n"
    printf "       Please install version tmux 3.2 or newer first.\n"
    exit 1
fi

mkdir -p "${PLUGINS_DIR}"

if [ ! -e "${PLUGINS_DIR}/tpm" ]; then
    printf "WARNING: Cannot find TPM (Tmux Plugin Manager)\n"
    printf "         at default location: ${PLUGINS_DIR}/tpm.\n"
    git clone https://github.com/tmux-plugins/tpm "${PLUGINS_DIR}/tpm"
fi

if [ -e "${HOME}/.tmux.conf" ]; then
    printf "WARNING: Found existing .tmux.conf file in \$HOME directory.\n"
    printf "         It will be moved to ${INSTALL_DIR}/tmux/tmux.conf.home\n"
    mv "${HOME}/.tmux.conf" "${INSTALL_DIR}/tmux/tmux.conf.home" 2>/dev/null || true
fi

if [ -e "${INSTALL_DIR}/tmux/tmux.conf" ]; then
    printf "WARNING: Found existing tmux.conf file \$HOME/.config/tmux directory.\n"
    printf "         It will be moved to ${INSTALL_DIR}/tmux/tmux.conf.config\n"
    mv "${INSTALL_DIR}/tmux/tmux.conf" "${INSTALL_DIR}/tmux/tmux.conf.config" 2>/dev/null || true
fi

cp -a ./tmux/* "${INSTALL_DIR}"/tmux/

# Install TPM plugins.
# TPM requires running tmux server, as soon as `tmux start-server` does not work
# create dump __noop session in detached mode, and kill it when plugins are installed
printf "Install TPM plugins\n"
tmux new -d -s __noop >/dev/null 2>&1 || true
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "${PLUGINS_DIR}"
"${PLUGINS_DIR}"/tpm/bin/install_plugins || true
tmux kill-session -t __noop >/dev/null 2>&1 || true

# Fix percetange stats padding in status bar
SYSSTAT_DIR="${PLUGINS_DIR}"/tmux-plugin-sysstat/scripts
[ -d "${SYSSTAT_DIR}" ] && sed -i 's/%.[01]f%%/%2.0f%%/g' "${SYSSTAT_DIR}"/{cpu,mem,swap}.sh || true

printf "\nOK: Completed\n"
