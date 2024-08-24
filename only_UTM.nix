# UTM specific contiguration
{ config, lib, pkgs, ... }:

{
  # Time Syncing and scripting
  services.qemuGuest.enable = true;
  # Clipboard Sharing
  services.spice-vdagentd.enable = true;
  # VirtFS alternative for directory sharing
  services.spice-webdavd.enable = true;

  # Keyboard Layout
  services.xserver = {
    xkb = {
      variant = "de_mac";
    };
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    spice-vdagent
    spice
  ];
}
