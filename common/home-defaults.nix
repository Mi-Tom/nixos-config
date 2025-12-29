{ pkgs, ... }: {
  programs.bash = {
    enable = true;
    
    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --color=auto";
    };

    bashrcExtra = ''
      # Definice barev
      Gray='\033[0;37m'
      Green='\033[1;32m'
      Cyan='\033[1;36m'
      Yellow='\033[1;33m'
      NC='\033[0m'

      # Načtení Git promptu (v NixOS je cesta v /run/current-system/sw/...)
      if [ -f /run/current-system/sw/share/git/contrib/completion/git-prompt.sh ]; then
        source /run/current-system/sw/share/git/contrib/completion/git-prompt.sh
      fi

      export GIT_PS1_SHOWDIRTYSTATE=1

      # Nastavení PS1
      export PS1="\[$Gray\]\t\[$NC\] \[$Green\]\u@\h\[$NC\] \[$Cyan\]\w \[$Yellow\]\$(__git_ps1 ' (%s)')\[$NC\]\n\$ "
    '';
  };

  home.packages = [ pkgs.git ]; # ujisteni se ze git existuje
}
