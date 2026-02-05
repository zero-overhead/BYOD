{ pkgs, lib, ... }:
let
    # https://wiki.nixos.org/wiki/Python
    my-python = pkgs.python3.override {
      self = my-python;
      packageOverrides = pyfinal: pyprev: {
        # dieses Python-Packete exitieren leider nicht in search.nixos.org - deshalb müssen wir sie selbst bauen
        pedal = pyfinal.callPackage ../nix-shells/extra-packages/pedal.nix { };
        #pgzero = pyfinal.callPackage ../nix-shells/extra-packages/pgzero.nix { };
        #jturtle = pyfinal.callPackage ../nix-shells/extra-packages/jturtle.nix { };
        #jupyterlab-rise = pyfinal.callPackage ../nix-shells/extra-packages/jupyterlab-rise.nix { };
        #jupyterlab-mathjax3 = pyfinal.callPackage ../nix-shells/extra-packages/jupyterlab-mathjax3.nix { };
        itables = pyfinal.callPackage ../nix-shells/extra-packages/itables.nix { };
      };
    };
in
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
  
    my-python
    jupyter
    texliveFull
    pandoc
    imagemagick
    inkscape
    gnuplot
    ffmpeg
    mkcert
    quarto
    
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

    jupyterlabEnv = my-python.withPackages (p: with p; [
       jupyterhub
       jupyterlab
       jupyterlab-git
       jupyterlab-lsp
       jupyterlab-widgets
#       jupyterlab-rise
#       jupyterlab-mathjax3
#       jupyterlab-execute-time
    ]);
  
    kernels = {
      python3 = let
        env = (my-python.withPackages (pythonPackages: with pythonPackages; [
                autograd
                bokeh # interactive plots
                bokeh-sampledata
                distutils
                hf-xet
                ipydatawidgets
                ipykernel
                ipympl # jupyter lab matplotlib extension
                ipython
                ipywidgets
                itables
                jedi-language-server
                #jturtle
                jupyter-book
                jupyterlab
                jupyterlab-git
                jupyterlab-lsp
                #jupyterlab-rise
                jupyterlab-widgets
                #jupyterlab-language-pack-de-DE
                jupytext
                keyboard
                litellm
                llm
                llm-anthropic
                llm-ollama
                llm-openai-plugin
                llm-gemini
                mariadb
                matplotlib
                metakernel
                mysql-connector
                numpy
                numpy-stl
                ollama
                openai
                openpyxl
                pandas
                pedal
                #pgzero
                pillow
                pip
                plotly
                prettytable
                pycryptodome
                pygame-ce
                pylint
                pytest
                pytest-cov
                python-gnupg
                requests
                scikit-image
                scikit-learn
                scipy
                seaborn
                setuptools
                shapely
                tabulate
                #tkinter
                torch
                torchaudio
                torchvision
                tqdm
                wheel
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
