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

#import <FirebaseAnalytics/FirebaseAnalytics.h>
#import <FirebaseCore/FirebaseCore.h>
#import <FirebaseAuth/FirebaseAuth.h>

#import "iMoDevTools2Own.h"

@interface iMoDevTools (Firebase)

+ (FIROptions *)imo_defaultsOptionsFromPlist;
+ (void)imo_configureDefaultApp;
+ (void)imo_setUserInformationWithEmail:(NSString *)userEmail withBlock:(finishedWithResultError)result;
+ (void)imo_getUserInformationWithEmail:(NSString *)userEmail withBlock:(finishedWithResultError)result;
+ (FIRDatabaseReference *)imo_mainReferenceDatabase;
+ (NSString *)imo_currentUserUid;
@end

//int main(int argc, char **argv, char **envp) {
//	return 0;
//}

// vim:ft=objc
