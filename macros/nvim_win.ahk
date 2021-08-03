#SingleInstance
SetWorkingDir EnvGet("LocalAppData") "/Microsoft/WindowsApps"

Run("wt --title nvim-win -p Windows -d " EnvGet("UserProfile") "/dotfiles")
WinWait("nvim-win")
WinMove(0, 0, 2560, 1440)
WinMaximize

Send("nvim{Enter}")
