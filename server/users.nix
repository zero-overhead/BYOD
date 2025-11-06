{ pkgs, lib, ... }:

{
  # https://mynixos.com/nixpkgs/option/services.getty
  services.getty.autologinUser = "demo";
  services.getty.autologinOnce = true;
  
  users.mutableUsers = false;
  nix.settings.trusted-users = [ "demo" ];
  
  # Define a user account.
  users.users.demo = {
    isNormalUser = true;
    enable = true;
    description = "demo";
    homeMode = "711"; # to ensure $HOME/public_html/ is accessable for httpd
    extraGroups = [ "networkmanager" "wheel" "video" "dialout" "vboxsf" "kvm" ];
    # mkpasswd -m sha-512
    initialHashedPassword = "$6$rfbRiHox9teafYrN$m5ga/Vs74pAAobd9NLhCtFzCEOW5esIX19qnC7RO41H.XiF302/2AE8GUBZNOw60.sG.w2VBkuamKCBL.B8bg1";
    #packages = with pkgs; [
    #  kdePackages.kate
    #  thunderbird
    #];
  };

  users.users.mer = {
    isNormalUser = true;
    enable = false;
    description = "mer";
    homeMode = "711"; # to ensure $HOME/public_html/ is accessable for httpd
    extraGroups = [ "networkmanager" "wheel" "video" "dialout" "vboxsf" "kvm" ];
    # mkpasswd -m sha-512
    initialHashedPassword = "$6$hz6mIMz4E2fB3d2.$K/RFwMdQo1HXtc.nq/tenNGozHNzHVUAaEBw1lUdFjVxSbEkBSFc7GaiX9YveKv3ZB3WmZAaAhnU1wWSRrtOe/";
    #packages = with pkgs; [
    #  kdePackages.kate
    #  thunderbird
    #];
  };
}
