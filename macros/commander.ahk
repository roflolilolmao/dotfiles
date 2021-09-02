#SingleInstance
SetWorkingDir EnvGet("LocalAppData") "/Microsoft/WindowsApps"

if (!WinExist("commander"))
{
    Run("wt --title commander")
}

WinWait("commander")
WinActivate("commander")
SendEvent("a~/command.zsh{Enter}")
