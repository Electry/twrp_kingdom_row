# TWRP for Lenovo Vibe Z2 Pro
Device tree for TWRP(only) with proper BoardConfig and .fstab...

### Requirements
- Working Ubuntu/Debian system
- Installed required packages for building
- Java 7 SDK (apt-get install oracle-java7-set-default)
- Lenovo Vibe Z2 Pro Kernel Source code (or already built **zImage**)
- [CyanogenMod 12.1 Source code](https://github.com/CyanogenMod/android/tree/cm-12.1)
- [TWRP Source code](https://github.com/omnirom/android_bootable_recovery/tree/android-5.1)
- Patience...


### Set up
- Sync CyanogenMod source tree
- Sync TWRP source tree to **[cm_tree]/bootable/recovery/**
- Sync device kernel source to **[cm_tree]/kernel/lenovo/msm8974/**
- Copy contents of **twrp_android_device_lenovo_kingdom_row/** to **[cm_tree]/device/lenono/kingdom_row/**
- Copy init.rc from **[cm_tree]/device/lenovo/kingdom_row/recovery/** to **[cm_tree]/bootable/recovery/etc/** (overwrite)
- Set busybox to built as static binary
  - Add/Change these in **busybox-full.config** and **busybox-minimal.config** in **[cm_tree]/external/busybox/**
```
 CONFIG_STATIC=y
 CONFIG_EXTRA_LDFLAGS="-static"
```
- Copy contents of **gui/** to **[cm_tree]/bootable/recovery/gui/** (overwrite)
- To make adb working properly, make sure you change these in **default.prop**
```
ro.adb.secure=0
ro.secure=0
```

### Build
```
./build/envsetup.sh
lunch cm_kingdom_row-userdebug
make clean && make -j<num_of_cores> recoveryimage
```
