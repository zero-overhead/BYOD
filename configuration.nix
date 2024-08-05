# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  
  wsl.useWindowsDriver = true;
  wsl.startMenuLaunchers = true;
  
  environment.systemPackages = with pkgs; [
    wget
    git
    htop
    file
    gnumake
    hyperfine
    
    thonny
    jupyter
    vscode
    vscode-extensions.mhutchie.git-graph

    ollama
    oterm
    ffmpeg
    
#    R
#    nodejs
#    rakudo
#    zef
    obsidian
  ];

  environment.shellAliases = {
    gs = "git status";
    tjython = "export NIXPKGS_ALLOW_UNFREE=1; nix run github:nixos/nixpkgs/pull/316431/head#tigerjython --impure --extra-experimental-features nix-command --extra-experimental-features flakes 1> /dev/null 2> /dev/null &";
    filius = "nix run github:nixos/nixpkgs/pull/326102/head#filius --extra-experimental-features nix-command --extra-experimental-features flakes 1> /dev/null 2> /dev/null &";
  };
  
  services.ollama = {
    #package = pkgs.unstable.ollama; # Uncomment if you want to use the unstable channel, see https://fictionbecomesfact.com/nixos-unstable-channel
    enable = true;
    #enable = false;
    #acceleration = "cuda"; # Or "cuda" (NVidia) or "rocm" (AMD)
    #environmentVariables = {
      # HOME = "/home/ollama";
      #OLLAMA_MODELS = "/home/nixos/ollama/models";
      # OLLAMA_HOST = "0.0.0.0:11434"; # Make Ollama accesible outside of localhost
      # OLLAMA_ORIGINS = "http://localhost:8080,http://192.168.0.10:*"; # Allow access, otherwise Ollama returns 403 forbidden due to CORS
    #};
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
