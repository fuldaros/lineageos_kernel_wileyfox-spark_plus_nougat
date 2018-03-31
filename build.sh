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
stamp=$(date +"%d.%m.%Y %H:%M");
kernel=paperplane_"$stamp";
logb=logb_"$stamp";
otazip=ota_pp_"$stamp";
export ARCH=arm64
export TARGET_ARCH=arm64
export KBUILD_BUILD_USER=fuldaros
export KBUILD_BUILD_HOST=hhost#1
rm -rf out/paperplane/include/generated/compile.h
pwd > pwd.dat
read pwd < pwd.dat
rm -f pwd.dat
export CROSS_COMPILE="$pwd"/tools/bin/aarch64-linux-gnu-
cd sources/
echo -e "$g Внимание, подождите. Наводим Тополь-M на Соедененные Штаты Америки. Терпения, друзья! :3$y"
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
echo "build on "$stamp"" > time
zip -r ../outzip/"$otazip".zip *
echo -e "$g Поздравляем, Соедененные Штаты Америки стерты с лица земли.
 Подробности в этом архиве. "$otazip"$y"
rm -f zImage
rm -f generated.info
rm -f time
end=$(date +"%s")
diff=$(( $end - $strt ))
echo Операция выполнена успешно!
echo -e "$m Полет Тополь-M до цели занял "$diff" секунд!"
