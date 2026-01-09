{ pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "Europe/Prague";
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  environment.systemPackages = with pkgs; [
  git
  wget
  curl
  ncdu
  usbutils
  fastfetch 
  ];
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