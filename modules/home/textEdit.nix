{ pkgs, ... }: {
  home.packages = with pkgs; [
    vscode
    libreoffice-qt
    texliveFull
    obsidian 
  ];
}