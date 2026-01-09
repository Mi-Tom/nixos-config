{ config, pkgs, ... }:
{
  imports = [
    ../../modules/home-manager/core.nix 
    ../../modules/home-manager/zsh.nix 
  ];
  home.username = "michal";
  home.homeDirectory = "/home/michal";
  home.stateVersion = "25.11";
}