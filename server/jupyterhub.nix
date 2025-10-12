{ pkgs,  ... }:

{
  imports = [ 
      ./basic-setup.nix
      ../modules/jupyterhub.nix
  ];
  services.getty.helpLine = ''
  Jupyter-Hub http://127.0.0.1:8000
  
  IP adress  ip iw ifconfig or fastfetch
  System     htop btop nvitop
  Shutdown   sudo shutdown now -h
  Update     curl -fsSL https://raw.githubusercontent.com/zero-overhead/BYOD/refs/heads/main/setup-server.sh | bash -s server/jupyterhub.nix
  '';
}
