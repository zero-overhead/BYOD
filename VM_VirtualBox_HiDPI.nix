{ config, pkgs, ... }:

{
  imports = [
      <nixpkgs/nixos/modules/installer/virtualbox-demo.nix>
      ./common.nix
      ./programms.nix
      ./only_VirtualBox.nix
      ./only_HiDPI.nix
      ./desktop.nix
      ./yubikey.nix
    ];

}
