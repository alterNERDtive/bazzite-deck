#!/bin/bash

set -ouex pipefail

### Install packages

# setup LibreWolf repo
cat > /etc/yum.repos.d/librewolf.repo << EOF
[repository]
name=LibreWolf Software Repository
baseurl=https://repo.librewolf.net
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://repo.librewolf.net/pubkey.gpg
EOF

coprs=(
  lnvso/heroic-games-launcher
  sammyette/jellyfin-media-player
  solopasha/kitty
)

for copr in ${coprs[@]}; do
  dnf -y copr enable $copr
done

packages=(
  btrbk
  heroic-games-launcher-bin
  jellyfin-media-player
  librewolf
  mpv
  neovim
  python3-streamlink
  syncthing
  zsh
)

dnf -y remove mpv-nightly-libs

dnf -y install ${packages[@]}

for copr in ${coprs[@]}; do
  dnf -y copr disable $copr
done

flatpaks=(
  com.bitwarden.desktop
  me.kozec.syncthingtk
  net.davidotek.pupgui2
)

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

for pak in ${flatpaks[@]}; do
  flatpak -y install --system flathub $pak
done

stgfile=https://github.com/streamlink/streamlink-twitch-gui/releases/download/v2.5.3/streamlink-twitch-gui-v2.5.3-x86_64.AppImage

mkdir /usr/share/streamlink-twitch-gui
pushd /usr/share/streamlink-twitch-gui
wget $stgfile
chmod +x $(basename $stgfile)
popd

cat > /usr/bin/streamlink-twitch-gui << EOF
#!/usr/bin/env bash
rm -rf ~/.config/streamlink-twitch-gui/Default/GPUCache/
/usr/share/streamlink-twitch-gui/$(basename $stgfile) --enable-features=UseOzonePlatform --ozone-platform=wayland "$@"
EOF
chmod +x /usr/bin/streamlink-twitch-gui

cat > /usr/share/applications/streamlink-twitch-gui.desktop << EOF
[Desktop Entry]
Name=Streamlink Twitch GUI
Exec=/usr/bin/streamlink-twitch-gui
EOF

#### Example for enabling a System Unit File

# systemctl enable podman.socket
