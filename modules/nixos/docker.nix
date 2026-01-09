{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    listenOptions = [ "/run/docker.sock" ];
  };
  systemd.services.docker.unitConfig.StopIdleTimeoutSec = "300";

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}