let
  pkgs = import <nixpkgs> {};
in pkgs.mkShell {
  buildInputs = [
    (pkgs.jupyter-all.withPackages(ps: with ps; [
      pandas
      requests
      pip
      wheel
      numpy
      keyboard
      seaborn
      jupytext
      metakernel
      jupyterlab-lsp
      jedi-language-server
      matplotlib
      scikit-image
      scikit-learn
      scipy
      pytest
      pytest-cov
      torch
      torchvision
      torchaudio
      plotly
      autograd
      tqdm
      pycryptodome
      python-gnupg
      pygame
      tkinter
      mariadb
      mysql-connector
      prettytable
      ipykernel
     ]))
   ];

  shellHook = ''
    jupyter --paths
    jupyter lab --notebook-dir=$HOME/Documents
  '';
}
