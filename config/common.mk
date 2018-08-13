PRODUCT_BRAND ?= FrostyOS

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google

else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.selinux=1 \
    ro.setupwizard.rotation_locked=true

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

ifeq ($(BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE),)
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/data/cache
else
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/cache
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/frosty/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/frosty/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/frosty/prebuilt/common/bin/50-frosty.sh:system/addon.d/50-frosty.sh \
    vendor/frosty/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# Backup and privapp permissions
PRODUCT_COPY_FILES += \
    vendor/frosty/config/permissions/backup.xml:system/etc/sysconfig/backup.xml \
    vendor/frosty/config/permissions/privapp-permissions-aosp.xml:system/etc/permissions/privapp-permissions-aosp.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/frosty/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/frosty/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# Copy all Frosty-specific init rc files
$(foreach f,$(wildcard vendor/frosty/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/frosty/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Optional packages
PRODUCT_PACKAGES += \
    libemoji \
    LiveWallpapersPicker \
    LatinIME

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Markup
PRODUCT_PACKAGES += \
    MarkupGoogle

# Markup libs
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/lib/libsketchology_native.so:system/lib/libsketchology_native.so \
    vendor/aosp/prebuilt/common/lib64/libsketchology_native.so:system/lib64/libsketchology_native.so

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

DEVICE_PACKAGE_OVERLAYS += vendor/frosty/overlay/common

# Branding
include vendor/frosty/config/branding.mk

-include $(WORKSPACE)/build_env/image-auto-bits.mk
