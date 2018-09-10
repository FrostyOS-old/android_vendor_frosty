# World APN list
PRODUCT_COPY_FILES += \
    vendor/frosty/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Telephony packages
PRODUCT_PACKAGES += \
    Stk \
    CellBroadcastReceiver \
    messaging

# Tethering - allow without requiring a provisioning app
# (for devices that check this)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    net.tethering.noprovisioning=true

# Inherit full common Frosty stuff
$(call inherit-product, vendor/frosty/config/common_full.mk)