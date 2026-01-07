{ config, pkgs, ... }:
{
  imports = [
    ../../home-manager/core.nix 
    ../../home-manager/zsh.nix 
  ];
  home.username = "michal";
  home.homeDirectory = "/home/michal";
  home.stateVersion = "25.11";
}
