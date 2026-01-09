{ config, lib, pkgs, ... }:
{  
  imports = [
    ./hardware-configuration.nix
    ../../../modules/nixos/core.nix
    ../../../modules/nixos/xserver.nix
    ../../../modules/nixos/dwm.nix
    ../../../modules/nixos/network.nix
    ../../../modules/nixos/audio.nix
    ../../../modules/nixos/users.nix
    ../../../modules/nixos/tlp.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.timeout = 15;

  networking.hostName = "ThinkPad";

  services.fwupd.enable = true; /*automatizace aktualizace BIOSU/UEFI*/
  programs.firefox.enable = true;

  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";
  zramSwap.memoryPercent = 50;
  boot.kernel.sysctl."vm.swappiness" = 100;

  system.stateVersion = "25.11";
}

