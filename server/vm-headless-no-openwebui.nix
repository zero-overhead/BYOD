{ pkgs,  ... }:

{
  imports = [ 
      ./basic-setup.nix
      ../modules/jupyterhub.nix
      ../modules/lamp.nix
      ../modules/ollama.nix
  ];
  services.getty.helpLine = ''
  Jupyter-Hub http://127.0.0.1:8000
  Adminer     http://127.0.0.1:8088/adminer/
  Web-Home    http://127.0.0.1:8088/~demo/
  TinyFileMgr http://127.0.0.1:8088/tinyfilemanager/
  Ollama      http://127.0.0.1:11434
  
  IP adress  ip iw ifconfig or fastfetch
  System     htop btop nvitop
  Shutdown   sudo shutdown now -h
  Update     curl -fsSL https://raw.githubusercontent.com/zero-overhead/BYOD/refs/heads/main/setup-server.sh | bash -s server/vm-headless-no-openwebui.nix
  '';
}
