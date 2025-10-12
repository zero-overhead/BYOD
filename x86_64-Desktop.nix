#sudo nixos-rebuild {dry-build, switch} -I nixos-config=x86_64-Desktop.nix

{ config, pkgs, lib,  ... }:

{

  imports = [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Common Configuration
      ./BYOD-configuration.nix
  ];

  ###########################
  # Bootloader
  # check original /etc/nixos/configuration.nix for correct settings of your system
  # for BIOS systems
  #boot.loader.grub.enable = true;
  #boot.loader.grub.useOSProber = true;
  #boot.loader.grub.device = "/dev/sda";
  # or for UEFI systems
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  ###########################

  #nixpkgs.config.allowUnfree = true;
  #hardware.enableAllFirmware = true;
  #boot.kernelModules = [ "bcma" "b43" ];

  # load broadcom wireless driver
  # enable propriatry driver
  #boot.kernelModules = [ "wl" ];
  #boot.extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta ];
  # disable OSS driver
  #boot.blacklistedKernelModules = [ "bcma" "b43" ];
  #networking.enableB43Firmware = true;
  #networking.wireless = {
  #      driver = "nl80211,wext";
  #      driver = "nl80211";
  #      driver = "wext";
  #};
  
  # broadcom blue tooth
  #environment.systemPackages = with pkgs; [broadcom-bt-firmware];
  
  # MacBook
  #hardware.facetimehd.enable = true;
  
  users.users.guest = {
    isNormalUser = true;
    description = "guest";
    extraGroups = [ "networkmanager" "wheel" "video" "dialout" "vboxsf" "kvm" ];
    password = "";
  };

  # clean/regenerate guest userdir on reboot
  systemd.tmpfiles.rules = [ "D! /home/guest 0700 guest users" ];
  
  # more games
  environment.systemPackages = with pkgs; [
    pingus
#    oh-my-git
#    superTuxKart
#    tuxtype
#    superTux
#    extremetuxracer
#    zeroad
#    freeciv
#    armagetronad
#    tetris
#    xonotic
#    wesnoth
#    etlegacy
#    wireworld
#    xlife
#    urbanterror
  ];

  # Energy Management Laptop
  # https://nixos.wiki/wiki/Laptop
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
     governor = "powersave";
     turbo = "never";
    };
    charger = {
     governor = "performance";
     turbo = "auto";
    };
  };
  services.thermald.enable = true;
}
