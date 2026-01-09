{ pkgs, ... }: {
  home.packages = with pkgs; [
    gitkraken
    /* C */
    codeblocks
    gcc
    pkgsCross.mingwW64.stdenv.cc 
  ];
}