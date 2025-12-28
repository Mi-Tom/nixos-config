# ~/.bashrc

alias ls='ls --color=auto'
alias grep='grep --color=auto'

Gray='\033[0;37m'
Green='\033[1;32m'
Cyan='\033[1;36m'
Yellow='\033[1;33m'
NC='\033[0m'

if [ -f ~/.nix-profile/share/git/contrib/completion/git-prompt.sh ]; then
  source ~/.nix-profile/share/git/contrib/completion/git-prompt.sh
elif [ -f /run/current-system/sw/share/git/contrib/completion/git-prompt.sh ]; then
  source /run/current-system/sw/share/git/contrib/completion/git-prompt.sh
elif [ -f /usr/share/git/completion/git-prompt.sh ]; then
  source /usr/share/git/completion/git-prompt.sh
fi

export GIT_PS1_SHOWDIRTYSTATE=1

export PS1="\[${Gray}\]\t\[${NC}\] \
\[${Green}\]\u@\h\[${NC}\] \
\[${Cyan}\]\w \
\[${Yellow}\]\$(__git_ps1 ' (%s)')\[${NC}\]\n\$ "

