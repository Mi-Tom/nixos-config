{ pkgs, ... }:

{
  home.username = "michal";
  home.homeDirectory = "/home/michal";
  home.stateVersion = "25.11";

  home.enableNixpkgsReleaseCheck = false;

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      if [ -f ${pkgs.blesh}/share/blesh/ble.sh ]; then
        source ${pkgs.blesh}/share/blesh/ble.sh
      fi
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;

    settings = {

      add_newline = false;

      format = "$time$username$hostname $directory$git_branch\n$character";

      time = {
        disabled = false;
        time_format = "%H:%M:%S";
        style = "bold white";
        format = "$time "; 
      };

      username = {
        show_always = true;
        style_user = "bold green";
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = false;
        style = "bold green";
        format = "@[$hostname]($style) ";
      };

      directory = {
        style = "bold cyan";
      };

      git_branch = {
        style = "bold yellow";
        format = "on [\\($branch\\)]($style) ";
      };

      character = {
        success_symbol = "[\\$](bold white)";
        error_symbol = "[\\$](bold red)";
      };
    };
  };
}
