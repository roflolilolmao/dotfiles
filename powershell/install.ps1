$uri = "https://github.com/sileshn/ManjaroWSL/releases/download/20210830/ManjaroWSL.zip"
$zip = "$Home/manjaro.zip"
$destination = "$Home/manjaro-wsl"

Invoke-WebRequest -Uri $uri -OutFile $zip
Expand-Archive $zip -DestinationPath $destination
rm $zip

cd $destination

$user = q
$name = salut

mv .\Manjaro.exe $name.exe

.\$name.exe
.\$name.exe run passwd
.\$name.exe run useradd -m -G wheel -s /bin/bash $user
.\$name.exe run passwd $user

.\$name.exe config --append-path false
.\$name.exe config --default-user $user
.\$name.exe config --default-term wt
