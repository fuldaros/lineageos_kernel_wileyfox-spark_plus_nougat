#!/bin/bash
# by fuldaros
clear
e="\x1b[";c=$e"39;49;00m";y=$e"93;01m";cy=$e"96;01m";r=$e"1;91m";g=$e"92;01m";m=$e"95;01m";
echo -e "
$cy****************************************************
$cy*           Automatic kernel builder v0.4          *
$cy*                   by fuldaros                    *
$cy****************************************************
$y";     
set -e
author=$(sed -n 2p make.prop);
bh=$(sed -n 8p make.prop);
arch=$(sed -n 4p make.prop);
stamp=$(date +"%d.%m.%Y %H:%M");
stampt=$(date +"%d.%m.%Y-%H:%M");
kernel=paperplane_"$stamp";
logb=logb_"$stamp";
otazip=ota_pp_"$stamp";
device=$(sed -n 14p make.prop);
cpu=$(sed -n 10p make.prop);
cpum=$(sed -n 12p make.prop);
export ARCH="$arch"
export TARGET_ARCH="$arch"
export KBUILD_BUILD_USER="$author"
export KBUILD_BUILD_HOST="$bh"
echo -e "$cy******************************$y"
echo -e "$g   Build info";
echo -e "$y Author: "$author"
 Host: "$bh"
 ARCH: "$arch"
 CPU: "$cpum" "$cpu"
 Device: "$device"
 Build time: "$stamp"";
echo -e "$cy******************************$y"
rm -rf out/paperplane/include/generated/compile.h
pwd > pwd.dat
read pwd < pwd.dat
rm -f pwd.dat
export CROSS_COMPILE="$pwd"/tools/bin/aarch64-linux-gnu-
cd sources/
echo -e "$g Внимание, подождите. Наводим Тополь-M на Соедененные Штаты Америки.
 Терпения, друзья! :3$y"
strt=$(date +"%s")
make -j3 O=../out/paperplane Image.gz-dtb > ../outkernel/"$logb"
clear
echo -e "
$cy****************************************************
$cy*           Automatic kernel builder v0.4          *
$cy*                   by fuldaros                    *
$cy****************************************************
$y";  
echo -e "$g Идет обратый отсчет.$y"
cat ../out/paperplane/arch/arm64/boot/Image.gz-dtb > ../outkernel/"$kernel"
rm -rf ../out/paperplane/arch/arm64/boot/
cd ../
echo -e "$g Пуск. Тополь-М приближается к цели...$y"
rm -f otagen/zImage
cat outkernel/"$kernel" > otagen/zImage
cd otagen
echo "ZIP file is generated automatically by fuldaros script on "$stamp"" > generated.info
cat ../make.prop > author.prop
echo -e "//BUILD TIME" "\n""$stampt" >> author.prop
zip -r ../outzip/"$otazip".zip *
echo -e "$g Поздравляем, Соедененные Штаты Америки стерты с лица земли.
 Подробности в этом архиве. "$otazip".zip$y"
rm -f zImage
rm -f generated.info
rm -f author.prop
end=$(date +"%s")
diff=$(( $end - $strt ))
echo Операция выполнена успешно!
echo -e "$m Полет Тополь-M до цели занял "$diff" секунд!"
