source build_function.sh

## Check adb.
## If you have sdk, set adb command line
#ADB=/your/adb/path
ADB=`which adb`

# boot.img binary
BOOTIMG=$1
DEVPATH=/dev/block/mmcblk0p9

if [ "$BOOTIMG" == "" ]; then
	Error "Usage : build_install.sh <boot.img path>"
	ShowInfo "ex)" "build_install.sh boot.img"
	exit
fi

ShowInfo "ADB:" $ADB
if [ ! -e $ADB ] || [ "$ADB" == "" ]; then
	Error "adb Not Found!!!"
	exit
fi

ShowInfo "BOOTIMG:" $BOOTIMG
if [ ! -e $BOOTIMG ]; then
	Error "boot.img Not Found!!!"
	exit
fi

ShowNoty "Wait for device"
$ADB wait-for-device

ShowNoty "Push boot.img"
$ADB push $BOOTIMG /sdcard/boot.img

ShowNoty "Install..."
$ADB shell su -c dd if=/sdcard/boot.img of=$DEVPATH
ShowNoty "Reboot!"
$ADB reboot

ShowNoty "Finish Install"
