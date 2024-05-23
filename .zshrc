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
# export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v 17)

function setjdk() {
  if [ $# -ne 0 ]; then
    export JAVA_HOME=`/usr/libexec/java_home -v $@`
    export PATH=$JAVA_HOME/bin:$PATH
  else
    echo "Usage: setjdk {version}"
  fi
}

# macos version does not support tmux-256color
# So, overriding it the brew installed version
NCURSES_PATH=/opt/homebrew/opt/ncurses/bin
if [ -d $NCURSES_PATH ] ; then
  export PATH="$NCURSES_PATH:$PATH"
fi


# [[ -s "/Users/arman/.gvm/scripts/gvm" ]] && source "/Users/arman/.gvm/scripts/gvm"

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
# export GOPATH="$HOME/code/go"
# export PATH="$GOPATH/bin:$PATH"

export GOPRIVATE=github.com/MyBeaconLabs

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

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools


export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export GOPATH="$HOME/code/go"; export GOROOT="$HOME/.go"; export PATH="$GOPATH/bin:$PATH"; # g-install: do NOT edit, see https://github.com/stefanmaric/g

# pnpm
export PNPM_HOME="/Users/arman/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH=$PATH:$HOME/.maestro/bin


# bun completions
[ -s "/Users/arman/.bun/_bun" ] && source "/Users/arman/.bun/_bun"

# WarpStream
export PATH="/Users/arman/.warpstream:$PATH"

