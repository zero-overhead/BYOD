{ config, lib, pkgs, ... }:

{
  # Let demo build as a trusted user.
  nix.settings.trusted-users = [ "demo" ];

  # USe zsh
  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.demo = {
    isNormalUser = true;
    description = "demo";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    # mkpasswd -m sha-512
    hashedPassword ="$6$mJ1Nxf5ZJbTz.Ze7$syodN3YdfjtsB9vajYXGEoiuvS0vPv5R58LkzwV6qVVF5MjEZ/gHCMMYHb0GibcP./tW20EKCGMWM3N25FhtG1";
  };
}
