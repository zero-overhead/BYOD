{ config, pkgs, lib,  ... }:

{
  imports = [
      <nixpkgs/nixos/modules/installer/virtualbox-demo.nix>
      ./common.nix
      ./programms.nix
      ./only_VirtualBox.nix
      ./desktop.nix
      ./yubikey.nix
  ];
}
