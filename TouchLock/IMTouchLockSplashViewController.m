#import "IMTouchLockSplashViewController.h"
#import "../iMoDevTools2Own.h"
#import "VENTouchLock.h"

@interface IMTouchLockSplashViewController ()
@end

@implementation IMTouchLockSplashViewController

#pragma mark - Creation and Lifecycle

- (instancetype)init
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[iMoDevTools tweakBundle]];
    if (self) {
        self.didFinishWithSuccess = ^(BOOL success, VENTouchLockSplashViewControllerUnlockType unlockType) {
            if (success) {
                NSString *logString = @"App Unlocked";
                switch (unlockType) {
                    case VENTouchLockSplashViewControllerUnlockTypeTouchID: {
                        logString = [logString stringByAppendingString:@" with Touch ID."];
                        break;
                    }
                    case VENTouchLockSplashViewControllerUnlockTypePasscode: {
                        logString = [logString stringByAppendingString:@" with Passcode."];
                        break;
                    }
                    default:
                        break;
                }
                NSLog(@"%@", logString);
            }
            else {
                [[[UIAlertView alloc] initWithTitle:@"Limit Exceeded"
                                            message:@"You have exceeded the maximum number of passcode attempts"
                                           delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil] show];
            }
        };
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setView:[self mainLockView]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

}

- (UIView *)mainLockView {
    UIView *lockView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [lockView setBackgroundColor:[UIColor whiteColor]];
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:lockView.frame];
    [bgImageView setImage:[UIImage imageWithContentsOfFile:[iMoDevTools pathForTweakFileWithName:@"mainLockBg" extension:@"jpg"]]];
    [lockView addSubview:bgImageView];
    
    if (![VENTouchLock shouldUseTouchID]) {
        
        UIButton* pointerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        pointerBtn.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-45, [UIScreen mainScreen].bounds.size.width, 45);
        [pointerBtn setTitle:@"PassCode" forState:UIControlStateNormal];
        [pointerBtn setImage:nil forState:UIControlStateNormal];
        [pointerBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [pointerBtn addTarget:self action:@selector(tappedPasscode:)
             forControlEvents:UIControlEventTouchUpInside];
        [pointerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [pointerBtn setBackgroundColor:[UIColor whiteColor]];
        [pointerBtn setUserInteractionEnabled:YES];
        [lockView addSubview:pointerBtn];
        
    } else {
        NSArray *btnsArray = @[@"TouchID", @"PassCode"];
        CGFloat xOffset = 0;
        for(int i=0; i<[btnsArray count]; i++)
        {
            UIButton* pointerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            pointerBtn.frame = CGRectMake(xOffset, [[UIScreen mainScreen] bounds].size.height-45, [UIScreen mainScreen].bounds.size.width/2, 45);
            [pointerBtn setTitle:btnsArray[i] forState:UIControlStateNormal];
            [pointerBtn setImage:nil forState:UIControlStateNormal];
            [pointerBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            [pointerBtn addTarget:self action:@selector(securityTapped:)
                 forControlEvents:UIControlEventTouchUpInside];
            [pointerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [pointerBtn setBackgroundColor:[UIColor whiteColor]];
            pointerBtn.tag = (i*1000)+1;
            [pointerBtn setUserInteractionEnabled:YES];
            [lockView addSubview:pointerBtn];
            xOffset += [UIScreen mainScreen].bounds.size.width/2;
        }
    }
    
    
    return lockView;
}
- (void)securityTapped:(UIButton *)sender {
    switch(sender.tag/1000)
    {
        case 0:
        {
            // TouchId
            [self tappedTouchID:nil];
        }
            break;
            
        case 1:
        {
            // PassCode
            [self tappedPasscode:nil];
        }
            break;
        default:
            break;
    }
}

- (void)tappedTouchID:(id)sender {
    [self showTouchID];
}

- (void)tappedPasscode:(id)sender {
    [self showPasscodeAnimated:YES];
}
@end
