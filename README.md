# Dotfiles

## Fonts

[Nerd fonts](https://www.nerdfonts.com/font-downloads).

## Windows

```powershell
Set-ExecutionPolicy RemoteSigned -Scope User

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install -y git.install --params "/GitOnlyOnPath /WindowsTerminal /NoGuiHereIntegration /NoCredentialManager"

choco install -y mingw
choco install -y rust
choco install -y nodejs -y
choco install -y bat -y
choco install -y delta -y
choco install -y streamdeck

cargo install ripgrep
cargo install fd-find
cargo install lsd

git clone --recursive git@github.com:roflolilolmao/dotfiles

New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim" -Target "$Home\dotfiles\nvim"
New-Item `
    -ItemType SymbolicLink `
    -Force `
    -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json" `
    -Target ./terminal/settings.json

Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser

New-Item `
    -ItemType SymbolicLink `
    -Force `
    -Path "$PROFILE" `
    -Target ./powershell/profile.ps1
```

### Environment Variables

| Key | Value |
| -- | -- |
| `EDITOR` | `nvim` |
| `XDG_CONFIG_HOME` | `%USERPROFILE%\dotfiles` |

Add to path:

- `%USERPROFILE%\.cargo\bin`

## WSL Manjaro

[Manjaro for WSL](https://github.com/sileshn/ManjaroWSL).

Extract somewhere in ~.
Rename to `q.exe`, follow the instructions.

Then, in powershell:

```sh
wsl -d q

cd ~

sudo pacman -Syyu
sudo pacman-mirrors --fasttrack && sudo pacman -Syyu

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -S zsh

cd ~
git clone https://github.com/roflolilolmao/dotfiles.git
cd dotfiles
git remote set-url origin git@github.com:roflolilolmao/dotfiles

ln -s $(pwd)/zsh/.zshenv ~/.zshenv
sudo ln -sf $(pwd)/wsl.conf /etc/wsl.conf
sudo ln -s /mnt/c/Users/$UserProfile/.ssh ~/.ssh  # TODO: wslvar?
chsh -s /bin/zsh q

exit

.\q.exe config --append-path false
.\q.exe config --default-term wt

# We terminate the instance to reboot with the settings in `wsl.conf`.
wsl --terminate q
wsl -d q

cd ~/dotfiles
git submodule update --init

exit
wsl -d q

# Don't add to path
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cargo install ripgrep
cargo install fd-find
cargo install lsd
cargo install --locked bat
cargo install git-delta

cd ~/dotfiles

./zsh/plugins/fzf/install --bin

yay -S man unzip neovim python-pynvim nodejs npm

python -m ensurepip
python -m pip install --upgrade pip
python -m pip install pipx pipenv rich

# Clipboard provider for nvim: https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
mv /tmp/win32yank.exe ~/.local/bin

# TODO: I wrote a script that should be able to do that
curl -L -o efm.tar.gz https://github.com/mattn/efm-langserver/releases/download/v0.0.36/efm-langserver_v0.0.36_linux_amd64.tar.gz
tar -xzf efm.tar.gz
mv efm-langserver_v0.0.36_linux_amd64/efm-langserver ~/.local/bin
rm efm.tar.gz
rm -r efm-langserver_v0.0.36_linux_amd64

# TODO: neuron

sudo npm i -g markdownlint-cli
sudo npm i -g write-good

pipx install 'python-lsp-server[all]'

pipx install black
pipx install isort

cd ~
rm .bash*
```

## Macros

### AutoHotKey

AHKv2 is in beta and has no standard installer. For now,
[download](https://www.autohotkey.com/v2/) it
and set it as default program for .ahk files. Download the
AHK zip and put the `compile` folder next to the v2 exe.

Import the streamdeck profile.

## Miscellany

[MKLC](https://www.microsoft.com/en-us/download/details.aspx?id=102134).

[Remove Windows path from WSL path](https://stackoverflow.com/a/63195953/12474293).

[If the fonts keep disappearing after a system
restart](https://www.fonts.com/support/faq/fonts-disappear-on-restart).

Some [article about
yay](https://averagelinuxuser.com/which-aur-helper-yay/#how-to-use-yay).

### Fix Diffs in Submodule on Windows

```powershell
git submodule foreach --recursive git config core.filemode false
git submodule deinit -f zsh/plugins/zsh-bd zsh/plugins/zsh-syntax-highlighting
```

### Update Submodules

```zsh
git submodule update --remote --merge
```

### Terminals Input

Terminals handle input in a very technical debt fashion. Nvim in the Windows
Terminal would not receive some inputs because of how all terminals work. For
example, `<C-CR>` would be received as `<CR>`. After hours of research and
experiment, I have found the following escape sequences that can be added in
the terminal settings to send the input regardless of the standards:

| output | input |
| -- | -- |
| \<C-x> | \u001b[27;5;X~ |
| \<S-x> | \u001b[27;2;X~ |

Where `x` is the wanted char and `X` its ascii code.

I have no clue what's really going on or what the escape sequence would look
like for something like `<C-S-Tab>`.

Some resources:

- https://www.man7.org/linux/man-pages/man5/terminfo.5.html
- https://en.wikipedia.org/wiki/Terminfo
- https://github.com/microsoft/terminal/issues/8931
- https://github.com/microsoft/terminal/pull/8330
- https://unix.stackexchange.com/questions/238406/why-does-shift-tab-result-in-escape-in-the-terminal
- https://www.asciitable.com/
- https://support.microfocus.com/kb/doc.php?id=7021621
- https://stackoverflow.com/questions/7767702/what-is-terminal-escape-sequence-for-ctrl-arrow-left-right-in-term-linu

## TODO

- Automated install. I.e. run the scripts in this file and install all the shit
  I use daily with choco.
- Neovim:
  - lsp:
    - lsputil can be replaced by telescope
    - add server for md
    - look up alternatives for python
  - study ideas:
    - Mapping/functions:
      - :m, :d, :y, :t, :c, :i, :a normal mode shortcuts?
      - add matching lines to qf:
        :g/mypattern/caddexpr expand("%") . ":" . line(".") .  ":" . getline(".")
    - Syntax:
      - Todo highlight group case insensitive
