# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


LS_COLORS=$LS_COLORS:'di=1;34:ow=1;34:';
export LS_COLORS


export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"

export PATH="/usr/local/go/bin:$PATH"
export GOPATH="$HOME/code/go"
export PATH="$GOPATH/bin:$PATH"

## Add lfcd support
if [ -x "$(command -v lf)" ] ; then
	LFPATH="$GOPATH/src/github.com/gokcehan/lf"
	if [ -f "$LFPATH/etc/lfcd.sh" ] ; then
		. "$LFPATH/etc/lfcd.sh"
	fi
fi

## NPM Config
if [ -x "$(command -v npm)" ] ; then
	export NPM_CONFIG_PREFIX="$HOME/.npm-global"
	export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"
fi

if [ -x "$(command -v rg)" ] ; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs -g !.git/*'
fi

