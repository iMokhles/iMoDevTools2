#import <iMoMacros.h>
#import <unistd.h>
#import <stdlib.h>
#import <sys/types.h>
#import <sys/stat.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreFoundation/CoreFoundation.h>
#import <AppSupport/CPDistributedMessagingCenter.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MessageUI/MessageUI.h>
#import <Photos/Photos.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <CommonCrypto/CommonDigest.h>
#import <LocalAuthentication/LocalAuthentication.h>

#import "TouchLock/IMTouchLockSplashViewController.h"
#import "TouchLock/VENTouchLock.h"

#import "iMoDevTools2Own.h"

@interface iMoDevTools (Lock)


+ (void)startLockScreenServiceForAccount:(NSString *)lockAccount andService:(NSString *)lockScervice;
+ (BOOL)imodev_canUseVENTouchID;
+ (BOOL)imodev_isVENPasscodeSet;
+ (void)imodev_setVENTouchIDEnabled:(BOOL)enabled;
+ (void)imodev_removeVENPasscodeWithBlock:(finishedWithResult)result;
+ (void)imodev_setVENPasscode;

@end

//int main(int argc, char **argv, char **envp) {
//	return 0;
//}

// vim:ft=objc
