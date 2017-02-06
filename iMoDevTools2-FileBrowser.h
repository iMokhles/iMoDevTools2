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

#import "vendors/UIAlertView+Blocks.h"
#import <imounbox/imounbox.h>
#import "filemanager/WASFileBrowserViewController.h"

#import "iMoDevTools2Own.h"

// FileBrowser didSelectBlock
typedef void(^fbDidSelectBlock)(id browser, NSString *filePath);

// FileBrowser cancelBlock
typedef void(^fbCancelBlock)(id browser, NSString *filePath);

// FileBrowser didLoadPathBlock
typedef void(^fbDidLoadPathBlock)(id browser, NSString *filePath);

@interface iMoDevTools (FileBrowser)

// file browser methods
+ (void)showFilePickerFromViewController:(UIViewController *)viewController
                           didSelectFile:(fbDidSelectBlock)didSelectFile
                             didLoadPath:(fbDidLoadPathBlock)didLoadPathBlock
                             cancelBlock:(fbCancelBlock)cancelBlock;

+ (void)loadFileBrowserLibrariesIfNeeded;
@end

//int main(int argc, char **argv, char **envp) {
//	return 0;
//}

// vim:ft=objc
