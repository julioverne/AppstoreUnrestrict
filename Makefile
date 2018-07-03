include theos/makefiles/common.mk

SUBPROJECTS += appstoreunrestricthook
SUBPROJECTS += appstoreunrestrictsettings

include $(THEOS_MAKE_PATH)/aggregate.mk

all::
	
