export KEYTIMEOUT=1

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^V' edit-command-line

# https://github.com/softmoth/zsh-vim-mode
VIM_MODE_INITIAL_KEYMAP=vicmd

MODE_CURSOR_VIINS="blinking bar"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS"
MODE_CURSOR_VICMD="block"
MODE_CURSOR_SEARCH="steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL"

source "$ZDOTDIR/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh"
