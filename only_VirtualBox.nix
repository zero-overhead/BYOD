{ config, pkgs, lib,  ... }:

{

  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.draganddrop = true;

  services.xserver.desktopManager.plasma5.enable = lib.mkForce false;

  # Mount a VirtualBox shared folder.
    # This is configurable in the VirtualBox menu at
    # Machine / Settings / Shared Folders.
    # fileSystems."/mnt" = {
    #   fsType = "vboxsf";
    #   device = "nameofdevicetomount";
    #   options = [ "rw" ];
    # };

    # By default, the NixOS VirtualBox demo image includes SDDM and Plasma.
    # If you prefer another desktop manager or display manager, you may want
    # to disable the default.
    # services.xserver.desktopManager.plasma5.enable = lib.mkForce false;
    # services.displayManager.sddm.enable = lib.mkForce false;

    # Enable GDM/GNOME by uncommenting above two lines and two lines below.
    # services.xserver.displayManager.gdm.enable = true;
    # services.xserver.desktopManager.gnome.enable = true;

}
