$dotfiles = "$Home\dotfiles"

New-Item `
    -ItemType SymbolicLink `
    -Path "$env:LOCALAPPDATA\nvim" `
    -Target "$dotfiles\nvim"

New-Item `
    -ItemType SymbolicLink `
    -Force `
    -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json" `
    -Target "$dotfiles\terminal\settings.json"

Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser

New-Item `
    -ItemType SymbolicLink `
    -Force `
    -Path "$PROFILE" `
    -Target "$dotfiles\powershell\profile.ps1"
