{ pkgs, ... }: {
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}