#sudo nixos-rebuild {dry-build, switch} -I nixos-config=VirtualBox.nix

{ config, pkgs, lib,  ... }:

{

  imports = [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Common Configuration
      ./BYOD-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #oder
  #boot.loader.grub.enable = true;
  #boot.loader.grub.useOSProber = true;
  #boot.loader.grub.device = "/dev/sda";
  
  # https://search.nixos.org/options?type=packages&query=virtualisation.virtualbox.guest
  virtualisation.virtualbox = {
    host = {
      enable = false;
      enableExtensionPack = true;
    };
    guest = {
      enable = true;
      dragAndDrop = false;
      vboxsf = true;
      clipboard = true;
      seamless = false;
    };
  };

  environment.systemPackages = with pkgs; [
    oh-my-git
  ];
}
