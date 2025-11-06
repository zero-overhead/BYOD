#!/usr/bin/env bash
#
# bash -c "$(curl -H 'Pragma: no-cache' -fsSL https://raw.githubusercontent.com/zero-overhead/BYOD/refs/heads/main/setup.sh)" -s x86_64-Server.nix
# or
# curl -H 'Pragma: no-cache' -fsSL https://raw.githubusercontent.com/zero-overhead/BYOD/refs/heads/main/setup.sh | bash -s x86_64-Server.nix
#

if ! command -v git >/dev/null 2>&1
then
    echo "<git> could not be found"
    echo "run: nix-shell -p git"
    exit 1
fi

#MYNIXVERSION=nixos-unstable
MYNIXVERSION=nixos-25.05
PROJECT=BYOD

# take the last argument as config 
for i in "$@"; do :; done
MYNIXCONFIG=$i

sudo nix-channel --list
sudo nix-channel --remove nixos
sudo nix-channel --add https://channels.nixos.org/$MYNIXVERSION nixos
sudo nix-channel --list
sudo nix-channel --update nixos

echo "Using $HOME/$PROJECT/$MYNIXCONFIG"
cd $HOME

rm -rf $PROJECT
git clone --depth 1 --recurse-submodules https://github.com/zero-overhead/$PROJECT
cd $PROJECT

#create new hardware-configuration
sudo nixos-generate-config

# apply configuration
sudo nixos-rebuild switch --upgrade -I nixos-config=$MYNIXCONFIG

# cleanup
rm -rf $HOME/$PROJECT

# reboot to apply changes
echo sudo reboot
