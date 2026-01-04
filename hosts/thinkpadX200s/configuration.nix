{ config, lib, pkgs, ... }:
{  
  imports = [
    ./hardware-configuration.nix
    ../../common/defaults.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.timeout = 15;

  networking.hostName = "ThinkPad";

  services.displayManager.ly.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
    acpi       # Rychlý příkaz 'acpi -b' pro zjištění procent a času
    powertop   # Spusť 'sudo powertop', přepni se na záložku 'Overview' a uvidíš aktuální odběr ve Wattech (W)
    lm_sensors # Příkaz 'sensors' pro sledování teploty, aby větrák zbytečně nežral proud
  ];
  programs.firefox.enable = true;
  
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = false;
  powerManagement.powertop.enable = true; /*teoreticky ma vypnout vse co zrovna nepotrebuji*/
  services.tlp = {
  enable = true;
  settings = {
    # Na baterii chceme "powersave", na kabelu "performance".
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

    # Nastaví nižší frekvenci grafiky při chodu na baterii.
    INTEL_GPU_MIN_FREQ_ON_AC = 0;
    INTEL_GPU_MAX_FREQ_ON_AC = 800;
    INTEL_GPU_MIN_FREQ_ON_BAT = 0;
    INTEL_GPU_MAX_FREQ_ON_BAT = 400;

    # Uspání zvukové karty po 1 sekundě nečinnosti.
    SOUND_POWER_SAVE_ON_BAT = 1;
    USB_AUTOSUSPEND = 1;
  };
};

  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";
  zramSwap.memoryPercent = 50;
  boot.kernel.sysctl."vm.swappiness" = 100;

  system.stateVersion = "25.11";
}

