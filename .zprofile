if [ -x "$(command -v nvim)" ] ; then
  export EDITOR="nvim"
  export VISUAL="nvim"
else
  export EDITOR="vim"
  export VISUAL="vim"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


if [ -x "$(command -v rg)" ] ; then
  export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git/*' -g '!node_modules/*'"
fi

if [ -f ~/.zsh_aliases ]; then
  source ~/.zsh_aliases
fi

