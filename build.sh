#!/bin/bash
# by fuldaros
ver=$(sed -n 2p tools/akb.prop);
clear
e="\x1b[";c=$e"39;49;00m";y=$e"93;01m";cy=$e"96;01m";r=$e"1;91m";g=$e"92;01m";m=$e"95;01m";
echo -e "
$cy****************************************************
$cy*           Automatic kernel builder v"$ver"          *
$cy*                   by fuldaros                    *
$cy****************************************************
$r!!! Пожалуйста, уважайте чужой труд и не меняйте имя автора на свое <3 !!! $y";     
set -e
usr=$(sed -n 2p make.prop);
bh=$(sed -n 8p make.prop);
arch=$(sed -n 4p make.prop);
stamp=$(date +"%Y.%m.%d %H:%M");
stampt=$(date +"%d.%m.%Y-%H:%M");
logb=logb_"$stamp";
otazip=ota_akb_"$stamp";
device=$(sed -n 12p make.prop);
cpu=$(sed -n 10p make.prop);
imgt=$(sed -n 14p make.prop);
loc=$(sed -n 18p make.prop);
gcc=$(sed -n 16p make.prop);
sha="0"
if [[ "$sha" != "1" ]]
then
type="USER";
else
type="OFFICIAL";
fi
kernel="$imgt"_akb_"$stamp";
export ARCH="$arch"
export TARGET_ARCH="$arch"
export KBUILD_BUILD_USER="$author"
export KBUILD_BUILD_HOST="$bh"
echo -e "$cy******************************$y"
echo -e "$g   Build info";
echo -e "$y User: "$usr"
 Host: "$bh"
 ARCH: "$arch"
 CPU: "$cpu"
 Device: "$device"
 Build time: "$stamp"
 Kernel location: "$loc"
 Build type: "$type"";
echo -e "$cy******************************$y"
rm -rf out/akb_"$device"/include/generated/compile.h
pwd > pwd.dat
read pwd < pwd.dat
rm -f pwd.dat
export CROSS_COMPILE="$pwd"/tools/"$gcc"
cd sources/
echo -e "$g Внимание, подождите. Наводим Тополь-M на Соедененные Штаты Америки.
 Терпения, друзья! :3$y"
strt=$(date +"%s")
make -j3 O=../out/akb_"$device" "$imgt" > ../outkernel/"$logb"
clear
echo -e "
$cy****************************************************
$cy*           Automatic kernel builder v"$ver"          *
$cy*                   by fuldaros                    *
$cy****************************************************
$y";  
echo -e "$g Идет обратый отсчет.$y"
cat ../out/akb_"$device"/arch/"$arch"/boot/"$imgt" > ../outkernel/"$kernel"
rm -rf ../out/akb_"$device"/arch/"$arch"/boot/
cd ../
echo -e "$g Пуск. Тополь-М приближается к цели...$y"
rm -f otagen/zImage
cat outkernel/"$kernel" > otagen/zImage
cd otagen
echo "ZIP file is generated automatically by fuldaros script on "$stamp"" > generated.info
cat ../make.prop > author.prop
echo -e "//BUILD TIME" "\n""$stampt" >> author.prop
echo -e "// Automatic kernel builder ver. (DONT EDIT)" >> author.prop
echo -e "$ver" >> author.prop
echo -e "//BUILD TYPE" "\n""$type" >> author.prop
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
####### script v08 (beta)
