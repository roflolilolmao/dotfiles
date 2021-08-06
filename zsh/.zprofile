# set PATH so it includes user's private bins if they exist
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [[ ! "$PATH" == */$ZDOTDIR/plugins/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$ZDOTDIR/plugins/fzf/bin"
fi

export PATH="$HOME/.cargo/bin:$PATH"
