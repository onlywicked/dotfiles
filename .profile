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

if [ -x "$HOME/.local/bin/exa" ] ; then
	alias ll='exa -alF'
	alias la='exa'
	alias ls='exa'
	alias l='exa -F'
fi

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"

if [ -x "$(command -v rg)" ] ; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs -g !.git/*'
fi

alias gs='git status'

