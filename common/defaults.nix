{ pkgs, inputs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.fwupd.enable = true;

  programs.bash = {
    completion.enable = true;
    promptInit = builtins.readFile ./bash-settings.sh;

    interactiveShellInit = '' source ${pkgs.blesh}/share/blesh/ble.sh '';
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Prague";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  nixpkgs.overlays = [
    (final: prev: {
      dwm = inputs.dwm-config.packages.${pkgs.system}.default;
    })
  ];
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
  hardware.enableAllFirmware = true;
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
    dmenu
    st
    codeblocks
    gcc
    pkgsCross.mingwW64.stdenv.cc
  ];
  environment.plasma6.excludePackages = with pkgs.kdePackages; [kate]; # odebrani konzole z kde plasmy
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };
}

