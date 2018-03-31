# fuldaros @ 4pda
## OTA setup
# begin properties
properties() {
kernel.string=Custom kernel @ 4pda
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=porridge
device.name2=spark
device.name3=alps6735
device.name4=
device.name5=
} # end properties
# shell variables
block=/dev/block/platform/mtk-msdc.0/11230000.msdc0/by-name/boot
is_slot_device=0;
## OTA methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/otapack/tools/fcore.sh;
## boot install
split_boot;
flash_boot;
## end install
