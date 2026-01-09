{ pkgs, ... }:
{
  services.displayManager.ly.enable = true;
  services.xserver.windowManager.dwm.enable = true;
  nixpkgs.overlays = [
    (final: prev: {
      dwm = inputs.dwm-config.packages.${final.stdenv.hostPlatform.system}.default;
    })
  ];
  environment.systemPackages = with pkgs; [
    dmenu
    st
    maim slop xclip libnotify /*nastroje pro fotky obrazovky*/
  ];
}