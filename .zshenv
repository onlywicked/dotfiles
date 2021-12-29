eval "$(/opt/homebrew/bin/brew shellenv)"

source "$HOME/.cargo/env"

source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"


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

