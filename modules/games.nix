#https://discourse.nixos.org/t/gamescope-refuses-to-work-with-steam/71417/4
#https://search.nixos.org/options?channel=25.05&query=programs.steam
{
  pkgs,
  ...
}:

{
  #environment.systemPackages = with pkgs; [
    #protonup-qt
    #cabextract # Needed for ^

    #dxvk

    #wineWowPackages.full
    #winetricks
    #faudio
    # Performance tools
    #mangohud
  #];

  #environment.sessionVariables = {
    # Default 64-bit Wine prefix for modern games
    #WINEPREFIX = "$HOME/.wine";
    #WINEARCH = "win64";

    #OBS_VKCAPTURE = "1";
    #RADV_TEX_ANISO = "16";
  #};

  #users.users.demo.packages = with pkgs; [
  #  heroic
  #  lutris
  #  dolphin-emu
  #  mcpelauncher-ui-qt
  #  melonDS
  #  steam-rom-manager
  #  srb2

   # prismlauncher
  #];

  programs = {
    gamescope.enable = true;
    gamemode.enable = true;
    steam = {
      enable = true;
   #   localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;
   #   extest.enable = true;
   #   package = pkgs.steam.override {
   #     extraEnv = {
   #       OBS_VKCAPTURE = "1";
   #       RADV_TEX_ANISO = "16";
   #     };
   #   };
   #   extraCompatPackages = [
   #     pkgs.steamtinkerlaunch
   #     pkgs.proton-cachyos
   #     pkgs.proton-ge-bin
   #   ];
    };
  };
}