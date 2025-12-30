{ pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.fwupd.enable = true;

  programs.bash = {
    completion.enable = true;
    promptInit = builtins.readFile ./bash-settings.sh;

    interactiveShellInit = '' source ${pkgs.blesh}/share/blesh/ble.sh '';
  };

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;


  time.timeZone = "Europe/Prague";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
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

  users.users.michal = {
    isNormalUser = true;
    description = "Michal";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = with pkgs; [tree];
  };

  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

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
    blesh
    usbutils
    curl
    pciutils
    codeblocks
    gcc
    pkgsCross.mingwW64.stdenv.cc
    gnumake
    cmake
    gdb
    pkg-config 
    clang-tools
  ];
  environment.plasma6.excludePackages = with pkgs.kdePackages; [kate]; # odebrani konzole z kde plasmy
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 5d";
  };
}

