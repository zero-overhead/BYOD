# For HiDPI (High Dots Per Inch) displays, also known by Apple's "Retina Display"
{ config, lib, pkgs, ... }:
{
  # https://nixos.wiki/wiki/Xorg
  # bigger tty fonts
  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  services.xserver.dpi = 180;
  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
}
