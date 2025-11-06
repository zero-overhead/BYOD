{ pkgs, ... }:

{
  imports = [ 
      ./basic-setup.nix
  ];

  # we assume you run in Virtual Box and Ollama runs on the Host - which is also the gateway
  services.open-webui = {
    enable = true;
    port = 8080;
    host = "0.0.0.0"; # Make Open-WebUI accessible outside of localhost
    openFirewall = true;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      OLLAMA_API_BASE_URL = "http://10.0.2.2:11434/api";
      OLLAMA_BASE_URL = "http://10.0.2.2:11434";
    };
  };

  services.getty.helpLine = ''
  Open-WebUI http://127.0.0.1:8080
  Ollama     http://127.0.0.1:11434 (run on host machine)
  
  IP adress  ip iw ifconfig or fastfetch
  System     htop btop nvitop
  Shutdown   sudo shutdown now -h
  Update     curl -fsSL https://raw.githubusercontent.com/zero-overhead/BYOD/refs/heads/main/setup-server.sh | bash -s server/open-webui.nix
  '';
}
