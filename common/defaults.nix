{ pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;


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

  environment.systemPackages = with pkgs; [
    neovim
    git
    fastfetch
    kdePackages.ark
    kdePackages.spectacle
    kdePackages.gwenview
    vlc
    ncdu
    wqet
    usbutils
    curl
    pciutils
  ];
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

