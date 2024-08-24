# Configuration for all Platforms
{ config, lib, pkgs, ... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  # Install common Programs.
  programs = {
    firefox = {
      enable = true;
      languagePacks = [ "de" "en-US" ];
    };
    chromium.enable = true;
    # set up brightness and volume function keys
    light.enable = true;
    zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
        ohMyZsh = {
            enable = true;
            theme = "robbyrussell";
            plugins = [
                "thefuck"
                "git"
                "history"
                "sudo"
                "copyfile"
                "copypath"
                "dirhistory"
                "jsontools"
                "web-search"
                "direnv"
            ];
        };
    };
    git.enable = true;
    git.lfs.enable = true;
    java.enable = true;
    htop.enable = true;
    direnv.enable = true;
    thefuck.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #zef install Jupyter::Chatbook --serial
  #jupyter-chatbook.raku --generate-config
  #
  #pkgs von rcmlz clonen und in entsprechende branch (filius oder tigerjython) wechseln, dann
  #nix profile install .#filius --extra-experimental-features "nix-command flakes"
  #export NIXPKGS_ALLOW_UNFREE=1; nix profile install .#tigerjython --extra-experimental-features "nix-command flakes" --impure

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #unstable.filius
    #unstable.rstudio
    #unstable.tigerjython

    ripgrep
    file
    gnumake
    hyperfine
    tokei
    fortune
    cowsay
    jq
    lolcat
    p7zip
    mkpasswd
    gnupg
    ventoy
    keepassxc

    thunderbird
    libreoffice
    thonny
    jupyter-all
    geogebra6
    arduino
    greenfoot
    racket
    sublime-merge
    vscode
    vscode-extensions.mhutchie.git-graph
    octave

    pandoc
    nano
    bat
    fzf
    tree
    navi
    ffmpeg
    cmatrix
    libsecret
    gnome.adwaita-icon-theme

    R
    nodejs
    rakudo
    zef
    zeromq
    obsidian
    texliveFull
    gcc
    libgcc
    openssl
    python3Full
  ];
}
