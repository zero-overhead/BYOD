# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, options, ... }:
let
  # irgendwann wird dass hoffentlich in pkgs verfügbar sein
  filius = pkgs.callPackage ./nix-shells/extra-packages/filius-compiled.nix { };
in 
{

  imports = [ 
      # home-manager as module
      <home-manager/nixos>
      modules/jupyterhub.nix
      modules/lamp.nix
      modules/ollama.nix
      #modules/docker.nix
];

  networking.hostName = "nixos"; # Define your hostname.
  
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

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_CH.UTF-8";

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.displayManager.defaultSession = "xfce";
  
  services.xserver = {
    enable = true;
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ch";
  #  variant = "";
  };

  # to use xconf in home-manager
  #programs.xfconf.enable = true;

  console = {
    # High-DPI console
    #font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    #font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    
    # Configure console keymap - 
    keyMap = "sg";

    # prevents `systemd-vconsole-setup` failing during systemd initrd
    earlySetup = true;
  };
  systemd.services.systemd-vconsole-setup.unitConfig.After = "local-fs.target";

  # If you want to use the VM on e.g. a full HD screen with proper scaling
  #services.xserver.displayManager.sessionCommands = ''
  #       ${pkgs.xorg.xrandr}/bin/xrandr -s '1920x1080'
  #  '';

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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

  # Install software
  programs = {
    # settings saved for some applications (gtk3 applications, firefox)
    dconf.enable = true;

    git.enable = true;
    git.lfs.enable = true;
    vim.enable = true;
    htop.enable = true;
    mtr.enable = true; # traceroute + ping
    direnv.enable = true;
    npm.enable = true;

    firefox.enable = true;
    thunderbird.enable = true;

    # all about encryption
    gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
    };
  };

  # Enable xinput2 to improve touchscreen support and enable additional touchpad gestures and smooth scrolling.
  environment.sessionVariables.MOZ_USE_XINPUT2 = "1";

  # Add ~/.local/bin/ to $PATH
  environment.localBinInPath = true;

  # List services that you want to enable:
  # all about encryption
  #services.yubikey-agent.enable = true;
  services.gnome.gnome-keyring.enable = true;
  #services.zeitgeist.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.PermitRootLogin = "no";

  # List packages installed in system profile. To search, run:
  # \$ nix search wget
  environment.systemPackages = with pkgs; [
    nano
    vim
    wget
    git-crypt
    gnupg
    pciutils
    file
    devenv # similar to direnv
    tree
    mkpasswd
    p7zip
    zip
    unzip
    xarchiver
    hyperfine
    tokei
    tcpdump
    nload
    htop
    btop
    
    cowsay
    lolcat
    fortune
    jp2a # jpg to ascii
    cbonsai
    aewan
    figlet

    fastfetch
    jq
    nodejs
    cmatrix
    clipmenu
    SDL2
    feh
    rofi
    ffmpeg
    
    xfce.xfce4-power-manager
    xfce.xfce4-taskmanager
    xfce.xfce4-systemload-plugin
    xfce.xfce4-screenshooter
    xfce.thunar-volman
    xfce.thunar-vcs-plugin
    xfce.thunar-media-tags-plugin
    xfce.thunar-archive-plugin
    xfce.catfish
    xorg.xkill
    
    rakudo
    zef

    thonny
    tigerjython
    #p3x-onenote
    #obsidian
    libreoffice
    geany
    filius
    gnumeric

    texliveFull
    pandoc
    imagemagick
    gnuplot

  # gdevelop
  # fritzing
  # https://veyon.io/de/ https://github.com/veyon/veyon/

    # Games
    wireworld
    pingus
    #lightsoff
    #superTuxKart
];

  # Define a user account.
  users.mutableUsers = false;
  nix.settings.trusted-users = [ "demo" ];
  users.users.demo = {
    isNormalUser = true;
    description = "demo";
    extraGroups = [ "networkmanager" "wheel" "video" "dialout" "vboxsf" "kvm" "docker"];
    # mkpasswd -m sha-512
    hashedPassword = "$6$rfbRiHox9teafYrN$m5ga/Vs74pAAobd9NLhCtFzCEOW5esIX19qnC7RO41H.XiF302/2AE8GUBZNOw60.sG.w2VBkuamKCBL.B8bg1";
    #packages = with pkgs; [
    #  kdePackages.kate
    #  thunderbird
    #];
  };

  # Enable automatic login for the user.
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "demo";
  };

  home-manager.users.demo = { pkgs, ... }: {

    nixpkgs.config.allowUnfree = true;

    home.shellAliases = {
      # reset-main-branch-of-git-repo-to-current-state-and-remove-history = "git checkout --orphan latest_branch && git add -A && git commit -am \"Reset main\" && git branch -D main && git branch -m main && git push -f origin main";
      # update-nix = "sudo nixos-rebuild switch --upgrade -I nixos-config=configuration.nix";
      cleanup-nix = "sudo nixos-rebuild list-generations && sudo /run/current-system/bin/switch-to-configuration boot && sudo nix-collect-garbage --delete-older-than 1d && nix-collect-garbage -d && sudo nixos-rebuild list-generations";
      optimize-nix = "sudo nix-store --optimise"; # This is a potentially long operation. 
    };

    xdg.mimeApps.defaultApplications = {
      "text/html" = ["firefox.desktop"];
      "text/xml" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
    };
    
# ToDo: add Panel Configuration and Shortcuts
#    xfconf = {
#      enable = true;
#      settings = {
#        xfce4-keyboard-shortcuts = {
#          "commands/custom/Ctrl+<Super> left" = "Tile window to the left";
#          "commands/custom/Ctrl+<Super> right" = "Tile window to the right";
#          "commands/custom/Ctrl+<Super> top" = "Tile window to the top";
#          "commands/custom/Ctrl+<Super> bottom" = "Tile window to the bottom";
#        };
#        xfce4-panel  = {
#
#        };
#      };
#    };
          
    services.clipmenu.enable = true;
    
    programs.firefox = {
      enable = true;

      languagePacks = [ "de" ];

      policies = {
        # Updates & Background Services
        AppAutoUpdate                 = false;
        BackgroundAppUpdate           = false;

        # Feature Disabling
        #DisableBuiltinPDFViewer       = true;
        #DisableFirefoxStudies         = true;
        #DisableFirefoxAccounts        = true;
        #DisableFirefoxScreenshots     = true;
        #DisableForgetButton           = true;
        #DisableMasterPasswordCreation = true;
        #DisableProfileImport          = true;
        #DisableProfileRefresh         = true;
        #DisableSetDesktopBackground   = true;
        #DisablePocket                 = true;
        #DisableTelemetry              = true;
        #DisableFormHistory            = true;
        #DisablePasswordReveal         = true;

        # Access Restrictions
        #BlockAboutConfig              = false;
        #BlockAboutProfiles            = true;
        #BlockAboutSupport             = true;

        # UI and Behavior
        #DisplayMenuBar                = "never";
        #DontCheckDefaultBrowser       = true;
        #HardwareAcceleration          = false;
        #OfferToSaveLogins             = false;
        #DefaultDownloadDirectory      = "${home}/Downloads";      
      };

      profiles.default = {
        id = 0;
        isDefault = true;

        bookmarks = {
          force = true; # Overwrites existing bookmarks
          settings = [ 
              {
                name = "Informatik";
                toolbar = true;
                bookmarks =
                  [
                    {
                      name = "Unterlagen";
                      url = "https://publish.obsidian.md/mer";
                    }              
                    {
                       name = "Office.com";
                       url = "https://www.office.com/";
                    }
                    #{
                    #  name = "Exam.net";
                    #  url = "https://exam.net/student";
                    #}
                    {
                      name = "CX";
                      url = "https://cxedu.ethz.ch";
                    }
                    {
                      name = "WebTP";
                      url = "https://webtigerpython.ethz.ch";
                    }
                    {
                       name = "jython.ch";
                       url = "https://www.jython.ch";
                    }
                    {
                       name = "prkzp.ch";
                       url = "https://programmierkonzepte.ch/";
                    }
                    #{
                    #   name = "JupyterHub";
                    #   url = "https://127.0.0.1:8000/";
                    #}
                    {
                       name = "Adminer";
                       url = "http://127.0.0.1:8088/adminer/";
                    }
                    {
                      name = "Python Doc";
                      url = "https://docs.python.org/3/library/functions.html#built-in-funcs";
                    }
                    #{
                    #   name = "OpenWebUI";
                    #   url = "http://127.0.0.1:8080/";
                    #}
                    #{
                    #   name = "Ollama";
                    #   url = "http://127.0.0.1:11434/";
                    #}
                    # {
                    #   name = "WebTigerJython";
                    #   url = "https://webtigerjython.ethz.ch/";
                    # }
                    # {
                    #   name = "Unterlagen Mygymer";
                    #   url = "https://informatik.mygymer.ch/";
                    # }
                    # {
                    #   name = "Webnetsim";
                    #   url = "https://webnetsim.de/";
                    # }
                    # {
                    #   name = "python microbit";
                    #   url = "https://python.microbit.org/";
                    # }
                    # {
                    #   name = "makecode microbit";
                    #   url = "https://makecode.microbit.org/";
                    # }
                    # {
                    #   name = "https://sqlitetutorial";
                    #   url = "https://www.sqlitetutorial.net/sqlite-sample-database/";
                    # }
                    # {
                    #   name = "elementsofai";
                    #   url = "https://course.elementsofai.com/de/";
                    # }
                    # {
                    #   name = "snakify";
                    #   url = "https://snakify.org/en/";
                    # }
                    # {
                    #   name = "jupyenv";
                    #   url = "https://jupyenv.io/";
                    # }
                    # {
                    #   name = "appinventor";
                    #   url = "https://appinventor.mit.edu/";
                    # }
                    # {
                    #   name = "appcamps";
                    #   url = "https://appcamps.de/";
                    # }
                    # {
                    #   name = "compute-it";
                    #   url = "https://compute-it.toxicode.fr/";
                    # }
                    # {
                    #   name = "code.org";
                    #   url = "https://code.org/tools/applab";
                    # }
                    # {
                    #   name = "silentteacher";
                    #   url = "https://silentteacher.toxicode.fr/";
                    # }
                    # {
                    #   name = "w3schools";
                    #   url = "https://www.w3schools.com/sql/default.asp";
                    # }
                    # {
                    #   name = "fobizz";
                    #   url = "https://app.fobizz.com/gallery";
                    # }
                    # {
                    #   name = "inf-schule.de";
                    #   url = "https://inf-schule.de";
                    # }
                    # {
                    #   name = "";
                    #   url = "https://www.onenote.com/";
                    # }
                    # {
                    #   name = "";
                    #   url = "https://copilot.microsoft.com";
                    # }
                    # {
                    #   name = "vscode edu";
                    #   url = "https://vscodeedu.com/";
                    # }
                    # {
                    #   name = "outlook";
                    #   url = "https://outlook.com/";
                    # }
                    # {
                    #   name = "perplexity";
                    #   url = "https://www.perplexity.ai/";
                    # }
                    # {
                    #   name = "Duck AI";
                    #   url = "https://duck.ai";
                    # }
                    # {
                    #   name = "oinf";
                    #   url = "https://oinf.ch";
                    # }
                    {
                       name = "Mermaid";
                       url = "https://mermaid.live/";
                    }
                    # {
                    #   name = "wolframalpha";
                    #   url = "https://www.wolframalpha.com/";
                    # }
                    # {
                    #   name = "";
                    #   url = "https://www.cyberquest.ch";
                    # }
                    # {
                    #   name = "mistral.ai";
                    #   url = "https://mistral.ai";
                    # }
                    {
                       name = "Etherpad";
                       url = "http://edupad.ch/";
                    }
                    {
                       name = "Ethercalc";
                       url = "https://ethercalc.net/";
                    }
                    # {
                    #   name = "combinatorialcalculator";
                    #   url = "https://de.numberempire.com/combinatorialcalculator.php";
                    # }
                    # {
                    #   name = "keys.mailvelope";
                    #   url = "https://keys.mailvelope.com/";
                    # }
                    # {
                    #   name = "Logikrechner";
                    #   url = "https://www.erpelstolz.at/gateway/formular-zentral.html";
                    # }
                    # {
                    #   name = "legoeducation";
                    #   url = "https://spike.legoeducation.com/";
                    # }
                    # {
                    #   name = "Racket";
                    #   url = "https://htdp.org/";
                    # }
                    # {
                    #   name = "codeskulptor";
                    #   url = "https://py3.codeskulptor.org/";
                    # }
                    # {
                    #   name = "nandgame";
                    #   url = "https://nandgame.com/";
                    # }
                    # {
                    #   name = "python-sneks";
                    #   url = "https://python-sneks.github.io/pages/";
                    # }
                    # {
                    #   name = "misconceptions";
                    #   url = "https://pytamaro.si.usi.ch/curricula/luce/misconceptions";
                    # }
                    # {
                    #   name = "webgl aquarium";
                    #   url = "https://webglsamples.org/aquarium/aquarium.html";
                    # }
                    # {
                    #   name = "boolean algebra";
                    #   url = "https://www.allaboutcircuits.com/worksheets/boolean-algebra/";
                    # }
                    # {
                    #   name = "codeforces";
                    #   url = "https://codeforces.com/";
                    # }
                    {
                       name = "SOI";
                       url = "https://soi.ch/";
                    }
                    {
                       name = "Biber";
                       url = "https://www.informatik-biber.ch/";
                    }
                    # {
                    #   name = "wheelofnames";
                    #   url = "https://wheelofnames.com/";
                    # }
                    # {
                    #   name = "classroomscreen";
                    #   url = "https://classroomscreen.com/";
                    # }
                    # {
                    #   name = "Interaktive Simulationen";
                    #   url = "https://phet.colorado.edu/de/";
                    # }
                    # {
                    #   name = "khanacademy";
                    #   url = "https://de.khanacademy.org/";
                    # }
                    # {
                    #   name = "studio.code.org";
                    #   url = "https://studio.code.org/catalog";
                    # }
                    # {
                    #   name = "colab";
                    #   url = "https://colab.research.google.com/";
                    # }
                    # {
                    #   name = "cocalc";
                    #   url = "https://cocalc.com/";
                    # }
                    # {
                    #   name = "lerntools";
                    #   url = "https://lerntools.org";
                    # }
                    # {
                    #   name = "codeberg";
                    #   url = "https://codeberg.org";
                    # }
                    # {
                    #   name = "github";
                    #   url = "https://github.com/";
                    # }
                    # {
                    #   name = "gitlab";
                    #   url = "https://gitlab.com/";
                    # }
                    # {
                    #   name = "learningview";
                    #   url = "https://learningview.org";
                    # }
                    # {
                    #   name = "codefuchs";
                    #   url = "https://www.codefuchs.com";
                    # }
                    # {
                    #   name = "robozzle";
                    #   url = "https://www.robozzle.com/beta/";
                    # }
                    # {
                    #   name = "swisseduc";
                    #   url = "https://www.swisseduc.ch/informatik/";
                    # }
                    # {
                    #   name = "skribbl.io";
                    #   url = "https://skribbl.io/";
                    # }
                    # {
                    #   name = "sketchful.io";
                    #   url = "https://sketchful.io/";
                    # }
                    # {
                    #   name = "sqlfiddle";
                    #   url = "https://sqlfiddle.com";
                    # }
                    # {
                    #   name = "expressiontutor";
                    #   url = "https://expressiontutor.org";
                    # }
                    # {
                    #   name = "ProgMiscon";
                    #   url = "https://progmiscon.org/";
                    # }
                    # {
                    #   name = "exorciser";
                    #   url = "https://exorciser.ch";
                    # }
                    # {
                    #   name = "xlogo";
                    #   url = "https://xlogo.inf.ethz.ch/release/latest/#/";
                    # }
                    # {
                    #   name = "edtools";
                    #   url = "https://edtools.inf.ethz.ch/";
                    # }
                    # {
                    #   name = "arcade.makecode";
                    #   url = "https://arcade.makecode.com/#";
                    # }
                    # {
                    #   name = "inspiration informatik";
                    #   url = "https://inspiration-informatik.de/";
                    # }
                    # {
                    #   name = "roteco";
                    #   url = "https://www.roteco.ch/de/";
                    # }
                    # {
                    #   name = "playground.tensorflow";
                    #   url = "https://playground.tensorflow.org";
                    # }
                    # {
                    #   name = "Unterrichtsmaterial";
                    #   url = "https://bildungsportal-niedersachsen.de/allgemeinbildung/unterrichtsfaecher/mathematische-und-technische-faecher/informatik";
                    # }
                    # {
                    #   name = "alphacode.deepmind";
                    #   url = "https://alphacode.deepmind.com";
                    # }
                    # {
                    #   name = "digi4all.de";
                    #   url = "https://digi4all.de/";
                    # }
                    # {
                    #   name = "PowerPoint-Karaoke";
                    #   url = "https://kapopo.de/";
                    # }
                    # {
                    #   name = "Unterrichtsmaterialien";
                    #   url = "https://inf.ott.net/";
                    # }
                    {
                       name = "Glot.io";
                       url = "https://glot.io/";
                    }
                    {
                       name = "Exercism";
                       url = "https://exercism.org/";
                    }
                    {
                       name = "Distrosea";
                       url = "https://distrosea.com";
                    }
                    {
                       name = "BYOD";
                       url = "https://github.com/zero-overhead/BYOD";
                    }
                  ];
              }
              {
                name = "Nix sites";
                toolbar = false;
                bookmarks = [
                  {
                    name = "homepage";
                    url = "https://nixos.org/";
                  }
                  {
                    name = "wiki";
                    tags = [ "wiki" "nix" ];
                    url = "https://wiki.nixos.org/";
                  }
                  {
                    name = "Home Manager Options";
                    tags = [ "home-manager" "nix" ];
                    url = "https://home-manager-options.extranix.com/";
                  }
                ];
              }
          ];
        };
                    
        search = {
          force           = true;
          default         = "ddg";
          privateDefault  = "ddg";
          order = ["ddg" "ecosia" "google"];
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "channel"; value = "unstable"; }
                    { name = "query";   value = "{searchTerms}"; }
                  ];
                }
              ];
              icon           = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    { name = "channel"; value = "unstable"; }
                    { name = "query";   value = "{searchTerms}"; }
                  ];
                }
              ];
              icon           = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@no" ];
            };

            "NixOS Wiki" = {
              urls = [
                {
                  template = "https://wiki.nixos.org/w/index.php";
                  params = [
                    { name = "search"; value = "{searchTerms}"; }
                  ];
                }
              ];
              icon           = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@nw" ];
            };
          };
        };

        settings = {
          "browser.startup.homepage" = "about:home";

          # Disable irritating first-run stuff
          "browser.disableResetPrompt" = true;
          "browser.download.panel.shown" = true;
          "browser.feeds.showFirstRunUI" = false;
          "browser.messaging-system.whatsNewPanel.enabled" = false;
          "browser.rights.3.shown" = true;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.shell.defaultBrowserCheckCount" = 1;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.uitour.enabled" = false;
          "startup.homepage_override_url" = "";
          "trailhead.firstrun.didSeeAboutWelcome" = true;
          "browser.bookmarks.restore_default_bookmarks" = false;
          "browser.bookmarks.addedImportButton" = false;

          # Don't ask for download dir
          "browser.download.useDownloadDir" = false;

          # Disable crappy home activity stream page
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
          #"browser.newtabpage.blocked" = lib.genAttrs [
            # Youtube
          #  "26UbzFJ7qT9/4DhodHKA1Q=="
            # Facebook
          #  "4gPpjkxgZzXPVtuEoAL9Ig=="
            # Wikipedia
          #  "eV8/WsSLxHadrTL1gAxhug=="
            # Reddit
          #  "gLv0ja2RYVgxKdp0I5qwvA=="
            # Amazon
          #  "K00ILysCaEq8+bEqV/3nuw=="
            # Twitter
          #  "T9nJot5PurhJSy8n038xGA=="
          #] (_: 1);

          # Disable some telemetry
          "app.shield.optoutstudies.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.sessions.current.clean" = true;
          "devtools.onboarding.telemetry.logged" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.prompted" = 2;
          "toolkit.telemetry.rejected" = true;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.unifiedIsOptIn" = false;
          "toolkit.telemetry.updatePing.enabled" = false;

          # Disable fx accounts
          "identity.fxaccounts.enabled" = false;
          
          # Disable "save password" prompt
          "signon.rememberSignons" = true;
          
          # Harden
          "privacy.trackingprotection.enabled" = true;
          "dom.security.https_only_mode" = false;
          "privacy.resistFingerprinting"  = true;
          
          # Layout
          #"browser.uiCustomization.state" = builtins.toJSON {
          #  currentVersion = 20;
          #  newElementCount = 5;
          #  dirtyAreaCache = ["nav-bar" "PersonalToolbar" "toolbar-menubar" "TabsToolbar" "widget-overflow-fixed-list"];
          #  placements = {
          #    PersonalToolbar = ["personal-bookmarks"];
          #    TabsToolbar = ["tabbrowser-tabs" "new-tab-button" "alltabs-button"];
          #    nav-bar = ["back-button" "forward-button" "stop-reload-button" "urlbar-container" "downloads-button" "ublock0_raymondhill_net-browser-action" "_testpilot-containers-browser-action" "reset-pbm-toolbar-button" "unified-extensions-button"];
          #    toolbar-menubar = ["menubar-items"];
          #    unified-extensions-area = [];
          #    widget-overflow-fixed-list = [];
          #  };
          #  seen = ["save-to-pocket-button" "developer-button" "ublock0_raymondhill_net-browser-action" "_testpilot-containers-browser-action"];
          #};
        };
      };
    };
    
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      
      history = {
        append = true;
        ignoreAllDups = true;
        saveNoDups = true;
        save = 100000;
      };
      
      # when used via Terminal we load the default Python-Version
      #interactiveShellInit = ''
      #  nix-shell $HOME/BYOD/nix-shells/python.nix
      #'';
      
      initContent = lib.mkOrder 1200 ''
      # settings via configuration.nix
      '';
      
      oh-my-zsh = {
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

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;    
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true; #https://github.com/nix-community/nix-direnv
    };

    programs.rofi = {
      enable = true;
      font = "Droid Sans Mono 18";
      cycle = true;
      modes = [
        "combi"
        "window"
        "drun"
      #  "run"
        "recursivebrowser"
      #  "filebrowser"
      #  "windowcd"
        "keys"
      #  "ssh"
      ];
      theme = "solarized";
      extraConfig = {
        combi-modes = "window,drun,keys,recursivebrowser";
        show-icons = true;
        dpi = 0;
        levenshtein-sort = true;
        fuzzy = true;
        sidebar-mode = true;
      };
    };

    programs.chromium.enable = true;
    
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
    programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
        yzhang.markdown-all-in-one
        ms-python.python
        donjayamanne.githistory
        mhutchie.git-graph
        davidanson.vscode-markdownlint
        bbenoist.nix
        ms-toolsai.jupyter
        github.copilot
        #bscan.perlnavigator
      ];

    #home.file.".xprofile".text = ''
    #xrandr --output eDP-1 --mode 1920x1080 --dpi 120
    #xrandr --output HDMI-1 --mode 1920x1080 --dpi 120
    #'';
    
    #home.file.".Xresources".text = ''
    #Xft.antialias: true
    #Xft.dpi: 120
    #'';

    #home.packages = [ pkgs.vscodium ];
  
    # This value determines the Home Manager release that your configuration is 
    # compatible with. This helps avoid breakage when a new Home Manager release 
    # introduces backwards incompatible changes. 
    #
    # You should not change this value, even if you update Home Manager. If you do 
    # want to update the value, then make sure to first check the Home Manager 
    # release notes. 
    home.stateVersion = "25.05"; # Please read the comment before changing. 

};

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

  # https://nixos.wiki/wiki/Overlays
  nixpkgs.overlays = [ 
    (import ./nix-shells/overlays/thonny.nix) 
  ];

  # apply overays system wide
  nix.nixPath =
    # Prepend default nixPath values.
    options.nix.nixPath.default ++
    # Append our nixpkgs-overlays.
    [ 
      "nixpkgs-overlays=/home/demo/BYOD/nix-shells/overlays/"
    ];
  
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
