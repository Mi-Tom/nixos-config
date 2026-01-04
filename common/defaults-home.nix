{ pkgs, ... }:

{

  home.username = "michal";
  home.homeDirectory = "/home/michal";
  home.stateVersion = "25.11";

/*<--------------------------------------------nastaveni terminalu------------------------------------------------>*/
  # AKTIVACE BASH KONFIGURACE PŘES HOME MANAGER
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    settings = {
      # Formát zůstává stejný, měníme styly u jednotlivých modulů
      format = "$time$username$hostname $directory$git_branch\n$character";

      time = {
        disabled = false;
        time_format = "%H:%M";
        style = "bold white"; # Čas bude bílý
        format = "[$time] ";
      };

      username = {
        show_always = true;
        style_user = "bold green"; # Jméno bude zelené
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = false;
        style = "bold green"; # Hostitel taky zeleně, aby to ladilo k jménu
        format = "@[$hostname]($style) ";
      };

      directory = {
        style = "bold cyan"; # Cesta bude azurová
      };

      git_branch = {
        symbol = "git:(";
        style = "bold yellow"; # Větev bude žlutá
        format = "on [$symbol$branch]($style)) ";
      };

      character = {
        success_symbol = "[\\$](bold white)"; # Dolar bude bílý (při úspěchu)
        error_symbol = "[\\$](bold red)";    # Při chybě zůstane červený (lepší pro orientaci)
      };
    };
  };
}
