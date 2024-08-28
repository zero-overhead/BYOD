# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Time Syncing and scripting
  services.qemuGuest.enable = true;
  # Clipboard Sharing
  services.spice-vdagentd.enable = true;
  # VirtFS alternative for directory sharing
  services.spice-webdavd.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  i18n.defaultLocale = "de_CH.UTF-8";
  
  # Configure console keymap - Swiss
  console.keyMap = "sg";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver = {
    enable = true;
    xkb = {
      layout = "ch";
      variant = "de_mac";
    };
  };

  # https://nixos.wiki/wiki/KDE
  # copy/paste from host needs spice-vdagend which does not work on wayland yet
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
  };
  services.desktopManager.plasma6.enable = true; 
 
  # Enable automatic login for the user.
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "demo";
    defaultSession = "plasmax11";
  };
  
  # settings saved for some applications (gtk3 applications, firefox)
  programs.dconf.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.demo = {
    isNormalUser = true;
    description = "demo";
    extraGroups = [ "networkmanager" "wheel" ];
    # mkpasswd -m sha-512
    hashedPassword ="$6$mJ1Nxf5ZJbTz.Ze7$syodN3YdfjtsB9vajYXGEoiuvS0vPv5R58LkzwV6qVVF5MjEZ/gHCMMYHb0GibcP./tW20EKCGMWM3N25FhtG1";
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    spice-vdagent
    spice
    wget
    vim
    nano
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
#    rstudio
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

    # https://nixos.wiki/wiki/Games
    superTuxKart
    endless-sky
    freeciv
    mindustry
    xonotic
    openra
  ];

  #zef install Jupyter::Chatbook --serial
  #jupyter-chatbook.raku --generate-config
  #nix profile install .#filius --extra-experimental-features "nix-command flakes"
  #export NIXPKGS_ALLOW_UNFREE=1; nix profile install .#tigerjython --extra-experimental-features "nix-command flakes" --impure  

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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Optimising the NixOS store with automatic options. This will optimise the
  # store on every build which may slow down builds. The alternativ is to set
  # them on specific dates like this:
  # nix.optimise.automatic = true;
  # nix.optimise.dates = [ "03:45" ]; # Optional; allows customizing schedule
  nix.settings.auto-optimise-store = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
