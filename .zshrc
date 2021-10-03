PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %# '

# enable auto completion
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

# enable auto correction
setopt CORRECT
setopt CORRECT_ALL

# macos version does not support tmux-256color
# So, overriding it the brew installed version
NCURSES_PATH=/opt/homebrew/opt/ncurses/bin
if [ -d $NCURSES_PATH ] ; then
  export PATH="$NCURSES_PATH:$PATH"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -s "/Users/arman/.gvm/scripts/gvm" ]] && source "/Users/arman/.gvm/scripts/gvm"


if [ -x "$(command -v starship)" ] ; then
  export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
  eval "$(starship init zsh --print-full-init)"
fi

if [ -x "$(command -v kubectl)" ] ; then
  source <(kubectl completion zsh)
fi
