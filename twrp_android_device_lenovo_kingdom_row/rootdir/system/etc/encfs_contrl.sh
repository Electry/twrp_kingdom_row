#!/system/bin/sh
#encfs_contrl.sh startup service_data_tag1 service_storage_tag2
#encfs_contrl.sh mount /path/to/encrypted/folder /path/to/mountpoint property_name
#encfs_contrl.sh cleanup /path/to/encrypted/folder /path/to/mountpoint serv_tag
# we don't want to remove the dir secure2 and secure_storage, just clean up all the contents

LOG_TAG="[encfs $1 $3]"
LOG_NAME="${0}:"
SECURE_DATA="/data/user/10"
SECURE_STORAGE="/data/media/10"
NATIVE_SECURE_DATA="/data/secure2"
NATIVE_SECURE_STORAGE="/data/secure_storage"
SLEEP_COUNT=0
export PATH=/system/bin:$PATH


logi ()
{
  /system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}

echo $LOG_TAG

if [ "$1" == "cleanup" ]; then
	/system/bin/stop $4
	/system/bin/fusermount -u $3
	if [ "$4" == "encfs-storage" ]; then
		/system/bin/rm -rf /mnt/shell/emulated/10
	fi
	/system/bin/rm -rf $3
	/system/bin/rm -rf $2/*
	/system/bin/sync
	logi "$4 cleanup encfs directory"
fi

if [ "$1" == "start_data" ]; then
	if [ -d $SECURE_DATA -a "$(cat /proc/mounts | grep fuse | grep $SECURE_DATA)" == "" ]; then
		logi "start data encfs service"
		/system/bin/rm -rf $SECURE_DATA/* $SECURE_DATA/.*
		/system/bin/encfs --public -f $NATIVE_SECURE_DATA $SECURE_DATA &
		setprop service.encfs-data.pid $!
		while [ "$(cat /proc/mounts | grep fuse | grep $SECURE_DATA)" == "" ]
		do
			logi "encfs-data is NOT mounted"
			SLEEP_COUNT=$(($SLEEP_COUNT+1))
			sleep 1
		done
		setprop service.encfs-data.check "$SLEEP_COUNT second success"
		logi "data encfs service started"
	fi
fi

if [ "$1" == "start_storage" ]; then
	if [ -d $SECURE_STORAGE -a "$(cat /proc/mounts | grep fuse | grep $SECURE_STORAGE)" == "" ]; then
		logi "start storage encfs service"
		/system/bin/rm -rf $SECURE_STORAGE/* $SECURE_STORAGE/.*
		/system/bin/encfs --public -f $NATIVE_SECURE_STORAGE $SECURE_STORAGE &
		setprop service.encfs-storage.pid $!
		while [ "$(cat /proc/mounts | grep fuse | grep $SECURE_STORAGE)" == "" ]
		do
			logi "encfs-storage is NOT mounted"
			SLEEP_COUNT=$(($SLEEP_COUNT+1))
			sleep 1
		done
		setprop service.encfs-storage.check "$SLEEP_COUNT second success"
		logi "storage encfs service started"
	fi
fi

if [ "$1" == "mount" ]; then
	logi "encfs service starts up"
	setprop $4 starting
	while [ "$(cat /proc/mounts | grep fuse | grep $3)" == "" -a "$SLEEP_COUNT" != "5" ]
	do
		SLEEP_COUNT=$(($SLEEP_COUNT+1))
		logi "$3 is NOT mounted"
		sleep 1
	done
	if [ "$(cat /proc/mounts | grep fuse | grep $3)" != "" ]; then
		logi "$3 is mounted successfully"
		setprop $4 running
	else
		setprop $4 stopped
	fi
fi

if [ "$1" == "bootmount" ]; then
	if [ -d $SECURE_DATA ]; then
		/system/bin/rm -rf $SECURE_DATA/* $SECURE_DATA/.*
		/system/bin/encfs --public -f $NATIVE_SECURE_DATA $SECURE_DATA &
		# setprop service.encfs-data.pid $!
		logi "encfs service check data"
		while [ "$(cat /proc/mounts | grep fuse | grep $SECURE_DATA)" == "" -a "$SLEEP_COUNT" != "10" ]
		do
			SLEEP_COUNT=$(($SLEEP_COUNT+1))
			logi "$SECURE_DATA is NOT mounted"
			sleep 1
		done
		if [ "$(cat /proc/mounts | grep fuse | grep $SECURE_DATA)" != "" ]; then
			logi "$SECURE_DATA is mounted successfully"
			# setprop service.encfs-data.bootcheck "$SLEEP_COUNT second success($(date)"
		else
			# setprop service.encfs-data.bootcheck "$SLEEP_COUNT second fail($(date)"
		fi
	fi

	SLEEP_COUNT=0
	if [ -d $SECURE_STORAGE ]; then
		/system/bin/rm -rf $SECURE_STORAGE/* $SECURE_STORAGE/.*
		/system/bin/encfs --public -f $NATIVE_SECURE_STORAGE $SECURE_STORAGE &
		# setprop service.encfs-storage.pid $!
		logi "encfs service check storage"
		while [ "$(cat /proc/mounts | grep fuse | grep $SECURE_STORAGE)" == "" -a "$SLEEP_COUNT" != "10" ]
		do
			SLEEP_COUNT=$(($SLEEP_COUNT+1))
			logi "$SECURE_STORAGE is NOT mounted"
			sleep 1
		done
		if [ "$(cat /proc/mounts | grep fuse | grep $SECURE_STORAGE)" != "" ]; then
			logi "$SECURE_STORAGE is mounted successfully"
			# setprop service.encfs-storage.bootcheck "$SLEEP_COUNT second success($(date))"
		else
			# setprop service.encfs-storage.bootcheck "$SLEEP_COUNT second fail($(date)"
		fi
	fi
fi
