{ lib, pkgs, config, ... }:
{
    home = {
        packages = with pkgs; [ 
                rakudo
                zef
                jdk
                nodejs
        ];
    };
}
