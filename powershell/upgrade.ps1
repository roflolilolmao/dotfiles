choco upgrade microsoft-windows-terminal
choco upgrade `
    -y git.install `
    --params "/GitOnlyOnPath /WindowsTerminal /NoGuiHereIntegration /NoCredentialManager"

choco upgrade -y brave
