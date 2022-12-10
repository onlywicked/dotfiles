PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %# '

# enable auto completion
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

# enable auto correction
setopt CORRECT
setopt CORRECT_ALL

export PATH="/opt/homebrew/bin:$PATH"

## java config
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

# macos version does not support tmux-256color
# So, overriding it the brew installed version
NCURSES_PATH=/opt/homebrew/opt/ncurses/bin
if [ -d $NCURSES_PATH ] ; then
  export PATH="$NCURSES_PATH:$PATH"
fi


[[ -s "/Users/arman/.gvm/scripts/gvm" ]] && source "/Users/arman/.gvm/scripts/gvm"

if [ -x "$(command -v starship)" ] ; then
  export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
  eval "$(starship init zsh --print-full-init)"
fi

if [ -x "$(command -v kubectl)" ] ; then
  alias k="kubectl"
  source <(kubectl completion zsh)
  compdef k="kubectl"
fi

## golang config
export GOPATH="$HOME/code/go"
export PATH="$GOPATH/bin:$PATH"

## n config
export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH

## npm config
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

export YTFZF_PLAYER="mpv --autofit-larger=100% --geometry=1080-2-2"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
