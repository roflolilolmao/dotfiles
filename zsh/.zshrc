# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export LANG=en_US.UTF-8

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt CORRECT

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

# zsh completion setup
autoload -Uz compinit; compinit
_comp_options+=(globdots) # With hidden files
source "$ZDOTDIR/completion.zsh"

source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

export COLORTERM=truecolor
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export MANPAGER="nvim --cmd 'runtime! plugin/man.vim' +Man!"

export BROWSER="/mnt/c/Users/kelst/AppData/Local/BraveSoftware/Brave-Browser/Application/brave.exe"
export OPENER="$BROWSER"

source "$ZDOTDIR/vim.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/plugins/zsh-bd/bd.zsh"

# Handling SSH keys.
eval $(ssh-agent -s) > /dev/null
ssh-add ~/.ssh/id_ed25519 2> /dev/null

# Handling GPG keys.
export GPG_TTY=$(tty)

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
source $ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

# Setup fzf
[[ $- == *i* ]] && source "$ZDOTDIR/plugins/fzf/shell/completion.zsh" 2> /dev/null
source "$ZDOTDIR/plugins/fzf/shell/key-bindings.zsh"
source "$ZDOTDIR/fzf.zsh"

vim-mode-bindkey viins vicmd -- fzf-history-widget '^R'
vim-mode-bindkey viins vicmd -- fzf-history-widget '^S'
