#https://nixos.wiki/wiki/Nvidia
{ config, lib, pkgs, ... }:
{
  boot.initrd.kernelModules = [ "i915" ];  
}

