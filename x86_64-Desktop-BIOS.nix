#sudo nixos-rebuild {dry-build, switch} -I nixos-config=x86_64-Desktop-BIOS.nix
{ config, pkgs, lib,  ... }:

{
  imports = [ 
      ./x86_64-Desktop.nix
  ];

  ###########################
  # Bootloader
  # check original /etc/nixos/configuration.nix for correct settings of your system
  # for BIOS systems
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.device = "/dev/sda";
  # or for UEFI systems
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  ###########################
}
