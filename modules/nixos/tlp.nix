{ pkgs, ... }:
{
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
}