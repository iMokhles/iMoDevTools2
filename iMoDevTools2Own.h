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

#import "iMoDevTools2-Lock.h"
#import "iMoDevTools2-Ads.h"
#import "iMoDevTools2-Twitter.h"
#import "iMoDevTools2-Firebase.h"
#import "iMoDevTools2-FileBrowser"


// last image private API
@interface DCIMImageWellUtilities : NSObject
+ (id)cameraPreviewWellImage;
+ (id)cameraPreviewWellImageFileURL;
@end
typedef void(^finishedWithImage)(UIImage *image);

// Music Grabber
typedef void(^finishedWithMusicFilePath)(NSString *musicPath);

// result block
typedef void(^finishedWithResult)(BOOL isOK);

// result block with error
typedef void(^finishedWithResultError)(BOOL isOK, NSError *error);

// array block
typedef void(^finishedArrayWithResult)(NSArray *array);

// string block
typedef void(^finishedStringWithResult)(NSString *string);

@interface iMoDevTools : NSObject
+ (id)sharedInstance;

// check ios version
+ (BOOL)isIOS10_2_OrGreater;
+ (BOOL)isIOS10_0_OrGreater;
+ (BOOL)isIOS93_OrGreater;
+ (BOOL)isIOS90_OrGreater;
+ (BOOL)isLowerThanIOS9;
+ (BOOL)isIOS83_OrGreater;
+ (BOOL)isIOS80_OrGreater;
+ (BOOL)isLowerThanIOS8;
+ (BOOL)isIOS70_OrGreater;
+ (BOOL)isLowerThanIOS7;
+ (BOOL)isIOS60_OrGreater;
+ (BOOL)isIOS50_OrGreater;
+ (BOOL)isIOS40_OrGreater;

// Checking Device Type
+ (BOOL)isIPhone6_Plus;
+ (BOOL)isIPhone6;
+ (BOOL)isIPhone5;
+ (BOOL)isIPhone4_OrLess;

// Checking Device Interface
+ (BOOL)isIPad;
+ (BOOL)isIPhone;

// Checking Device Retina
+ (BOOL)isRetina;

// Checking UIScreen sizes
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

// Check if device support touchID or no
+ (BOOL)imodev_canUseTouchID;


+ (NSString *)abbreviateNumber:(int)num;
+ (float)calculateFileSizeInUnit:(unsigned long long)contentLength;
+ (NSString *)calculateUnit:(unsigned long long)contentLength;

// get the main View Controller
- (UIViewController *)imo_mainViewController;
// get your device UDID
- (NSString *)imo_deviceUDIDValue;
// get your device Serial
- (NSString *)imo_deviceSerialValue;
// get your device sys name
- (NSString *)imo_deviceSysName;
// get your device sys version
- (NSString *)imo_deviceSysVersion;
// get your device hardware id
- (NSString *)imo_deviceHardware;
// share any file with other apps ( supports OpenIN )
- (void)imo_shareFileAtPath:(NSString *)path;
// share any text with other apps ( supports Speech )
- (void)imo_shareText:(NSString *)text;
// get last taken image
- (void)imo_getLastImageCompletion:(finishedWithImage)image;
// get music file from MediaItem
- (void)grabMusicFileFromMediaItem:(MPMediaItem *)mediaItem completion:(finishedWithMusicFilePath)musicPath;
// send email to dev
- (void)sendEmailTo:(NSString *)emailAddress subject:(NSString *)subject text:(NSString *)text attachment:(NSData *)attachment mimeType:(NSString *)mimeType fileName:(NSString *)filename;
// get all tweaks list for specific developer
- (void)getAllTweaksForDeveloper:(NSString *)developerName withBlock:(finishedArrayWithResult)arrayBlock;
// show twitter follow alert
- (void)showTwitterFollowAlertWithTweakName:(NSString *)tweakName message:(NSString *)message accountName:(NSString *)accountName;
// check things
- (void)isThisThingIsCorrect:(NSString *)ID withBlock:(finishedWithResult)result;
// get array
- (void)getArrayFromThis:(NSString *)string withBlock:(finishedArrayWithResult)arrayBlock;
- (void)startThisThingAfter:(NSArray *)array withBlock:(finishedWithResult)result;
// check out-side
- (void)checkOutSide:(NSString *)ID withBlock:(finishedStringWithResult)resultBlock;
// remove things
- (void)removeThisThing:(NSString *)string;
- (void)removeFile:(NSString *)filePath;
- (void)getMusicArrayFromArray:(NSArray *)filesArray;

+ (NSBundle *)tweakBundle;
+ (NSString *)tweakBundlePath;
+ (NSURL *)urlForTweakFileWithName:(NSString *)name extension:(NSString *)extension;
+ (NSString *)pathForTweakFileWithName:(NSString *)name extension:(NSString *)extension;
+ (NSString *)localizedStringForKey:(NSString *)key withDefault:(NSString *)defaultString;

+ (UIImage *)imageFromPathName:(NSString *)imageName extension:(NSString *)extension;
+ (UIImage *)image:(UIImage *)image scalingToSize:(CGSize)targetSize;

-(BOOL)archiveObject:(id<NSSecureCoding>)object forKey:(NSString *)key;
-(id)unarchiveObjectForKey:(NSString *)key;
@end

//int main(int argc, char **argv, char **envp) {
//	return 0;
//}

// vim:ft=objc
