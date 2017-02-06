GO_EASY_ON_ME = 1

DEBUG = 0

#THEOS_DEVICE_IP = 192.168.0.10

ARCHS = armv7 arm64

TARGET = iphone:clang:9.1:8.0

export ADDITIONAL_LDFLAGS = -Wl,-segalign,4000

include theos/makefiles/common.mk

THEOS_BUILD_DIR = Packages

LIBRARY_NAME = libimounbox
libimounbox_LOGOSFLAGS = -c generator=internal
libimounbox_FILES = IMClient.m
libimounbox_CFLAGS = -I.
libimounbox_LIBRARIES = rocketbootstrap
libimounbox_PRIVATE_FRAMEWORKS = AppSupport
libimounbox_INSTALL_PATH = /usr/lib

TOOL_NAME = imounbox
imounbox_FILES = IMServer.m IMDelegate.m
imounbox_FRAMEWORKS = Foundation CoreFoundation UIKit
imounbox_PRIVATE_FRAMEWORKS = AppSupport
imounbox_LIBRARIES = rocketbootstrap
imounbox_INSTALL_PATH = /usr/libexec

include $(THEOS_MAKE_PATH)/library.mk
include $(THEOS_MAKE_PATH)/tool.mk

before-package::
	sudo find .theos/_ -name "imounbox" -exec chown root:wheel {} \;
	sudo find .theos/_ -name "imounbox" -exec chmod 4777 {} \;
	sudo find .theos/_ -name "com.imokhles.imounboxdlaunch.plist" -exec chown root:wheel {} \;
	# sudo find .theos/_ -name "imounbox" -exec ldid -Sentitlements.xml {} \;
	sudo find .theos/_ -name "imounboxdlaunch" -exec chmod 755 {} \;
