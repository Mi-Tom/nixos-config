{ pkgs, ... }:

{
  imports = [
    ../../common/home-defaults.nix  # Tímto se načte Bash prompt, Plasma lišta, atd.
  ];

  programs.vscode.enable = true;
  programs.kitty.enable = true;

  home.username = "michal";
  home.homeDirectory = "/home/michal";
  home.stateVersion = "25.11";
}