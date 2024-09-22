{ config, pkgs, lib,  ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/virtualbox-demo.nix> ];

  # Let demo build as a trusted user.
  nix.settings.trusted-users = [ "demo" ];

  # video and audi control
  users.users.demo.extraGroups = [ "video" ];
  #programs.light.enable = true;

  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.draganddrop = false;
  
  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  i18n.defaultLocale = "de_CH.UTF-8";
  
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver = {
    enable = true;
    xkb = {
      layout = "ch";
    };
    desktopManager = {
      xterm.enable = false;
      plasma5.enable = lib.mkForce false;
    };

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

  # enable sway window manager
  #programs.sway = {
  #  enable = true;
  #  wrapperFeatures.gtk = true;
  #};

  #programs.hyprland = {
    # Install the packages from nixpkgs
  #  enable = true;
    # Whether to enable XWayland
  #  xwayland.enable = true;
  #};
  # Optional, hint electron apps to use wayland:
  #environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  #services.gnome.gnome-keyring.enable = true;

  # kanshi systemd service - for sway
  #systemd.user.services.kanshi = {
  #  description = "kanshi daemon";
  #  serviceConfig = {
  #    Type = "simple";
  #    ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
  #  };
  #};

  # Configure console keymap
  console.keyMap = "sg";

  # https://nixos.wiki/wiki/KDE
  # copy/paste from host needs spice-vdagend which does not work on wayland yet
  services.displayManager = {
      #autoLogin.enable = lib.mkForce false;
      autoLogin.enable = true;
      autoLogin.user = "demo";
      defaultSession = "plasmax11";
      #defaultSession = "none+i3";

      sddm = {
        enable = true;
        wayland.enable = lib.mkForce false;
        #wayland.enable = true;
        autoLogin.relogin = lib.mkForce false;
      };
  };
  services.desktopManager.plasma6.enable = true; 
 
  # settings saved for some applications (gtk3 applications, firefox)
  programs.dconf.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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

# Set your time zone.
time.timeZone = "Europe/Zurich";

# List packages installed in system profile. To search, run:
# \$ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    git-lfs
    ripgrep
    htop
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
    pinentry-all
    ventoy
    keepassxc

    firefox
    chromium
    thunderbird
    libreoffice
    thonny
    jupyter
    rstudio
    geogebra6
    arduino
    greenfoot
    racket
    sublime-merge
    vscode
    vscode-extensions.mhutchie.git-graph
    octave
    kate
    kstars

    pandoc
    nano
    bat
    fzf
    tree
    navi
    fzf
    direnv
    thefuck
    ffmpeg
    cmatrix
    libsecret
 
    R
    nodejs
    rakudo
    zef
    zeromq
    obsidian
    texliveFull
    gcc
    libgcc
    jdk
    openssl
    python3Full
    imagemagick
    rofi

    # Games
    superTux
    #superTuxKart
    extremetuxracer
    freeciv
    oh-my-git
    pingus
    hase
    wireworld
    armagetronad

    #kanshi # for sway
    #polkit # handling access to keyboard
    #pulseaudioFull # audio control sway
    #grim # screenshot functionality
    #slurp # screenshot functionality
    #wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    #mako # notification system developed by swaywm maintainer
];

  #zef install Jupyter::Chatbook --serial
  #jupyter-chatbook.raku --generate-config
  #nix profile install .#filius --extra-experimental-features "nix-command flakes"
  #nix profile install .#tigerjython --extra-experimental-features "nix-command flakes" --impure  

  users.defaultUserShell = pkgs.zsh;
  programs = {
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
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Optimising the NixOS store with automatic options. This will optimise the
  # store on every build which may slow down builds. The alternativ is to set
  # them on specific dates like this:
  # nix.optimise.automatic = true;
  # nix.optimise.dates = [ "03:45" ]; # Optional; allows customizing schedule
  nix.settings.auto-optimise-store = true;

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

}
