{ config, lib, pkgs, ... }:
{  
  imports = [
    ./hardware-configuration.nix
    ../../common/defaults.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "ThinkPad"; # Define your hostname.

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
    #  wget
  ];
  programs.firefox.enable = true;
  
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;

  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";
  zramSwap.memoryPercent = 50;
  boot.kernel.sysctl."vm.swappiness" = 100;

  system.stateVersion = "25.11";
}

