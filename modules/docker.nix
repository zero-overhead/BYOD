{ pkgs, lib, ... }:
{
    virtualisation.docker = {
        # Consider disabling the system wide Docker daemon
        enable = true;

        #rootless = {
        #  enable = true;
        #  setSocketVariable = true;
            # Optionally customize rootless Docker daemon settings
        #  daemon.settings = {
        #    dns = [ "1.1.1.1" "8.8.8.8" ];
        #    registry-mirrors = [ "https://mirror.gcr.io" ];
        #  };
        #};
    };
}