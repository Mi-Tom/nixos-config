{ config, lib, pkgs, ... }:
{  
  imports = [
    ./hardware-configuration.nix
    ../../../modules/nixos/core.nix
    ../../../modules/nixos/xserver.nix
    ../../../modules/nixos/kdePlasma.nix
    ../../../modules/nixos/network.nix
    ../../../modules/nixos/audio.nix
    ../../../modules/nixos/users.nix
    ../../../modules/nixos/flatpak.nix
    ../../../modules/nixos/docker.nix
  ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    systemd-boot.enable = false;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    timeout = 15;
  }; 
  
  environment.systemPackages = [ pkgs.ntfs3g ];
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/mnt/shared" = {
    device = "/dev/disk/by-uuid/3EA197B70D48B3DE";
    fsType = "ntfs-3g";
    options = [ 
      "rw"
      "umask=000"
      "dmask=000"
      "fmask=000"
      "nls=utf8"
      "nofail"
    ];
  };

  networking.hostName = "nixOS"; # Define your hostname.

  services.fwupd.enable = true; /*automatizace aktualizace BIOSU/UEFI*/
  services.printing.enable = true;

  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";
  zramSwap.memoryPercent = 25;
  boot.kernel.sysctl."vm.swappiness" = 100;

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "25.11";
}

