#
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

BOARD_VENDOR := lenovo

# Include path
TARGET_SPECIFIC_HEADER_PATH := device/lenovo/kingdom_row/include

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8974
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Platform
TARGET_BOARD_PLATFORM := msm8974
TARGET_BOARD_PLATFORM_GPU := qcom-adreno330

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := krait
#TARGET_USE_QCOM_BIONIC_OPTIMIZATION := true

# Assertions
TARGET_BOARD_INFO_FILE ?= device/lenovo/kingdom_row/board-info.txt

# Kernel
BOARD_CUSTOM_BOOTIMG_MK := device/lenovo/kingdom_row/mkbootimg.mk
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_SEPARATED_DT := true
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x01000000 --tags_offset 0x00000100
TARGET_KERNEL_CONFIG := dragonvibe_defconfig
TARGET_KERNEL_SOURCE := kernel/lenovo/msm8974
TARGET_KERNEL_ARCH := arm
BOARD_KERNEL_CMDLINE := console=tty60,115200,n8 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x3b7 ehci-hcd.park=3 vmalloc=480M androidboot.bootdevice=msm_sdcc.1 androidboot.selinux=permissive

# Enable DIAG on debug builds
ifneq ($(TARGET_BUILD_VARIANT),user)
TARGET_KERNEL_ADDITIONAL_CONFIG:= cyanogenmod_debug_config
endif

# Flags
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD -DUSE_RIL_VERSION_10
COMMON_GLOBAL_CPPFLAGS += -DNO_SECURE_DISCARD -DUSE_RIL_VERSION_10

# QCOM hardware
BOARD_USES_QCOM_HARDWARE := true

# Audio
BOARD_USES_ALSA_AUDIO := true
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true
AUDIO_FEATURE_ENABLED_HWDEP_CAL := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
QCOM_BT_USE_SMD_TTY := true
BLUETOOTH_HCI_USE_MCT := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/lenovo/kingdom_row/bluetooth

# Charger
BOARD_CHARGER_DISABLE_INIT_BLANK := true

# CM Hardware
BOARD_HARDWARE_CLASS += device/lenovo/kingdom_row/cmhw

# MSM Init
TARGET_INIT_VENDOR_LIB := libinit_msm_lenovo

# QCOM Power
TARGET_POWERHAL_VARIANT := qcom

# Releasetools
TARGET_RECOVERY_UPDATER_LIBS := librecovery_updater_lenovo
TARGET_RELEASETOOLS_EXTENSIONS := device/lenovo/kingdom_row


# Graphics
BOARD_EGL_CFG := device/lenovo/kingdom_row/configs/egl.cfg
USE_OPENGL_RENDERER := true
TARGET_CONTINUOUS_SPLASH_ENABLED := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_ION := true
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so
HAVE_ADRENO_SOURCE:= false
VSYNC_EVENT_PHASE_OFFSET_NS := 7500000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 5000000

# Shader cache config options
# Maximum size of the  GLES Shaders that can be cached for reuse.
# Increase the size if shaders of size greater than 12KB are used.
MAX_EGL_CACHE_KEY_SIZE := 12*1024

# Maximum GLES shader cache size for each app to store the compiled shader
# binaries. Decrease the size if RAM or Flash Storage size is a limitation
# of the device.
MAX_EGL_CACHE_SIZE := 2048*1024

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Wifi
BOARD_HAS_QCOM_WLAN              := true
BOARD_HAS_QCOM_WLAN_SDK          := true
BOARD_WLAN_DEVICE                := qcwcn
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_qcwcn
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_qcwcn
WIFI_DRIVER_FW_PATH_STA          := "sta"
WIFI_DRIVER_FW_PATH_AP           := "ap"
TARGET_USES_WCNSS_CTRL           := true
TARGET_USES_QCOM_WCNSS_QMI       := true
TARGET_USES_WCNSS_MAC_ADDR_REV   := true

# Camera
USE_DEVICE_SPECIFIC_CAMERA := true
COMMON_GLOBAL_CFLAGS += -DOPPO_CAMERA_HARDWARE

# Filesystem
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_BOOTIMAGE_PARTITION_SIZE          := 20971520
BOARD_RECOVERYIMAGE_PARTITION_SIZE      := 20971520
BOARD_PERSISTIMAGE_PARTITION_SIZE       := 33554432
BOARD_SYSTEMIMAGE_PARTITION_SIZE        := 2147483648
BOARD_CACHEIMAGE_PARTITION_SIZE         := 131072000
BOARD_USERDATAIMAGE_PARTITION_SIZE      := 27439087000
BOARD_USERDATAEXTRAIMAGE_PARTITION_SIZE := 29957396480
BOARD_USERDATAEXTRAIMAGE_PARTITION_NAME := 64G
BOARD_FLASH_BLOCK_SIZE                  := 131072

# No old RPC for prop
TARGET_NO_RPC := true

# GPS HAL lives here
TARGET_GPS_HAL_PATH := device/lenovo/kingdom_row/gps
TARGET_PROVIDES_GPS_LOC_API := true

# QCRIL
TARGET_RIL_VARIANT := caf

# Use HW crypto for ODE
TARGET_HW_DISK_ENCRYPTION := true

# Added to indicate that protobuf-c is supported in this build
PROTOBUF_SUPPORTED := true

# ANT+
BOARD_ANT_WIRELESS_DEVICE := "vfs-prerelease"

# Include an expanded selection of fonts
EXTENDED_FONT_FOOTPRINT := true

# Enable transparent compression in the build
# TARGET_TRANSPARENT_COMPRESSION_METHOD := lz4

# Enable dexpreopt to speed boot time
ifeq ($(HOST_OS),linux)
  ifeq ($(call match-word-in-list,$(TARGET_BUILD_VARIANT),user),true)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
    endif
  endif
endif

# Recovery
TARGET_RECOVERY_FSTAB := device/lenovo/kingdom_row/rootdir/system/etc/recovery.fstab
PRODUCT_COPY_FILES += device/lenovo/kingdom_row/rootdir/system/etc/recovery.fstab:recovery/root/etc/twrp.fstab
DEVICE_RESOLUTION := 1440x2560
BOARD_HAS_NO_REAL_SDCARD := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TW_INCLUDE_FB2PNG := true
TW_MAX_BRIGHTNESS := 255
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness

TARGET_OTA_ASSERT_DEVICE := kingdom_row,K920

TARGET_INIT_VENDOR_LIB := libinit_msm_lenovo

TARGET_WCNSS_MAC_PREFIX := e8bba8

# Workaround for factory issue
BOARD_VOLD_CRYPTFS_MIGRATE := true
BOARD_NFC_CHIPSET := nfc-nci

AUDIO_FEATURE_LOW_LATENCY_PRIMARY := true
AUDIO_FEATURE_ENABLED_LOW_LATENCY_CAPTURE := true

# inherit from the proprietary version
ifneq ($(QCPATH),)
-include $(QCPATH)/common/msm8974/BoardConfigVendor.mk

ifeq ($(BOARD_USES_QCNE),true)
TARGET_LDPRELOAD := libNimsWrap.so
endif
endif

# SELinux policies
# qcom sepolicy
include device/qcom/sepolicy/sepolicy.mk

BOARD_SEPOLICY_DIRS += \
        device/lenovo/kingdom_row/sepolicy

-include vendor/lenovo/kingdom_row/BoardConfigVendor.mk