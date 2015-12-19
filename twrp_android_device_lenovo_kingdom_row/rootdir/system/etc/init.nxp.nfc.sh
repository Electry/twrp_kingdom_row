#!/system/bin/sh
# insmod nfc module
if [ -e /system/lib/modules/pn547.ko ]; then
    insmod /system/lib/modules/pn547.ko
fi
