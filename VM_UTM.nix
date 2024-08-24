{ config, pkgs, ... }:

{
  imports = [
      /etc/nixos/hardware-configuration.nix
      ./common.nix
      ./programms.nix
      ./only_UTM.nix
      ./desktop.nix
      ./yubikey.nix
      ./users.nix
    ];
}
