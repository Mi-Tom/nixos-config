{ config, pkgs, ... }:
{
  imports = [
    ../../../modules/home/core.nix
    ../../../modules/home/zsh.nix
  ];
  home.username = "michal";
  home.homeDirectory = "/home/michal";
  home.stateVersion = "25.11";
}
