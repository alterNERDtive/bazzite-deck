#!/usr/bin/bash
set -euo pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "Adding just recipes …"
echo "import \"/usr/share/alterNERDtive/bazzite-deck.just\"" >>/usr/share/ublue-os/justfile
