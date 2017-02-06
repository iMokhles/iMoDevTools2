#import "iMoDevTools2-FileBrowser.h"
#import "vendors/UIAlertView+Blocks.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wconstant-conversion"


__attribute__((always_inline, visibility("hidden")))
extern BOOL isThisFileExiste(const char *path);
@implementation iMoDevTools (FileBrowser)

// file browser methods
+ (void)showFilePickerFromViewController:(UIViewController *)viewController
                           didSelectFile:(fbDidSelectBlock)didSelectFile
                             didLoadPath:(fbDidLoadPathBlock)didLoadPathBlock
                             cancelBlock:(fbCancelBlock)cancelBlock {
    
    WASFileBrowserViewController *filePicker = [[WASFileBrowserViewController alloc] init];
    filePicker.didSelectFileBlock = didSelectFile;
    filePicker.didLoadDirectoryBlock = didLoadPathBlock;
    filePicker.didCancelBlock = cancelBlock;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:filePicker];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    [viewController presentViewController:navigationController animated:YES completion:nil];
    
}

+ (void)loadFileBrowserLibrariesIfNeeded {
    if ([iMoDevTools isIOS90_OrGreater]) {
        if (!isThisFileExiste("/usr/lib/libimounbox.dylib")) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIAlertView showWithTitle:@"WARNING"
                                   message:[NSString stringWithFormat:@"you need to install iMoDevTools library from Cydia if not installed already to make this tweak work probably ( tap install )"]
                         cancelButtonTitle:@"cancel"
                         otherButtonTitles:@[@"install"]
                                  tapBlock:^(UIAlertView * __nonnull alertView, NSInteger buttonIndex) {
                                      if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"install"]) {
                                          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://packages/com.imokhles.imodevtools"]];
                                      }
                                  }];
            });
            
        } else {
            dlopen("/usr/lib/libimounbox.dylib", RTLD_NOW);
        }
    } else if ([iMoDevTools isIOS70_OrGreater]) {
        if (!isThisFileExiste("/usr/lib/libuaunbox.dylib")) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIAlertView showWithTitle:@"WARNING"
                                   message:[NSString stringWithFormat:@"you need to install uaunbox library from Cydia if not installed already to make this tweak work probably ( tap install )"]
                         cancelButtonTitle:@"cancel"
                         otherButtonTitles:@[@"install"]
                                  tapBlock:^(UIAlertView * __nonnull alertView, NSInteger buttonIndex) {
                                      if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"install"]) {
                                          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://packages/com.unlimapps.uaunbox"]];
                                      }
                                  }];
            });
            
        } else {
            dlopen("/usr/lib/libuaunbox.dylib", RTLD_NOW);
        }
    } else {
        if (!isThisFileExiste("/usr/lib/libSandCastle.dylib")) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIAlertView showWithTitle:@"WARNING"
                                   message:[NSString stringWithFormat:@"you need to install SandCastle 2 library from Cydia if not installed already to make this tweak work probably ( tap install )"]
                         cancelButtonTitle:@"cancel"
                         otherButtonTitles:@[@"install"]
                                  tapBlock:^(UIAlertView * __nonnull alertView, NSInteger buttonIndex) {
                                      if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"install"]) {
                                          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://packages/co.cocoanuts.sandcastle"]];
                                      }
                                  }];
            });
            
        } else {
            dlopen("/usr/lib/libSandCastle.dylib", RTLD_NOW);
        }
    }
}

@end
#pragma clang diagnostic pop
