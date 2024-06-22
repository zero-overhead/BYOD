{pkgs, ...}: {
    home.username = "demo";
    home.homeDirectory = "/home/demo";
    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
    nixpkgs.config.allowUnfree = true; 
}
