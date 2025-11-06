#sudo nixos-rebuild {dry-build, switch} -I nixos-config=x86_64-Server.nix

{ config, pkgs,  ... }:

{

# this is for the physicl machine with two NVIDIA cards
  imports = [ 
      ./basic-setup.nix

      ../hardware/nvidia.nix

      ../hardware/intel.nix

      ../modules/jupyterhub.nix

	  ../modules/open-webui.nix

	  ../modules/ollama.nix
  ];
  
  # Define a user account.
  users.mutableUsers = lib.mkForce true;
  nix.settings.trusted-users = lib.mkForce [ "mer" ];

  users.users.demo.enable = lib.mkForce false;
  services.getty.autologinUser = lib.mkForce "mer";
  users.users.mer.enable = lib.mkForce true;

  # To use https, create a cert with mkcert:
  # nix-shell -p mkcert
  # sudo mkcert -install
  # sudo mkcert -CAROOT
  # sudo mkcert localhost 127.0.0.1 ::1
  # sudo mv localhost*.pem /root/.local/share/mkcert/
  services.jupyterhub = lib.mkForce {
		extraConfig = ''
		  c.JupyterHub.ssl_key = '/root/.local/share/mkcert/localhost+2-key.pem'
		  c.JupyterHub.ssl_cert = '/root/.local/share/mkcert/localhost+2.pem'
		  c.JupyterHub.admin_access = True
		  c.Authenticator.allow_all = True
		  c.Authenticator.delete_invalid_users = True
		  c.Authenticator.admin_users = {'mer'}

		  c.LocalAuthenticator.create_system_users = True
		  c.DummyAuthenticator.password = "go4it"

		  c.SystemdSpawner.extra_paths = ['/run/current-system/sw/bin']
		  c.SystemdSpawner.mem_limit = '3G'
		  c.SystemdSpawner.cpu_limit = 4.0
		  c.SystemdSpawner.isolate_tmp = True
		  c.SystemdSpawner.isolate_devices = True
		  c.SystemdSpawner.dynamic_users = True
		'';
  };

  services.getty.helpLine = ''
  JupyterHub http://www.xxx.yyy.zzz:8000
  Open-WebUI http://www.xxx.yyy.zzz:8080
  Ollama     http://www.xxx.yyy.zzz:11434
  
  IP adress  ip iw ifconfig or fastfetch
  System     htop btop nvitop
  Shutdown   sudo shutdown now -h
  Update     curl -fsSL https://raw.githubusercontent.com/zero-overhead/BYOD/refs/heads/main/setup-server.sh | bash -s server/x86_64-headless-nvidia-52-61.nix
  '';
  
}
