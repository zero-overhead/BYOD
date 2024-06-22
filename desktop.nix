{ lib, pkgs, config, ... }:
{
    home = {
        packages = with pkgs; [ 
                firefox
                vscode
                thonny
                obsidian
                libreoffice
                jupyter

                nano
                vim
                wget
                git
                git-lfs
                file
                gnumake

                hyperfine                
        ];
    };
}