# Set all versions
FROSTY_BUILD_TYPE ?= UNOFFICIAL
FROSTY_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)
FROSTY_BUILD_VERSION := v0.1

ifeq ($(FROSTY_BUILD_TYPE), OFFICIAL)
FROSTY_BUILD_TYPE := OFFICIAL
endif

TARGET_PRODUCT_SHORT := $(subst frosty_,,$(FROSTY_BUILD))

FROSTY_VERSION := FrostyOS_$(FROSTY_BUILD)-$(FROSTY_BUILD_VERSION)-$(FROSTY_BUILD_DATE)-$(FROSTY_BUILD_TYPE)
FROSTY_FINGERPRINT := FrostyOS/$(FROSTY_BUILD_VERSION)/$(PLATFORM_VERSION)/$(FROSTY_BUILD_DATE)

CUSTOM_PROPERTIES := \
    ro.frosty.version=$(FROSTY_BUILD_VERSION) \
    ro.frosty.build_date=$(FROSTY_BUILD_DATE) \
    ro.frosty.build_type=$(FROSTY_BUILD_TYPE) \
    ro.frosty.fingerprint=$(FROSTY_FINGERPRINT)