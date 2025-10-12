{ pkgs,  ... }:

{
  imports = [ 
      ./basic-setup.nix
      ../modules/lamp.nix
  ];
  services.getty.helpLine = ''
  Adminer  http://127.0.0.1:8088/adminer/
  Web-Home http://127.0.0.1:8088/~demo/
  
  IP adress  ip iw ifconfig or fastfetch
  System     htop btop nvitop
  Shutdown   sudo shutdown now -h
  Update     curl -H 'Pragma: no-cache' -fsSL https://raw.githubusercontent.com/zero-overhead/BYOD/refs/heads/main/setup-server.sh | bash -s server/lamp.nix
  '';
}
