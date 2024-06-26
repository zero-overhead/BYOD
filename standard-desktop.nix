{ lib, pkgs, config, ... }:
let
#  tigerjython = pkgs.fetchFromGitHub {
#          owner = "nixos";
#          repo = "nixpkgs";
#          rev = "3be738d173ae71a27b824c296baeab71cc2b83da";
#          hash = "sha256-i27JFR4HeM+pZWKFfc93yLWWOjGVI1sule8Bqu4Ttko=";
#        };
#  filius = pkgs.fetchFromGitHub {
#          owner = "nixos";
#          repo = "nixpkgs";
#          rev = "a145406fb2313db4680127c35ca2ddc48ec8fbf0";
#          hash = "sha256-abtt8tENzfVuOA+EG7ORvp7zE2YrxOPprfbCkYiJqO8=";
#        };
in
{
    home = {
        packages = with pkgs; [ 
                firefox
                thonny
                jupyter
                #tigerjython #export NIXPKGS_ALLOW_UNFREE=1; nix build --impure github:nixos/nixpkgs?ref=pull/316431/head#tigerjython
                #filius #nix build --impure github:nixos/nixpkgs?ref=pull/318005/head#filius
                obsidian
                libreoffice

                vscode
                vscode-extensions.mhutchie.git-graph
                vscode-extensions.bbenoist.nix
                vscode-extensions.github.vscode-github-actions

                nano
                bat
                fzf
                tree
                vim
                wget
                git
                git-lfs
                file
                gnumake
                ripgrep
                navi
                fzf
                thefuck

                hyperfine                
        ];
    };

  programs = {
      zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          oh-my-zsh = {
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
            ];
          };
      };
  };
}