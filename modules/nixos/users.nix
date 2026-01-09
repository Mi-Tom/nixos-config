{ pkgs, ... }: {
  programs.zsh.enable = true;
  users.users.michal = {
    isNormalUser = true;
    description = "Michal";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = with pkgs; [tree];
  };
}