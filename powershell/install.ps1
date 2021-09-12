$uri = "https://github.com/sileshn/ManjaroWSL/releases/download/20210830/ManjaroWSL.zip"
$zip = "$Home/manjaro.zip"
$destination = "$Home/manjaro-wsl"

# .net thingy
(New-Object System.Net.WebClient).DownloadFile($url, $destination)
Expand-Archive $zip -DestinationPath $destination
rm $zip

cd $destination

$user = "q"
$name = "salut"
$cmd = ".\$name.exe"

mv .\"Manjaro.exe" "$name.exe"

& $cmd
& $cmd run passwd
& $cmd run useradd -m -G wheel -s /bin/bash $user
& $cmd run passwd $user

& $cmd config --append-path false
& $cmd config --default-user $user
& $cmd config --default-term wt

wsl -d $name -- sh -c '
cd ~
git clone --recurse https://github.com/roflolilolmao/dotfiles
cd dotfiles
make first_install
'
