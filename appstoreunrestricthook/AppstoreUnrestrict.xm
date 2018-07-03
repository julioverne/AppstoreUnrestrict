#import <substrate.h>
#import <objc/runtime.h>
#import <dlfcn.h>

#define NSLog(...)

#define PLIST_PATH_Settings "/var/mobile/Library/Preferences/com.julioverne.appstoreunrestrict.plist"

static BOOL Enabled;

static id (*SSGetStringForNetworkType_o)(int type);
static id SSGetStringForNetworkType_r(int type)
{
	if(Enabled) {
		return @"WiFi";
	}
	return SSGetStringForNetworkType_o(type);
}

static void settingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{	
	@autoreleasepool {		
		NSDictionary *AppstoreUnrestrictPrefs = [[[NSDictionary alloc] initWithContentsOfFile:@PLIST_PATH_Settings]?:[NSDictionary dictionary] copy];
		Enabled = (BOOL)[[AppstoreUnrestrictPrefs objectForKey:@"Enabled"]?:@YES boolValue];
	}
}

%ctor
{	
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, settingsChanged, CFSTR("com.julioverne.appstoreunrestrict/Settings"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	settingsChanged(NULL, NULL, NULL, NULL, NULL);
	dlopen("/System/Library/PrivateFrameworks/StoreServices.framework/StoreServices", RTLD_GLOBAL);	
	MSHookFunction((void *)(dlsym(RTLD_DEFAULT, "SSGetStringForNetworkType")), (void *)SSGetStringForNetworkType_r, (void **)&SSGetStringForNetworkType_o);
}