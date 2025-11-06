{ pkgs,  ... }:

{
  imports = [ 
      ./basic-setup.nix
      ../modules/ollama.nix
  ];
  services.getty.helpLine = ''
  Ollama     http://127.0.0.1:11434
  
  IP adress  ip iw ifconfig or fastfetch
  System     htop btop nvitop
  Shutdown   sudo shutdown now -h
  Update     curl -fsSL https://raw.githubusercontent.com/zero-overhead/BYOD/refs/heads/main/setup-server.sh | bash -s server/ollama.nix
  '';
}
