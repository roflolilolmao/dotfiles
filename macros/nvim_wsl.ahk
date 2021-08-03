#SingleInstance
SetWorkingDir EnvGet("LocalAppData") "/Microsoft/WindowsApps"

Run("wt --title nvim-wsl")
WinWait("nvim-wsl")
WinMove(0, 0, 2560, 1440)
WinMaximize

SendEvent("anvim{Enter}")
