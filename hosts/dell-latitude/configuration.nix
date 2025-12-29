{ config, lib, pkgs, ... }:
{  
  imports = [
    ./hardware-configuration.nix
    ../../common/defaults.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.timeout = 15;
  
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/mnt/shared" = {
    device = "/dev/disk/by-uuid/3EA197B70D48B3DE";
    fsType = "ntfs-3g";
    options = [ 
      "rw"            # Read-Write
      "umask=000"     # Nastaví globální masku na 777 (všichni můžou vše)
      "dmask=000"     # Práva pro složky (777)
      "fmask=000"     # Práva pro soubory (777)
      "nls=utf8"      # Správné kódování českých znaků
      "nofail"        # Systém naběhne, i když disk nebude nalezen
    ];
  };

  networking.hostName = "nixOS"; # Define your hostname.

  services.displayManager.sddm.wayland.enable = true; # Povolení Waylandu

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
  environment.plasma6.excludePackages = with pkgs.kdePackages; [konsole]; # odebrani konzole z kde plasmy
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

