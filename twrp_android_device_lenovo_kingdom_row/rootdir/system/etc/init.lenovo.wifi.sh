#!/system/bin/sh

# rm wifi sockets
rm -rf /data/misc/wifi/sockets

#check if orignal files exist
if [ ! -e /system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv_ftm.bin ]; then 
    echo "WCNSS_qcom_wlan_nv_ftm.bin does not exist"
    exit 0
fi
if [ ! -e /system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv_enhanced.bin ]; then 
    echo "WCNSS_qcom_wlan_nv_enhanced.bin does not exist"
    exit 0
fi

is_testmode=$(cat /proc/cmdline|grep "testmode")
if [ -e /persist/.check_goldenbin ]; then
    goldenbin=$(cat /persist/.check_goldenbin)
else
    goldenbin=""
fi

if [ "${is_testmode}" != "" ]; then
    if [ "$goldenbin" != "0" ]; then
	cat /system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv_ftm.bin > /persist/WCNSS_qcom_wlan_nv.bin
        echo 0 > /persist/.check_goldenbin
    fi
else
    if [ "$goldenbin" != "1" ]; then
	cat /system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv_enhanced.bin > /persist/WCNSS_qcom_wlan_nv.bin
        echo 1 > /persist/.check_goldenbin
    fi
fi


# Add preset APs for CMCC use
if [ ! -e /data/misc/wifi/wpa_supplicant.conf ]; then
	cat /system/etc/wifi/wpa_supplicant.conf > /data/misc/wifi/wpa_supplicant.conf
	chown system:wifi /data/misc/wifi/wpa_supplicant.conf
	chmod 660 /data/misc/wifi/wpa_supplicant.conf

	echo '\n\n'
	echo 'p2p_disable=1\n\n'  		>>/data/misc/wifi/wpa_supplicant.conf
#	echo 'network={'  			>>/data/misc/wifi/wpa_supplicant.conf
#	echo '  ssid="CMCC-AUTO"'  		>>/data/misc/wifi/wpa_supplicant.conf
#	echo '  key_mgmt=WPA-EAP  IEEE8021X'  	>>/data/misc/wifi/wpa_supplicant.conf
#	echo '  eap=PEAP'  			>>/data/misc/wifi/wpa_supplicant.conf
#	echo '  priority=2\n}\n'  		>>/data/misc/wifi/wpa_supplicant.conf
#
#	echo 'network={'  			>>/data/misc/wifi/wpa_supplicant.conf
#	echo '  ssid="CMCC"'  			>>/data/misc/wifi/wpa_supplicant.conf
#	echo '  key_mgmt=NONE'  		>>/data/misc/wifi/wpa_supplicant.conf
#	echo '  priority=1\n}\n'  		>>/data/misc/wifi/wpa_supplicant.conf
fi
