{ pkgs, ... }:
{
  networking.hostName = "nixOS"; # Define your hostname.

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true; # Povolení Waylandu
  services.desktopManager.plasma6.enable = true; # KDE plasma
  
  environment.plasma6.excludePackages = with pkgs.kdePackages; [konsole kate]; # odebrani konzole a kate z kde plasmy
  environment.systemPackages = with pkgs; [
    kitty
  ];
  environment.variables.TERMINAL = "kitty"; # nastaveni kitty jako defaultniho terminalu
}