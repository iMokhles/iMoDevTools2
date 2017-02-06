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

//Needed for all Flurry Integration
#import <flurry/Flurry.h>

//Only needed for Flurry Advertising Integration
#import <flurry/FlurryAdBanner.h>
#import <flurry/FlurryAdBannerDelegate.h>
#import <flurry/FlurryAdDelegate.h>
#import <flurry/FlurryAdError.h>

#import "iMoDevTools2Own.h"
#import "vendors/FXReachability.h"

@interface iMoDevTools (Ads) <FlurryAdBannerDelegate>

@property (nonatomic, strong) UIViewController *adViewController;
@property (nonatomic, strong) FlurryAdBanner *adBunner;

- (void)startBottomBannerFromVC:(UIViewController *)vc;
- (void)startTopBannerFromVC:(UIViewController *)vc;
@end

//int main(int argc, char **argv, char **envp) {
//	return 0;
//}

// vim:ft=objc
