{ pkgs, ... }:
{
  # we assume you run in Virtual Box and have NAT from 127.0.0.1:8001 to 10.0.2.15:8001
  # https://wiki.nixos.org/wiki/Hedgedoc
  services.hedgedoc = {
    enable = true;
    settings = {
        domain = "127.0.0.1";
        port = 8001;
        host = "0.0.0.0"; # Listen to all Interfaces
        urlAddPort = true;
        protocolUseSSL = false;
        allowEmailRegister = true;
        allowAnonymous = true;
#        allowOrigin = [
#          "0.0.0.0"
#          "127.0.0.1"
#          "localhost"
#        ];
    };
  };
}
