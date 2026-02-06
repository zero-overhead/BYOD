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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
