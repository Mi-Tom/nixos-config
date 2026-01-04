{ pkgs, ... }:

{
  home.username = "michal";
  home.homeDirectory = "/home/michal";
  home.stateVersion = "25.11";

  programs.bash.enable = true;

  programs.starship = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      format = "$time$username$hostname $directory$git_branch\n$character";

      time = {
        disabled = false;
        time_format = "%H:%M";
        style = "bold white";
        format = "[\\[$time\\]]($style) "; 
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
        symbol = "git:(";
        style = "bold yellow";
        format = "on [$symbol$branch]($style)) ";
      };

      character = {
        success_symbol = "[\\$](bold white)";
        error_symbol = "[\\$](bold red)";
      };
    };
  };
}
