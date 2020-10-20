## Set color for diff
alias diff="diff --color=auto"

## For better colors
if [ -x "$(command -v exa)" ] ; then
	alias ll="exa -alF"
	alias la="exa"
	alias ls="exa"
	alias l="exa -F"
fi

## Prompt before overwriting files
alias mv="mv -i"
alias rm="rm -i"


# git aliases
alias gs='git status'
alias gl='git log --all --decorate --oneline --graph'

# fd
alias fd='fdfind'


## For WSL
# docker
# if [ -x "$(command -v docker.exe)" ] ; then
#   alias docker="docker.exe"
#   alias docker-compose="docker-compose.exe"
# fi

# X410 Server
# if [ -x "$(command -v x410.exe)" ] ; then
# 	export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
# fi
# 
# wslview to open windows registered file handler
## e.g. 
## "open https://www.google.com opens" the url in default windows browser
# if [ -x "$(command -v wslview)" ]; then
# 	alias open=wslview
# fi

