#!/system/bin/sh
export PATH=/system/bin:$PATH

# usage: encfs_wrapper.sh /path/to/encrypted/folder /path/to/mountpoint property_name

setprop $3 starting
/system/bin/encfs $1 $2 --extpass="/system/etc/getpassword.sh"
if [ $? -eq 0 ]; then
    setprop $3 running
exit
fi
setprop $3 stopped
