{ pkgs, inputs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.hostPlatform = "x86_64-linux";

  services.fwupd.enable = true; /*automatizace aktualizace BIOSU/UEFI*/

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  time.timeZone = "Europe/Prague";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.xserver.enable = true;
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.xkb = {
    layout = "us,cz";
    variant = ",qwerty";
    options = "grp:win_space_toggle";
  };
  console.useXkbConfig = true;

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  programs.zsh.enable = true;

  users.users.michal = {
    isNormalUser = true;
    description = "Michal";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = with pkgs; [tree];
  };

  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    fastfetch
    kdePackages.ark
    kdePackages.spectacle
    kdePackages.gwenview
    vlc
    ncdu
    wget
    usbutils
    curl
    dmenu
    st
    codeblocks
    gcc
    pkgsCross.mingwW64.stdenv.cc 
  ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
  ];

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };
}

