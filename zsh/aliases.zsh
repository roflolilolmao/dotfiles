alias cc='cargo clippy --all-targets --all-features -- -D warnings'
alias ct='cargo test'
alias cf='cargo fmt --all --verbose -- --check --verbose'

alias ggg='watch -c git log --color --graph --exclude=refs/stash --all --oneline --decorate'
alias grc='git rebase --continue'
alias gg='git log --color --graph --all --oneline --decorate'
alias gd='git show'

alias l='lsd'
alias ls='lsd *'
alias ll='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'

alias b='cd -1'

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

alias v="$EDITOR"
