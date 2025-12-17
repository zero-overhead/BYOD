{ pkgs, lib, ... }:
let
    # https://wiki.nixos.org/wiki/Python
    my-python = pkgs.python3.override {
      self = my-python;
      packageOverrides = pyfinal: pyprev: {
        # dieses Python-Packete exitieren leider nicht in search.nixos.org - deshalb müssen wir sie selbst bauen
        pedal = pyfinal.callPackage ../nix-shells/extra-packages/pedal.nix { };
        pgzero = pyfinal.callPackage ../nix-shells/extra-packages/pgzero.nix { };
        jturtle = pyfinal.callPackage ../nix-shells/extra-packages/jturtle.nix { };
        jupyterlab-rise = pyfinal.callPackage ../nix-shells/extra-packages/jupyterlab-rise.nix { };
        jupyterlab-mathjax3 = pyfinal.callPackage ../nix-shells/extra-packages/jupyterlab-mathjax3.nix { };
        itables = pyfinal.callPackage ../nix-shells/extra-packages/itables.nix { };
      };
    };
in
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