export COLORTERM=truecolor

export XDG_CONFIG_HOME="$HOME/dotfiles"
export XDG_CONFIG_EXTERNAL="$XDG_CONFIG_HOME/external"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"

export EDITOR="nvim"
export VISUAL="$EDITOR"
export MANPAGER="nvim -u NORC --noplugin --cmd 'runtime! plugin/man.vim' +Man!"
export BROWSER="wslview"
export OPENER="$BROWSER"
