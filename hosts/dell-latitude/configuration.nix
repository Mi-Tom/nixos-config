{ config, lib, pkgs, ... }:
{  
  imports = [
    ./hardware-configuration.nix
    ../../common/defaults.nix
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

  networking.networkmanager.wifi.powersave = false;
  networking.hostName = "nixOS"; # Define your hostname.

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true; # Povolení Waylandu
  services.desktopManager.plasma6.enable = true; # KDE plasma

  environment.systemPackages = with pkgs; [
    ntfs3g
    firefox
    blender
    vlc
    spotify
    discord
    kitty
    vscode
    gitkraken
    docker-compose
    libreoffice-qt
    texliveFull
  ];
  environment.plasma6.excludePackages = with pkgs.kdePackages; [konsole kate]; # odebrani konzole a kate z kde plasmy
  environment.variables.TERMINAL = "kitty"; # nastaveni kitty jako defaultniho terminalu
  programs.firefox.enable = true;

  virtualisation.docker = {
    enable = true;
    listenOptions = [ "/run/docker.sock" ];
  };
  systemd.services.docker.unitConfig.StopIdleTimeoutSec = "300";

  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";
  zramSwap.memoryPercent = 25;
  boot.kernel.sysctl."vm.swappiness" = 100;

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  # system.autoUpgrade = {
  #   enable = true;
  #   flake = "/home/michal/nixos-config";
  #   dates = "weekly";
  #   flags = [
  #     "--update-input" "nixpkgs"
  #     "--commit-lock-file"
  #   ];
  #   allowReboot = false;
  # };
  system.stateVersion = "25.11";
}

