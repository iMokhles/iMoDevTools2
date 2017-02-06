GO_EASY_ON_ME = 1

DEBUG = 0

# THEOS_DEVICE_IP = localhost
THEOS_DEVICE_IP = 192.168.0.10

ARCHS = armv7 arm64

TARGET = iphone:clang:latest:8.0

export ADDITIONAL_LDFLAGS = -Wl,-segalign,4000 -L$(THEOS)/custom_libs -lFlurry_7.9.2 -lFlurryAds_7.9.2 -F$(THEOS)/custom_frameworks -framework FirebaseAnalytics -framework FirebaseCore -framework FirebaseAuth -framework FirebaseInstanceID -framework GoogleInterchangeUtilities -framework GoogleSymbolUtilities -framework GoogleToolboxForMac -framework GTMSessionFetcher
export ADDITIONAL_CFLAGS = -F$(THEOS)/custom_frameworks -L$(THEOS)/custom_libs

TARGET_CODESIGN_FLAGS = -S$(THEOS_PROJECT_DIR)/entitlements.xml

THEOS_BUILD_DIR = Packages

include theos/makefiles/common.mk

LIBRARY_NAME = libimodevtools2
libimodevtools2_CFLAGS = -fobjc-arc
libimodevtools2_FILES = $(wildcard *.m) $(wildcard fmdb/*.m) $(wildcard vendors/*.m) $(wildcard filemanager/*.m) $(wildcard filemanager/*.c) $(wildcard filemanager/*.mm) $(wildcard flurry_libs/*.m) $(wildcard TouchLock/*.m)
libimodevtools2_FRAMEWORKS = UIKit Foundation MessageUI CoreGraphics QuartzCore CoreImage Accelerate AVFoundation AudioToolbox MobileCoreServices Social Accounts AssetsLibrary AdSupport MediaPlayer SystemConfiguration Security CoreText Photos CoreMedia LocalAuthentication
libimodevtools2_PRIVATE_FRAMEWORKS = MediaPlayer MediaPlayerUI FuseUI MusicCarDisplayUI DCIMServices
libimodevtools2_LIBRARIES = MobileGestalt z sqlite3 imounbox

SUBPROJECTS += iMoUnBox
include $(THEOS_MAKE_PATH)/aggregate.mk
include $(THEOS_MAKE_PATH)/library.mk

before-package::

	$(ECHO_NOTHING)echo " Installing Library"$(ECHO_END)
	$(ECHO_NOTHING)sudo ldid -Sentitlements.xml  $(THEOS_STAGING_DIR)/usr/lib/libimodevtools2.dylib$(ECHO_END)
	$(ECHO_NOTHING)sudo cp  $(THEOS_STAGING_DIR)/usr/lib/libimodevtools2.dylib $(THEOS)/lib$(ECHO_END)
	$(ECHO_NOTHING)sudo cp  $(THEOS_STAGING_DIR)/usr/lib/libimounbox.dylib $(THEOS)/lib$(ECHO_END)
	$(ECHO_NOTHING)sudo cp -f iMoDevTools2.h $(THEOS_STAGING_DIR)/usr/include/libimodevtools2/iMoDevTools2.h $(ECHO_END)
	$(ECHO_NOTHING)sudo cp -r -f $(THEOS_STAGING_DIR)/usr/include/libimodevtools2/ $(THEOS)/include/libimodevtools2/ $(ECHO_END)
	$(ECHO_NOTHING)sudo cp -f iMoDevTools2Own.h $(THEOS)/include/libimodevtools2/iMoDevTools2Own.h $(ECHO_END)
	$(ECHO_NOTHING)echo " Library Installed"$(ECHO_END)

after-install::
	install.exec "killall -9 backboardd"