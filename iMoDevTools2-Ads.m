#import "iMoDevTools2-Ads.h"

#define TWITTER_ACCOUNT @"iMokhles"
#define kTweakVersion @"2.6-1"
#define kSCTweakBundlePath [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"iMoDevTools2.bundle"]

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wconstant-conversion"


__attribute__((always_inline, visibility("hidden")))
static NSString *imdev_flurryKey() {
    return @"XXXXXXXXX"
}

__attribute__((always_inline, visibility("hidden")))
static NSString *imdev_flurryTopBannerKey() {
    return @"XXXXXXXXX"
}

__attribute__((always_inline, visibility("hidden")))
static NSString *imdev_flurryBottomBannerKey() {
    return @"XXXXXXXXX"
}

__attribute__((always_inline, visibility("hidden")))
void startFlurrySession() {
    
    FlurrySessionBuilder* builder = [[[[[FlurrySessionBuilder new]
                                        withLogLevel:FlurryLogLevelAll]
                                       withCrashReporting:YES]
                                      withSessionContinueSeconds:10]
                                     withAppVersion:kTweakVersion];
    
    [Flurry startSession:imdev_flurryKey() withSessionBuilder:builder];
    
}

@implementation iMoDevTools (Ads)

- (void)startBottomBannerFromVC:(UIViewController *)vc {
    self.adViewController = vc;
    self.adBunner = [[FlurryAdBanner alloc] initWithSpace:imdev_flurryBottomBannerKey()];
    self.adBunner.adDelegate = self;
    [self.adBunner fetchAdForFrame:self.adViewController.view.frame];
}
- (void)startTopBannerFromVC:(UIViewController *)vc {
    self.adViewController = vc;
    self.adBunner = [[FlurryAdBanner alloc] initWithSpace:imdev_flurryTopBannerKey()];
    self.adBunner.adDelegate = self;
    [self.adBunner fetchAdForFrame:self.adViewController.view.frame];
}
- (void) adBannerDidFetchAd:(FlurryAdBanner*)bannerAd {
    [bannerAd displayAdInView:self.adViewController.view viewControllerForPresentation:self.adViewController];
}
- (void) adBannerDidReceiveClick:(FlurryAdBanner*)bannerAd {
    
}
- (void) adBannerDidRender:(FlurryAdBanner*)bannerAd {
    
}
- (void) adBanner:(FlurryAdBanner*) bannerAd adError:(FlurryAdError) adError errorDescription:(NSError*) errorDescription {
    BOOL reachable = [FXReachability isReachable];
    if (reachable == YES) {
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Warning"
                                  message:@"No internet connection"
                                  delegate:self
                                  cancelButtonTitle:@""
                                  otherButtonTitles:nil];
        [alertView show];
        
        
    }
}

@end
#pragma clang diagnostic pop
