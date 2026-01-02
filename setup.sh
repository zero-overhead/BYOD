#!/usr/bin/env bash
#
# bash -c "$(curl -H 'Pragma: no-cache' -fsSL https://raw.githubusercontent.com/zero-overhead/BYOD/refs/heads/main/setup.sh)" -s VirtualBox.nix
# or
# curl -H 'Pragma: no-cache' -fsSL https://raw.githubusercontent.com/zero-overhead/BYOD/refs/heads/main/setup.sh | bash -s VirtualBox.nix
#

if ! command -v git >/dev/null 2>&1
then
    echo "<git> could not be found"
    echo "run: nix-shell -p git"
    exit 1
fi

MYNIXVERSION=25.11
PROJECT=BYOD

# take the last argument as config 
for i in "$@"; do :; done
MYNIXCONFIG=$i

sudo nix-channel --list
sudo nix-channel --remove nixos
sudo nix-channel --remove home-manager
sudo nix-channel --add https://channels.nixos.org/nixos-$MYNIXVERSION nixos
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-$MYNIXVERSION.tar.gz home-manager
sudo nix-channel --update

echo "Using $HOME/$PROJECT/$MYNIXCONFIG"
cd $HOME

rm -rf $PROJECT
git clone --depth 1 --recurse-submodules https://github.com/zero-overhead/$PROJECT
cd $PROJECT

#create new hardware-configuration
sudo nixos-generate-config --dir "."

# remove existing xfce config - after we moved all GUI setup to BYOD-configuration.nix
#rm -rf $HOME/.config/xfce4
#rm -rf $HOME/.nix-profile/

# remove existing Firefox config
rm -rf $HOME/.mozilla

# remove existing zsh config
rm -rf $HOME/.zshrc

# making configurations global
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo mv /etc/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix.bak
sudo cp *.nix /etc/nixos/
sudo rm -rf /etc/nixos/configuration.nix
sudo ln -s $MYNIXCONFIG /etc/nixos/configuration.nix
sudo rm -rf /etc/nixos/nix-shells
sudo cp -r nix-shells /etc/nixos/

# apply configuration
sudo nixos-rebuild switch --upgrade -I nixos-config=$MYNIXCONFIG

# give hint on how to proceed
echo run: reboot
