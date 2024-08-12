# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:
let
  # add unstable channel declaratively
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in
{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  
  wsl.useWindowsDriver = true;
  wsl.startMenuLaunchers = true;
  
  environment.systemPackages = with pkgs; [
    wget
    git
    htop
    file
    oterm
    ffmpeg
  ];

  services.ollama = {
    package = pkgs.unstable.ollama; # Uncomment if you want to use the unstable channel, see https://fictionbecomesfact.com/nixos-unstable-channel
    enable = true;
    #acceleration = "cuda"; # Or "cuda" (NVidia) or "rocm" (AMD)
  };

  system.activationScripts = {
    script.text = ''
      install -d -m 755 /home/nixos/open-webui/data -o root -g root
    '';
   };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      #defaultNetwork.settings.dns_enabled = true;
    };
 
    oci-containers = {
      backend = "podman";
 
      containers = {
        open-webui = import ./containers/open-webui.nix;
      };
    };
  };
  
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
