GIT_LOG_ALL='git log --color --graph --oneline --decorate --branches --remotes'
alias ggg="watch -c $GIT_LOG_ALL"
alias gg=$GIT_LOG_ALL

alias gd='git show'
alias gf='git fetch --prune --all'
alias gs='git status'

alias l='lsd'
alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -a --ignore-config'
alias lla='lsd -la --ignore-config'
alias lt='lsd --tree'

alias b='cd -1'

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

alias v="$EDITOR"
