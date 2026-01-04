{ pkgs, ... }:

{
  imports = [
    ../../common/defaults-home.nix
  ];

  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;/*rika emulatoru terminalu ja jsem konstantni nevsimej si me*/
    };
  };
}