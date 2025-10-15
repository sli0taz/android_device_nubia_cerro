#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 The TWRP Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# (1) 设备路径
DEVICE_PATH := device/nubia/cerro

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo385

ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Bootloader
BOARD_VENDOR := nubia
TARGET_SOC := pineapple
TARGET_BOOTLOADER_BOARD_NAME := pineapple
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true
TARGET_USES_UEFI := true

# Display
TARGET_SCREEN_DENSITY := 450
TARGET_USES_VULKAN := true

# Kernel
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := video=vfb:640x400,bpp=32,memsize=3072000 printk.devkmsg=on firmware_class.path=/vendor/firmw
are_mnt/image bootconfig androidboot.hardware=qcom androidboot.memcg=1 androidboot.usbcontroller=a600000.dwc3 andro
idboot.load_modules_parallel=false androidboot.hypervisor.protected_vm.supported=true loop.max_part=7
BOARD_KERNEL_PAGESIZE := 4096
BOARD_HASH_TYPE := sha1
BOARD_RAMDISK_OFFSET := 0x02000000
BOARD_KERNEL_TAGS_OFFSET := 0x01e00000
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_RAMDISK_USE_LZ4 := true

# Prebuilt Kernel
# Prebuilt Kernel
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)

# (1) 指定内核路径 (这个文件包含了 dtb)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image

# (2) 告诉编译系统，DTB 已经包含在内核镜像里了
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

# (3) 指定独立的 DTBO 镜像路径
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
BOARD_INCLUDE_RECOVERY_DTBO := true

# (4) 因为 dtb 已在内核里，所以删除或注释掉下面这几行
# TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
# BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)

TARGET_KERNEL_ARCH := arm64
endif

# Partitions
# (2) 以下所有分区参数均已根据您的设备信息更新
BOARD_FLASH_BLOCK_SIZE := 262144
# 注意：boot 分区大小需要您自行确认，此处暂时设为与 recovery 相同
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_SUPER_PARTITION_SIZE := 12884901888
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor odm vendor_dlkm system_dlkm
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 12884901888

# System as root
BOARD_ROOT_EXTRA_FOLDERS := \
    cache \
    carrier \
    data_mirror \
    efs \
    linkerconfig \
    odm_dlkm \
    oem \
    optics \
    postinstall \
    prism \
    second_stage_resources \
    spu \
    system_ext \
    vendor_dlkm
BOARD_SUPPRESS_SECURE_ERASE := true

# Workaround for error copying vendor files to recovery ramdisk
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
TARGET_COPY_OUT_SYSTEM_DLKM := system_dlkm

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Platform
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := pineapple
TARGET_BOARD_PLATFORM_GPU := qcom-adreno750
QCOM_BOARD_PLATFORMS += pineapple

# Recovery
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
RECOVERY_SDCARD_ON_DATA := true

# A/B
# (3) 根据 lpdump 输出，您的设备是 Virtual A/B 设备
AB_OTA_UPDATER := true
BOARD_VIRTUAL_AB_DEVICE := true

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# RTC FIX QCOM
TARGET_RECOVERY_QCOM_RTC_FIX := true

# Crypto
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 12.1.0
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
TW_INCLUDE_FBE_METADATA_DECRYPT := false
BOARD_USES_METADATA_PARTITION := true

# PRODUCT_COPY_FILES directives.
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# TWRP specific build flags
TW_THEME := portrait_hdpi
TW_DEVICE_VERSION := 0
TW_FRAMERATE := 120
TW_DEFAULT_BRIGHTNESS := 500
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_CUSTOM_CPU_TEMP_PATH := /sys/class/thermal/thermal_zone50/temp
TW_SCREEN_BLANK_ON_BOOT := true
TW_EXCLUDE_APEX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_NTFS_3G := true
TW_USE_NEW_MINADBD := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TARGET_USES_MKE2FS := true
TW_NO_LEGACY_PROPS := true
TW_NO_BIND_SYSTEM := true
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true
TW_EXTRA_LANGUAGES := true
TW_BACKUP_EXCLUSIONS := /data/fonts
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_LIBRESETPROP := true
TW_INCLUDE_RESETPROP := true
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
