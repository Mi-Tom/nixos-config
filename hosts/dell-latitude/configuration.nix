{ config, lib, pkgs, ... }:
{  
  imports = [
    ./hardware-configuration.nix
    ../../common/defaults.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nixOS"; # Define your hostname.

  services.displayManager.sddm.wayland.enable = true; # Povolení Waylandu
  services.xserver.desktopManager.plasma6.enable = false;
  services.desktopManager.plasma6.enable = true; #vynuceni pouze waylandu
  environment.plasma6.excludePackages = with pkgs.kdePackages; [konsole]; # odebrani konzole z kde plasmy

  nixpkgs.config.allowUnfree = true;

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
  ];
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

  system.autoUpgrade = {
    enable = true;
    flake = "/home/michal/nixos-config";
    dates = "weekly";
    flags = [
      "--update-input" "nixpkgs"
      "--commit-lock-file"
    ];
    allowReboot = false;
  };

  fileSystems."/shared" = { # nastaveni prav na sdilenem disku, pokud nefunguje dopis: "rw" - čtení i zápis; "uid=1000" - tvůj uživatel (obvykle první vytvořený má ID 1000); "gid=100" - skupina users "umask=000" - plná práva pro všechny (jednoduché řešení pro sdílený disk)
  device = "/dev/disk/by-label/SHARED";
  fsType = "ntfs-3g";
  options = [ "nofail" ]; 
};

  system.stateVersion = "25.11";
}

