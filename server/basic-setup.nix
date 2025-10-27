# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, ... }:

{
  imports = [ 
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix

      # default user settings
      ./users.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixsrv"; # Define your hostname.
  
  # disable suspend entirely
  systemd.sleep.extraConfig = ''
  AllowSuspend=no
  AllowHibernation=no
  AllowHybridSleep=no
  AllowSuspendThenHibernate=no
  '';
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  #https://mynixos.com/options/networking.firewall
  networking.firewall = {
    enable = false;
  #  allowPing = true;
  #  allowedTCPPorts = [ 80 443 3306 ];
  #  allowedUDPPortRanges = [
  #    { from = 4000; to = 4007; }
  #    { from = 8000; to = 8010; }
  #  ];
  };
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Set your time zone.
  time.timeZone = "UTC";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_CH.UTF-8";

  console = {
    enable = true;
    
    # High-DPI console
    #font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    #font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    
    # Configure console keymap - 
    keyMap = "sg";

    # prevents `systemd-vconsole-setup` failing during systemd initrd
    earlySetup = true;
  };
  systemd.services.systemd-vconsole-setup.unitConfig.After = "local-fs.target";

  # Install software
  programs = {
    git.enable = true;
    git.lfs.enable = true;
    vim.enable = true;
    nano.enable = true;
    htop.enable = true;
    mtr.enable = true; # traceroute + ping
    direnv.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.PermitRootLogin = "no";

  # List packages installed in system profile. To search, run:
  # \$ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    git-crypt
    gnupg
    pciutils
    file
    tree
    mkpasswd
    p7zip
    zip
    unzip
    hyperfine
    tokei
    tcpdump
    nload
    htop
    btop
    fastfetch
    jq
    ffmpeg

    rakudo
    zef
];
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # default shell
  users.defaultUserShell = pkgs.zsh;
  programs = {
      zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestions.enable = true;
          syntaxHighlighting.enable = true;
          histSize = 100000;
          setOptions = [
            "HIST_IGNORE_ALL_DUPS"
          ];
          loginShellInit = ''
          sleep 10
          fastfetch
          echo ----
          echo use 'btop' or 'htop' or 'nvitop' to monitor the system
          echo use 'ip' or 'iw' or 'ifconfig' to get network info
          echo use 'sudo shutdown now -h' to shutdown the system
          echo ----
          sleep 60
          btop
          '';
          shellAliases = {
          #  ll = "ls -l";
          #  edit = "sudo -e";
          #  reset-main-branch-of-git-repo-to-current-state-and-remove-history = "git checkout --orphan latest_branch; git add -A; git commit -am \"Reset main\"; git branch -D main; git branch -m main; git push -f origin main";
          #  optimize-nix = "sudo nix-store --optimise"; # This is a potentially long operation. 
          #  update-nix = "sudo nixos-rebuild switch -I nixos-config=configuration.nix";
          #  cleanup-nix = "sudo /run/current-system/bin/switch-to-configuration boot; sudo nixos-rebuild list-generations; sudo nix-collect-garbage --delete-older-than 7d; sudo nixos-rebuild list-generations; nix-collect-garbage -d";
          };

          ohMyZsh = {
            enable = true;
            theme = "robbyrussell";
            plugins = [
              "git"
              "history"
              "sudo"
              "direnv"
            ];
          };
      };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
