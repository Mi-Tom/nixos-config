{ pkgs, ... }: {
  home.packages = with pkgs; [
    firefox
    blender
    spotify
    discord 
  ];
}