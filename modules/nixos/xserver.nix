{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us,cz";
    variant = ",qwerty";
    options = "grp:win_space_toggle";
  };
  console.useXkbConfig = true;

  services.libinput.enable = true;
}