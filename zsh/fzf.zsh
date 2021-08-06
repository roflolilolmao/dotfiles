export FZF_COMPLETION_TRIGGER='8'
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND='fd'
export FZF_DEFAULT_OPTS='--height 40% --info=inline --border'
export FZF_COMPLETION_OPTS='--height 40% --info=inline --border --layout=default'

_fzf_compgen_path() {
    fd --type f --follow . "$1"
}

_fzf_compgen_dir() {
    fd --type d --follow . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'fd --type f --full-path -- {} | as-tree | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}
