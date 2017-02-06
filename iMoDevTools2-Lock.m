#import "iMoDevTools2-Lock.h"
#import "vendors/UIAlertView+Blocks.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wconstant-conversion"


@implementation iMoDevTools (Lock)

+ (void)startLockScreenServiceForAccount:(NSString *)lockAccount andService:(NSString *)lockScervice {
    [[VENTouchLock sharedInstance] setKeychainService:lockScervice
                                      keychainAccount:lockAccount
                                        touchIDReason:@"Scan your fingerprint to use the app."
                                 passcodeAttemptLimit:5
                            splashViewControllerClass:[IMTouchLockSplashViewController class]];
}
+ (BOOL)imodev_canUseVENTouchID {
    return [[VENTouchLock sharedInstance] isPasscodeSet] && [VENTouchLock canUseTouchID];
}
+ (BOOL)imodev_isVENPasscodeSet {
    return [[VENTouchLock sharedInstance] isPasscodeSet];
}
+ (void)imodev_setVENTouchIDEnabled:(BOOL)enabled {
    [VENTouchLock setShouldUseTouchID:enabled];
}
+ (void)imodev_removeVENPasscodeWithBlock:(finishedWithResult)result {
    if ([[VENTouchLock sharedInstance] isPasscodeSet]) {
        [UIAlertView showWithTitle:NSLocalizedString(@"Passcode", @"") message:NSLocalizedString(@"Do u really want to remove the current passcode ?\nif Yes\nyou will need to enter the current passcode once to confirm your settings\nThanks", @"") cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:@[NSLocalizedString(@"Yes", @"")] tapBlock:^(UIAlertView * alertView, NSInteger buttonIndex) {
            NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
            if ([btnTitle isEqualToString:NSLocalizedString(@"Yes", @"")]) {
                VENTouchLockEnterPasscodeViewController *passCodeVC = [[VENTouchLockEnterPasscodeViewController alloc] init];
                //                passCodeVC.showCancelButton = NO;
                passCodeVC.willFinishWithResult = ^(BOOL success) {
                    if (success) {
                        [[VENTouchLock sharedInstance] deletePasscode];
                        [[[iMoDevTools sharedInstance] imo_mainViewController] dismissViewControllerAnimated:YES completion:^() {
                            result(YES);
                        }];
                    } else {
                        [[[iMoDevTools sharedInstance] imo_mainViewController] dismissViewControllerAnimated:YES completion:^() {
                            result(NO);
                        }];
                    }
                };
                [[[iMoDevTools sharedInstance] imo_mainViewController] presentViewController:[passCodeVC embeddedInNavigationController] animated:YES completion:nil];
            } else {
                result(NO);
            }
            
        }];
    } else {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No passcode", @"") message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
        result(NO);
    }
}
+ (void)imodev_setVENPasscode {
    if ([[VENTouchLock sharedInstance] isPasscodeSet]) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Passcode already exists", @"") message:NSLocalizedString(@"To set a new one, first delete the existing one", @"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else {
        VENTouchLockCreatePasscodeViewController *createPasscodeVC = [[VENTouchLockCreatePasscodeViewController alloc] init];
        [[[iMoDevTools sharedInstance] imo_mainViewController] presentViewController:[createPasscodeVC embeddedInNavigationController] animated:YES completion:nil];
    }
}

@end

#pragma clang diagnostic pop
