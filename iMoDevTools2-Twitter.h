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

#import "vendors/IMTWHelper.h"

#import "iMoDevTools2Own.h"

@interface iMoDevTools (Twitter)

- (void)imodev_isAdsPurchasedForTweak:(NSSttring *)tweakId withBlock:(finishedWithResultError)result;
@end

//int main(int argc, char **argv, char **envp) {
//	return 0;
//}

// vim:ft=objc
