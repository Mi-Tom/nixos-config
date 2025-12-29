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

  programs.plasma = {
    enable = true;

    # Globální vzhled a barvy
    workspace = {
      clickItemTo = "select";
      lookAndFeel = "org.kde.breezedark.desktop";
      colorScheme = "BreezeDark";

    };

    # Konfigurace panelu
    panels = [{
      location = "top";
      height = 50;
      floating = true;
      opacity = "opaque";
      hiding = "autohide";

      widgets = [
        "org.kde.plasma.kickoff"
        
        # Připnuté aplikace
        {
          name = "org.kde.plasma.icontasks";
          config = {
            General = {
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:firefox.desktop"
              ];
            };
          };
        }

        # Pružná mezera (vytlačí zbytek doprava)
        "org.kde.plasma.marginsseparator"

        # Systémová část (všechny ty ikony vpravo)
        {
          systemTray.items = {
            # Ikony, které jsou vidět TRVALE
            shown = [
              "org.kde.plasma.notifications"    # Oznámení
              "org.kde.plasma.weather"          # Počasí
              "org.kde.plasma.volume"           # Zvuk
              "org.kde.plasma.brightness"       # Jas (podsvícení)
              "org.kde.plasma.networkmanagement" # Wi-Fi
              "org.kde.plasma.battery"          # Baterie
            ];
            # Ikony, které se ukážou jen, když jsou relevantní (v "šipce")
            extra = [
              "org.kde.plasma.clipboard"        # Schránka
              "org.kde.plasma.devicenotifier"   # Připojená zařízení (USB)
              "org.kde.plasma.bluetooth"        # Bluetooth
              "org.kde.plasma.mediacontroller"  # Přehrávač médií
              "org.kde.plasma.keyboardlayout"   # Rozvržení klávesnice (us/cz)
              "org.kde.plasma.printmanager"     # Tiskárny
            ];
          };
        }

        # Digitální hodiny (úplně vpravo)
        {
          name = "org.kde.plasma.digitalclock";
          config = {
            Appearance = {
              showSeconds = "Never";     # Vteřiny tam na screenu nejsou
              showDate = "Always";      # Datum pod časem
              dateStyle = "short";
              use24hFormat = 2;         # 24h formát
            };
          };
        }
        # Widget pro zobrazení plochy
        "org.kde.plasma.showdesktop"
      ];
    }];
  }
}
