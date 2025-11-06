{ config, pkgs, lib,  ... }:

{

  imports = [ 
       # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Common Configuration
      ./BYOD-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # bigger tty fonts
  #console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  
  # force higher DPI for Retina Displays
  services.xserver.dpi = 250;
  
  # TigerJYthin Scaling
  environment.variables = {
    XCURSOR_SIZE = "64";
  #  QT_SCALE_FACTOR = "2";
    GDK_SCALE = "2";
  #  GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
  
  # Note: UTM is basically a QEMU frontend designed for macOS.
  # Time Syncing and scripting
  services.qemuGuest.enable = true;
  # Clipboard Sharing
  services.spice-vdagentd.enable = true;
  # VirtFS alternative for directory sharing
  #services.spice-webdavd.enable = true;
  # Automatically adjust the client window resolution in Linux KVM guests using the SPICE driver
  #services.spice-autorandr.enable = true;

  environment.systemPackages = with pkgs; [
    spice-autorandr
    spice-vdagent
    spice
  ];
 
  services.xserver.xkb.layout = "ch";
  services.xserver.xkb.variant = lib.mkForce "de_mac";

  home-manager.users.demo = { pkgs, ... }: {
     home.file.".Xresources".text = ''
      Xft.antialias: true
      Xft.dpi: 200
      '';
  };
}
