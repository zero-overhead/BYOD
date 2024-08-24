# Configuration for all Platforms
{ config, lib, pkgs, ... }:

{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager = {
        autoLogin.enable = true;
        autoLogin.user = "demo";
        defaultSession = "plasmax11"; #"none+i3";
        sddm = {
          enable = true;
          wayland.enable = false;
        };
    };
    xserver = {
      enable = true;
      xkb.layout = "ch"; # Keyboard Layout
      windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
              dmenu #application launcher most people use
              i3status # gives you the default i3 status bar
              i3lock #default i3 screen locker
              i3blocks #if you are planning on using i3blocks over i3status
          ];
      };
    };
  };
}
