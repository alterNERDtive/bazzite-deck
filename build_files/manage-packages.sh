#!/usr/bin/bash
set -euo pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

# RPM packages list
declare -A RPM_PACKAGES=(
  ["fedora"]="\
    aria2c \
    btop \
    btrbk \
    chezmoi \
    mangohud \
    mpv \
    neovim \
    python3-streamlink \
    syncthing \
    thefuck \
    thunderbird \
    vkbasalt \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
  "

  ["librewolf"]="\
    librewolf \
  "

  ["rpmfusion-free,rpmfusion-free-updates,rpmfusion-nonfree,rpmfusion-nonfree-updates"]="\
    gstreamer1-plugins-bad-freeworld \
    libavcodec-freeworld \
  "

  ["vscodium"]="\
    codium \
  "

  ["copr:lnvso/heroic-games-launcher"]="\
    heroic-games-launcher-bin \
  "

  ["copr:pgdev/jellyfin"]="\
    jellyfin-media-player \
  "

  ["copr:solopasha/kitty"]="\
    kitty \
  "
)

log "Starting package management …"

log "Installing RPM packages …"
mkdir -p /var/opt
for repo in "${!RPM_PACKAGES[@]}"; do
  read -ra pkg_array <<<"${RPM_PACKAGES[$repo]}"
  if [[ $repo == copr:* ]]; then
    # Handle COPR packages
    copr_repo=${repo#copr:}
    dnf5 -y copr enable "$copr_repo"
    dnf5 -y install "${pkg_array[@]}"
    dnf5 -y copr disable "$copr_repo"
  else
    # Handle regular packages
    [[ $repo != "fedora" ]] && enable_opt="--enable-repo=$repo" || enable_opt=""
    cmd=(dnf5 -y install)
    [[ -n "$enable_opt" ]] && cmd+=("$enable_opt")
    cmd+=("${pkg_array[@]}")
    "${cmd[@]}"
  fi
done

log "Package management completed"
