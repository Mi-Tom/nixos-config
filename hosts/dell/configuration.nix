{ config, lib, pkgs, ... }:
{  
  imports = [
    ./hardware-configuration.nix
    ../../common/defaults.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nixOS"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    firefox
    #  wget
  ];
  programs.firefox.enable = true;

  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";
  zramSwap.memoryPercent = 25;
  boot.kernel.sysctl."vm.swappiness" = 100;

  system.stateVersion = "25.11";
}

