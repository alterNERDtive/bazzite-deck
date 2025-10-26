#!/usr/bin/bash
set -euo pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "Starting Prep …"

declare -a DELETE_LIST=(
  mpv-nightly-libs
  wallpaper-engine-kde-plugin
)

log "Removing packages …"

dnf -y remove ${DELETE_LIST[@]}

log "Prep completed"
