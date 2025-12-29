{ pkgs, ... }:

{
  imports = [
    ../../common/home-defaults.nix
  ];

  home.username = "michal";
  home.homeDirectory = "/home/michal";
  home.stateVersion = "25.11";
}