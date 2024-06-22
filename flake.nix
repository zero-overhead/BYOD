{
    description = "Standard Home-Manager Configuration";

    inputs.nixpkgs.url = "nixpkgs/nixos-24.05";
    inputs.home-manager.url = "github:nix-community/home-manager/release-24.05";
    inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

    outputs = { nixpkgs, home-manager, ...}:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
    in {
        defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
        homeConfigurations = {
            # default setup for user demo
            "demo" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./home.nix ./desktop.nix ];
            };
            # spezial setup, aktivierung mittels "make web-entwicklung" oder "home-manager switch --flake .#web-entwicklung"
            web-entwicklung = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./home.nix ./web-entwicklung.nix ];
            };
        };
    };
}