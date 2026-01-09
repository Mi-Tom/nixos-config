{ config, pkgs, ... }:
{
  imports = [
    ../../../modules/home/core.nix
    ../../../modules/home/zsh.nix
    ../../../modules/home/textEdit.nix
    ../../../modules/home/dev.nix
    ../../../modules/home/dell.nix
  ];
  home.username = "michal";
  home.homeDirectory = "/home/michal";
  home.stateVersion = "25.11";
}