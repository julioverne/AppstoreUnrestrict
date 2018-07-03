include theos/makefiles/common.mk

TWEAK_NAME = AppstoreUnrestrict

AppstoreUnrestrict_FILES = /mnt/d/codes/appstoreunrestrict/appstoreunrestricthook/AppstoreUnrestrict.xm
AppstoreUnrestrict_FRAMEWORKS = CydiaSubstrate
AppstoreUnrestrict_LDFLAGS = -Wl,-segalign,4000

AppstoreUnrestrict_ARCHS = armv7 arm64
export ARCHS = armv7 arm64

include $(THEOS_MAKE_PATH)/tweak.mk
