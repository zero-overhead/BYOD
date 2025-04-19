let pkgs = import <nixpkgs> {};
in pkgs.mkShell {
  buildInputs = [ pkgs.php pkgs.adminer ];
  shellHook = ''
    firefox --new-tab http://localhost:8000/adminer.php &
    php -t ${pkgs.adminer.outPath} -S localhost:8000
    #ssh -y -R 80:localhost:8000 serveo.net
  '';
}
