{ pkgs, lib, ... }:

{
  # nix-shell -p mkcert
  # sudo mkcert -install
  # sudo mkcert -CAROOT
  # sudo mkcert localhost 127.0.0.1 ::1
  # sudo mv localhost*.pem /root/.local/share/mkcert/
  #security.pki.certificateFiles = [ /root/.local/share/mkcert/rootCA.pem ];

  # List packages installed in system profile. To search, run:
  # \$ nix search wget
  environment.systemPackages = with pkgs; [
  
    texliveFull
    pandoc
    imagemagick
    gnuplot
    ffmpeg
    mkcert
    
    rakudo
    zef
  ];

  services.jupyterhub = {
    enable = true;
    host = "0.0.0.0";
    port = 8000;
    # To use https, create a cert with mkcert:
    # sudo mkcert -install
    # sudo mkcert -CAROOT
    # sudo mkcert localhost 127.0.0.1 ::1
    # sudo mv localhost*.pem /root/.local/share/mkcert/
    #
    # c.JupyterHub.tornado_settings = {'headers': {'Content-Security-Policy': "frame-ancestors * 'self' "}}
    # c.JupyterHub.spawner_class = 'jupyterhub.spawner.LocalProcessSpawner'
    # c.NotebookApp.tornado_settings = {
    #      'headers': {
    #          'Content-Security-Policy': "default-src 'self' *"
    #      }
    # }
    # c.JupyterHub.tornado_settings = {
    #     'headers': {
    #         'Content-Security-Policy': "default-src 'self' *"
    #     }
    # }
    # c.ServerApp.tornado_settings = {
    #     'headers': {
    #         'Content-Security-Policy': "default-src 'self' *"
    #     }
    # }
    authentication = "jupyterhub.auth.DummyAuthenticator";    
    
    #c.JupyterHub.ssl_key = '/root/.local/share/mkcert/localhost+2-key.pem'
    #c.JupyterHub.ssl_cert = '/root/.local/share/mkcert/localhost+2.pem'

    extraConfig = ''
      c.JupyterHub.admin_access = True
      c.Authenticator.allow_all = True
      c.Authenticator.delete_invalid_users = True
      c.Authenticator.admin_users = { 'demo' 'mer' }

      c.JupyterHub.tornado_settings = {'slow_spawn_timeout': 120}
      c.Spawner.http_timeout = 120
      c.Spawner.start_timeout = 120

      c.LocalAuthenticator.create_system_users = True
      c.DummyAuthenticator.password = "go"

      c.SystemdSpawner.extra_paths = ['/run/current-system/sw/bin']
      c.SystemdSpawner.mem_limit = '3G'
      c.SystemdSpawner.cpu_limit = 4.0
      c.SystemdSpawner.isolate_tmp = True
      c.SystemdSpawner.isolate_devices = True
      c.SystemdSpawner.dynamic_users = True
    '';

    jupyterlabEnv = pkgs.python3.withPackages (p: with p; [
       jupyterhub
       jupyterlab
       jupyterlab-git
       jupyterlab-lsp
       jupyterlab-widgets
#       jupyterlab-execute-time
    ]);
  
    kernels = {
      python3 = let
        env = (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
                jedi-language-server
                ipykernel
                bokeh # interactive plots
                bokeh-sampledata
                hf-xet
                ipython
                ipympl # jupyter lab matplotlib extension
                ipywidgets
                ipydatawidgets
                jupyter-book
                jupytext
                keyboard
                litellm
                matplotlib
                mariadb
                metakernel
                mysql-connector
                numpy
                ollama
                pandas
                pillow
                pip
                plotly
                prettytable
                pycryptodome
                pylint
                requests
                seaborn
                tabulate
                tkinter
                wheel
                scikit-image
                scikit-learn
                scipy
                pytest
                pytest-cov
                torch
                torchvision
                torchaudio
              ]));
        in {
          displayName = "Python 3";
          argv = [
            "${env.interpreter}"
            "-m"
            "ipykernel_launcher"
            "-f"
            "{connection_file}"
          ];
          language = "python";
          logo32 = "${env}/${env.sitePackages}/ipykernel/resources/logo-32x32.png";
          logo64 = "${env}/${env.sitePackages}/ipykernel/resources/logo-64x64.png";
        };
    };
  };
}
