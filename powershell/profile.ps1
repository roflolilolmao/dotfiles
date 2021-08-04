Import-Module posh-git
Import-Module oh-my-posh

Set-PoshPrompt -Theme ~/dotfiles/powershell/theme.json

Set-PSReadLineOption -BellStyle None -EditMode Emacs

Enable-PoshTransientPrompt
