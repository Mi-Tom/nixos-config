{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      setopt PROMPT_SUBST

      parse_git_status() {
        if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then return; fi
        local branch=$(git branch --show-current 2>/dev/null)
        local git_details=$(git status --porcelain 2>/dev/null)
        local status_symbol=""

        if [ -z "$git_details" ]; then
          status_symbol=""
        elif echo "$git_details" | grep -q "^??"; then
          status_symbol="#"
        elif echo "$git_details" | grep -q "^[AMRD]"; then
          status_symbol="+"
        else
          status_symbol="*"
        fi
        
        # Vrátí žlutou větev se symbolem v závorkách
        echo " %F{yellow}($branch$status_symbol)%f"
      }

      PROMPT='%F{white}%D{%H:%M}%f %F{green}%n@%m%f %F{cyan}%~%f$(parse_git_status)
%F{white}$%f '
    '';
  }
}