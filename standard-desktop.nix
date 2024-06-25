{ lib, pkgs, config, ... }:
{
    home = {
        packages = with pkgs; [ 
                firefox
                thonny
                jupyter
                #tigerjython
                #export NIXPKGS_ALLOW_UNFREE=1; nix build --impure github:nixos/nixpkgs?ref=pull/316431/head#tigerjython
                #filius
                #nix build --impure github:nixos/nixpkgs?ref=pull/318005/head#filius
                obsidian
                libreoffice

                vscode
                vscode-extensions.mhutchie.git-graph
                #vscode-extensions.bbenoist.nix
                #vscode-extensions.github.vscode-github-actions

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
#                ripgrep
#                navi
                fzf
#                thefuck

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