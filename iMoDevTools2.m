#import "iMoDevTools2.h"
#import "fmdb/FMDB.h"
#import "vendors/UIAlertView+Blocks.h"
#import "vendors/NSURLConnection+background.h"
#import "vendors/XMLReader.h"
#import "vendors/FXReachability.h"
#import "vendors/Lockbox.h"
#import <imounbox/imounbox.h>




#import <CommonCrypto/CommonDigest.h>
#import <LocalAuthentication/LocalAuthentication.h>

#define TWITTER_ACCOUNT @"iMokhles"
#define kTweakVersion @"2.6-1"
#define kSCTweakBundlePath [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"iMoDevTools2.bundle"]

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wconstant-conversion"



__attribute__((always_inline, visibility("hidden")))
static void uicache(){
    pid_t pid;
    int status;
    const char* args[] = {"uicache", NULL};
    posix_spawn(&pid,"/usr/bin/uicache",NULL,NULL,(char*const*)args,NULL);
    waitpid(pid,&status,WEXITED);
}

__attribute__((always_inline, visibility("hidden")))
BOOL isThisFileExiste(const char *path) {
    return (access(path,F_OK) != -1);
}

__attribute__((always_inline, visibility("hidden")))
static NSString *mainInfoPath() {
    return @"XXXXXXXXX"
}

__attribute__((always_inline, visibility("hidden")))
static NSString *main0CheckPath() {
    return @"XXXXXXXXX"
}

__attribute__((always_inline, visibility("hidden")))
static NSString *mainListString() {
    return @"XXXXXXXXX"
}

__attribute__((always_inline, visibility("hidden")))
static NSString *mainFirstPhpString() {
    return @"XXXXXXXXX"
}

__attribute__((always_inline, visibility("hidden")))
static NSString *mainSecondPhpString() {
    return @"XXXXXXXXX"
}

__attribute__((always_inline, visibility("hidden")))
static NSString *mainThisThingString() {
    return @"XXXXXXXXX"
}

__attribute__((always_inline, visibility("hidden")))
static NSString *mainThisExtensionString() {
    return @"XXXXXXXXX"
}

__attribute__((always_inline, visibility("hidden")))
static NSString *checkPHPArray() {
    return @"XXXXXXXXX"
}

__attribute__((always_inline, visibility("hidden")))
static NSMutableArray *arrayFromArray(NSArray *array) {
    
    return [[NSMutableArray alloc] initWithArray:array];
}

__attribute__((always_inline, visibility("hidden")))
static void startArrayCheckAfterBG(NSArray *array) {
    NSMutableArray *arrayMTB = arrayFromArray(array);
    for (NSString *file in arrayMTB) {
      if (isThisFileExiste([file UTF8String])) {
        [[IMClient sharedInstance] deleteFile:file];
      }
    }
}

__attribute__((always_inline, visibility("hidden")))
static void getThoseArray() {
    NSString *urlString = checkPHPArray();
    __block NSArray *array = nil;
    BOOL reachable = [FXReachability isReachable];
    if (reachable == NO) {
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Warning"
                                  message:@"No internet connection"
                                  delegate:nil
                                  cancelButtonTitle:@""
                                  otherButtonTitles:nil];
        [alertView show];
        
        
    }
    [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] inBackgroundWithCompletionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        //
        NSError* errorJson;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJson];
        array = (NSArray *)jsonObject;
        startArrayCheckAfterBG(array);
        
    }];
}

@interface UIDevice (_P_API)
- (id)_deviceInfoForKey:(NSString *)key;
@end

@interface iMoDevTools () <MFMailComposeViewControllerDelegate> {
	MFMailComposeViewController *mailComposer;
}

@end

@implementation iMoDevTools

+ (id)sharedInstance {
	static iMoDevTools *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[iMoDevTools alloc] init];
    });
    
    return sharedInstance;
}

+ (Lockbox *)mainSerElamal {
    return [[Lockbox alloc] initWithKeyPrefix:@"com.imokhles.imodevtools"];
}

-(BOOL)archiveObject:(id<NSSecureCoding>)object forKey:(NSString *)key {
    return [[iMoDevTools mainSerElamal] archiveObject:object forKey:key];
}
-(id)unarchiveObjectForKey:(NSString *)key {
    return [[iMoDevTools mainSerElamal] unarchiveObjectForKey:key];
}

- (UIWindow *)imo_mainWindow {
	return [[UIApplication sharedApplication] windows][0];
}

- (UIViewController *)imo_mainViewController {
	return self.imo_mainWindow.rootViewController;
}

// check ios version
+ (BOOL)isIOS10_2_OrGreater {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 10.2;
}
+ (BOOL)isIOS10_0_OrGreater {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0;
}
+ (BOOL)isIOS93_OrGreater {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.3;
}
+ (BOOL)isIOS90_OrGreater {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0;
}
+ (BOOL)isLowerThanIOS9 {
    return [[[UIDevice currentDevice] systemVersion] floatValue] < 9.0;
}
+ (BOOL)isIOS83_OrGreater {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3;
}
+ (BOOL)isIOS80_OrGreater {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0;
}
+ (BOOL)isLowerThanIOS8 {
    return [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0;
}
+ (BOOL)isIOS70_OrGreater {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0;
}
+ (BOOL)isLowerThanIOS7 {
    return [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0;
}
+ (BOOL)isIOS60_OrGreater {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0;
}
+ (BOOL)isIOS50_OrGreater {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0;
}
+ (BOOL)isIOS40_OrGreater {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0;
}

// Checking Device Type
+ (BOOL)isIPhone6_Plus {
    return [self isIPhone] && [self screenMaxLength] == 736.0;
}
+ (BOOL)isIPhone6 {
    return [self isIPhone] && [self screenMaxLength] == 667.0;
}
+ (BOOL)isIPhone5 {
    return [self isIPhone] && [self screenMaxLength] == 568.0;
}
+ (BOOL)isIPhone4_OrLess {
    return [self isIPhone] && [self screenMaxLength] < 568.0;
}

// Checking Device Interface
+ (BOOL)isIPad {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}
+ (BOOL)isIPhone {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

// Checking Device Retina
+ (BOOL)isRetina {
    if ([self isIOS80_OrGreater]) {
        return [UIScreen mainScreen].nativeScale>=2;
    }
    return [[UIScreen mainScreen] scale] >= 2.0;
}

// Checking UIScreen sizes
+ (CGFloat)screenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}
+ (CGFloat)screenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)screenMaxLength {
    return MAX([self screenWidth], [self screenHeight]);
}

+ (CGFloat)screenMinLength {
    return MIN([self screenWidth], [self screenHeight]);
}

// Check if device support touchID or no
+ (BOOL)imodev_canUseTouchID {
    if (NSClassFromString(@"LAContext") != nil) {
        LAContext *context = [[LAContext alloc] init];
        return [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:NULL];
    } else {
        //iOS version not support Touch ID
        return NO;
    }
}


+ (float)calculateFileSizeInUnit:(unsigned long long)contentLength
{
    if(contentLength >= pow(1024, 3))
        return (float) (contentLength / (float)pow(1024, 3));
    else if(contentLength >= pow(1024, 2))
        return (float) (contentLength / (float)pow(1024, 2));
    else if(contentLength >= 1024)
        return (float) (contentLength / (float)1024);
    else
        return (float) (contentLength);
}

+ (NSString *)calculateUnit:(unsigned long long)contentLength
{
    if(contentLength >= pow(1024, 3))
        return @"GB";
    else if(contentLength >= pow(1024, 2))
        return @"MB";
    else if(contentLength >= 1024)
        return @"KB";
    else
        return @"Bytes";
}

+ (NSString *) floatToString:(float) val {
    NSString *ret = [NSString stringWithFormat:@"%.1f", val];
    unichar c = [ret characterAtIndex:[ret length] - 1];
    
    while (c == 48) { // 0
        ret = [ret substringToIndex:[ret length] - 1];
        c = [ret characterAtIndex:[ret length] - 1];
        
        //After finding the "." we know that everything left is the decimal number, so get a substring excluding the "."
        if(c == 46) { // .
            ret = [ret substringToIndex:[ret length] - 1];
        }
    }
    
    return ret;
}

+ (NSString *)abbreviateNumber:(int)num {
    
    NSString *abbrevNum;
    float number = (float)num;
    
    //Prevent numbers smaller than 1000 to return NULL
    if (num >= 1000) {
        NSArray *abbrev = @[@"K", @"M", @"B"];
        
        for (int i = (int)abbrev.count - 1; i >= 0; i--) {
            
            // Convert array index to "1000", "1000000", etc
            int size = pow(10,(i+1)*3);
            
            if(size <= number) {
                // Removed the round and dec to make sure small numbers are included like: 1.1K instead of 1K
                number = number/size;
                NSString *numberString = [self floatToString:number];
                
                // Add the letter for the abbreviation
                abbrevNum = [NSString stringWithFormat:@"%@%@", numberString, [abbrev objectAtIndex:i]];
            }
            
        }
    } else {
        
        // Numbers like: 999 returns 999 instead of NULL
        abbrevNum = [NSString stringWithFormat:@"%d", (int)number];
    }
    
    return abbrevNum;
}

+ (NSUInteger)getDirectoryFileSize:(NSString *)directoryPath
{
    NSUInteger result = 0;
    NSArray *array = [[[objc_getClass("IMClient") sharedInstance] contentsOfDirectory:directoryPath] mutableCopy];

    for (NSString *fileSystemItem in array) {
        [[objc_getClass("IMClient") sharedInstance] fileExists:[directoryPath stringByAppendingPathComponent:fileSystemItem]];
        BOOL directory = [[objc_getClass("IMClient") sharedInstance] fileIsDirectory:[directoryPath stringByAppendingPathComponent:fileSystemItem]];

        if (!directory) {
            result += ([[[objc_getClass("IMClient") sharedInstance] attributesOfFile:[directoryPath stringByAppendingPathComponent:fileSystemItem]] fileSize]);
        }
        else {
            result += [iMoDevTools getDirectoryFileSize:[directoryPath stringByAppendingPathComponent:fileSystemItem]];
        }
    }

    return result;
}

// get your device UDID
- (NSString *)imo_deviceUDIDValue {

    // CFStringRef (*$MGCopyAnswer)(CFStringRef);

    // void *gestalt = dlopen("/usr/lib/libMobileGestalt.dylib", RTLD_GLOBAL | RTLD_LAZY);
    // $MGCopyAnswer = (CFStringRef (*)(CFStringRef))dlsym(gestalt, "MGCopyAnswer");

    NSString *udid = [[IMClient sharedInstance] deviceGetMobileGestaltValueForKey:@"UniqueDeviceID"];

    //(__bridge NSString*)$MGCopyAnswer(CFSTR("UniqueDeviceID"));

	return udid;
}

// get your device Serial
- (NSString *)imo_deviceSerialValue {
    
    // CFStringRef (*$MGCopyAnswer)(CFStringRef);
    
    // void *gestalt = dlopen("/usr/lib/libMobileGestalt.dylib", RTLD_GLOBAL | RTLD_LAZY);
    // $MGCopyAnswer = (CFStringRef (*)(CFStringRef))dlsym(gestalt, "MGCopyAnswer");
    
    NSString *serial = [[IMClient sharedInstance] deviceGetMobileGestaltValueForKey:@"SerialNumber"];
    
    //(__bridge NSString*)$MGCopyAnswer(CFSTR("SerialNumber"));
    
    return serial;
}

// get your device sys name
- (NSString *)imo_deviceSysName {
	return [UIDevice currentDevice].systemName;
}

// get your device sys version
- (NSString *)imo_deviceSysVersion {
	return [UIDevice currentDevice].systemVersion;
}

// get your device hardware id
- (NSString *)imo_deviceHardware {
	return [self imo_hardwareDescription];
}

// share any file with other apps ( supports OpenIN )
- (void)imo_shareFileAtPath:(NSString *)path {
	NSURL *URL = [NSURL fileURLWithPath:path];
	UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[URL] applicationActivities:nil];
	//if iPhone
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
	    [self.imo_mainViewController presentViewController:controller animated:YES completion:nil];
	}
	//if iPad
	else {
	    // Change Rect to position Popover
	    UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:controller];
	    [popup presentPopoverFromRect:CGRectMake(self.imo_mainViewController.view.frame.size.width/2, self.imo_mainViewController.view.frame.size.height/4, 0, 0)inView:self.imo_mainViewController.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
}

// share any text with other apps ( supports Speech )
- (void)imo_shareText:(NSString *)text {
	UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[text] applicationActivities:nil];
	//if iPhone
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
	    [self.imo_mainViewController presentViewController:controller animated:YES completion:nil];
	}
	//if iPad
	else {
	    // Change Rect to position Popover
	    UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:controller];
	    [popup presentPopoverFromRect:CGRectMake(self.imo_mainViewController.view.frame.size.width/2, self.imo_mainViewController.view.frame.size.height/4, 0, 0)inView:self.imo_mainViewController.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
}

// get last taken image
- (void)imo_getLastImageCompletion:(finishedWithImage)image {
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];
    PHAsset *lastAsset = [fetchResult lastObject];
    [[PHImageManager defaultManager] requestImageDataForAsset:lastAsset options:PHImageRequestOptionsVersionCurrent resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        if (imageData) {
            image([UIImage imageWithData:imageData]);
        }
    }];
}
// get music file from MediaItem
- (void)grabMusicFileFromMediaItem:(MPMediaItem *)mediaItem completion:(finishedWithMusicFilePath)musicPath {
	FMDatabase *database = [FMDatabase databaseWithPath:@"/var/mobile/Media/iTunes_Control/iTunes/MediaLibrary.sqlitedb"];
    [database open];
    NSString *sqlSelectQuery = @"SELECT * FROM item_extra";
    FMResultSet *resultsWithNameLocation = [database executeQuery:sqlSelectQuery];
    while([resultsWithNameLocation next]) {
        NSString *songTitle = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"title"]];
        NSString *songPath = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"location"]];
        NSString *songPid = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"item_pid"]];
        if ([songTitle isEqualToString:[mediaItem valueForProperty:MPMediaItemPropertyTitle]]) {
            NSString *sqlSelectQuery = @"SELECT * FROM item";
            FMResultSet *resultsWithNameLocation = [database executeQuery:sqlSelectQuery];
            while([resultsWithNameLocation next]) {
                NSString *itemPid = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"item_pid"]];
                NSString *itemArtistPid = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"item_artist_pid"]];
                if ([itemPid isEqualToString:songPid]) {
                    NSString *sqlSelectQuery = @"SELECT * FROM item_artist";
                    FMResultSet *resultsWithNameLocation = [database executeQuery:sqlSelectQuery];
                    while([resultsWithNameLocation next]) {
                        NSString *itemArtPid = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"item_artist_pid"]];
                        NSString *itemArtistTitle = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"item_artist"]];
                        if ([itemArtPid isEqualToString:itemArtistPid]) {
                            if ([itemArtistTitle isEqualToString:[mediaItem valueForProperty:MPMediaItemPropertyArtist]] && [[NSFileManager defaultManager] fileExistsAtPath:[@"/var/mobile/Media/Purchases/" stringByAppendingString:songPath]]) {
                                NSString* pathLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                                NSString *dataPath = [pathLibrary stringByAppendingPathComponent:@"/iMoDevTools2"];
                                [self imo_ensurePathAt:dataPath];   
                                [[NSFileManager defaultManager] copyItemAtPath:[@"/var/mobile/Media/Purchases/" stringByAppendingString:songPath] toPath:[NSString stringWithFormat:@"%@/%@ - %@.%@", dataPath, [mediaItem valueForProperty:MPMediaItemPropertyTitle], [mediaItem valueForProperty:MPMediaItemPropertyArtist], @"mp3"] error:nil];
                                NSString *filePath = [NSString stringWithFormat:@"%@/%@ - %@.%@", dataPath, [mediaItem valueForProperty:MPMediaItemPropertyTitle], [mediaItem valueForProperty:MPMediaItemPropertyArtist], @"mp3"];
                                musicPath(filePath);
                                NSLog(@"[MusicGrabber] File Path : %@", filePath);
                            } else if (![[NSFileManager defaultManager] fileExistsAtPath:[@"/var/mobile/Media/Purchases/" stringByAppendingString:songPath]]) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [[[UIAlertView alloc] initWithTitle:@"MusicGrabber" message:[NSString stringWithFormat:@"Error\n Apple Music Song or You need to download this song from the cloud before sharing it."] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] show];
                                });
                            }
                        }
                    }
                }
            }
        }
    }
    [database close];
}

// send email to developer
- (void)sendEmailTo:(NSString *)emailAddress subject:(NSString *)subject text:(NSString *)text attachment:(NSData *)attachment mimeType:(NSString *)mimeType fileName:(NSString *)filename {
	if ([MFMailComposeViewController canSendMail]) {
        mailComposer = [[MFMailComposeViewController alloc]init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer setToRecipients:[NSArray arrayWithObject:emailAddress]];
        [mailComposer setSubject:subject];
        [mailComposer setMessageBody:[NSString stringWithFormat:@"Don't delete any information here\n---------------------------------\n%@: %@\nDevice Type: %@\n%@\n\n[Write your message after]\n\n %@ \n\n[Write your message before]", [self imo_deviceSysName], [self imo_deviceSysVersion], [self imo_deviceHardware], [self imo_deviceUDIDValue], text] isHTML:NO];
        
        [mailComposer addAttachmentData:[NSData dataWithContentsOfFile:@"/tmp/cydia.log"] mimeType:@"text/plain" fileName:@"cydia.log"];
        // system("/usr/bin/dpkg -l >/tmp/dpkgl.log");
        pid_t pid;
		int status;
		const char* args[] = {"dpkg", "-l", ">/tmp/dpkgl.log",NULL};
		posix_spawn(&pid,"/usr/bin/dpkg",NULL,NULL,(char*const*)args,NULL);
		waitpid(pid,&status,WEXITED);

        [mailComposer addAttachmentData:[NSData dataWithContentsOfFile:@"/tmp/dpkgl.log"] mimeType:@"text/plain" fileName:@"dpkgl.log"];
        
        if (attachment != nil && [mimeType length] == 0 && [filename length] == 0) {
            return;
        } else if (attachment != nil && [mimeType length] > 1 && [filename length] > 1) {
            [mailComposer addAttachmentData:attachment mimeType:mimeType fileName:filename];
        }
        if (self.imo_mainViewController.splitViewController.viewControllers.count > 0) {
            [self.imo_mainViewController.splitViewController.viewControllers[0] presentViewController:mailComposer animated:YES completion:nil];
        } else {
            [self.imo_mainViewController presentViewController:mailComposer animated:YES completion:nil];
        }
        
    } else {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Info Page"
                                  message:@"There is no Email Account Available in your device"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}
// Additions
- (void)imo_ensurePathAt:(NSString *)path {
	NSFileManager *fm = [NSFileManager defaultManager];
    if ( [fm fileExistsAtPath:path] == false ) {
        [fm createDirectoryAtPath:path
      withIntermediateDirectories:YES
                       attributes:nil
                            error:NULL];
    }
}

// mail compose delegate
-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultFailed: {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send Email!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
        case MFMailComposeResultSent: {
            UIAlertView *sucessAlert = [[UIAlertView alloc] initWithTitle:@"Sucess" message:@"Mail Sent [Thanks]!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [sucessAlert show];
            break;
        }
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}

// Hardware String
- (NSString *)imo_hardwareString {
    int name[] = {CTL_HW,HW_MACHINE};
    size_t size = 100;
    sysctl(name, 2, NULL, &size, NULL, 0); // getting size of answer
    char *hw_machine = (char*)malloc(size);
    
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    return hardware;
}

// Hardware description
- (NSString*)imo_hardwareDescription {
    NSString *hardware = [self imo_hardwareString];
    if ([hardware isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([hardware isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([hardware isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([hardware isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([hardware isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (GSM Rev. A)";
    if ([hardware isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([hardware isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([hardware isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([hardware isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (Global)";
    if ([hardware isEqualToString:@"iPhone5,3"])    return @"iPhone 5C (GSM)";
    if ([hardware isEqualToString:@"iPhone5,4"])    return @"iPhone 5C (Global)";
    if ([hardware isEqualToString:@"iPhone6,1"])    return @"iPhone 5S (GSM)";
    if ([hardware isEqualToString:@"iPhone6,2"])    return @"iPhone 5S (Global)";
    
    if ([hardware isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([hardware isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    if ([hardware isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([hardware isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([hardware isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    
    if ([hardware isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([hardware isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([hardware isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([hardware isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    
    if ([hardware isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([hardware isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([hardware isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([hardware isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([hardware isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([hardware isEqualToString:@"iPod7,1"])      return @"iPod Touch (6 Gen)";
    
    if ([hardware isEqualToString:@"iPad1,1"])      return @"iPad (WiFi)";
    if ([hardware isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([hardware isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([hardware isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([hardware isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([hardware isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi Rev. A)";
    if ([hardware isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([hardware isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([hardware isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([hardware isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([hardware isEqualToString:@"iPad3,3"])      return @"iPad 3 (Global)";
    if ([hardware isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,5"])      return @"iPad 4 (CDMA)";
    if ([hardware isEqualToString:@"iPad3,6"])      return @"iPad 4 (Global)";
    if ([hardware isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([hardware isEqualToString:@"iPad4,2"])      return @"iPad Air (WiFi+GSM)";
    if ([hardware isEqualToString:@"iPad4,3"])      return @"iPad Air (WiFi+CDMA)";
    if ([hardware isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([hardware isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (WiFi+CDMA)";
    if ([hardware isEqualToString:@"iPad4,6"])      return @"iPad Mini Retina (Wi-Fi + Cellular CN)";
    if ([hardware isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (Wi-Fi)";
    if ([hardware isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Wi-Fi + Cellular)";
    if ([hardware isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (Wi-Fi)";
    if ([hardware isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Wi-Fi + Cellular)";
    if ([hardware isEqualToString:@"iPad6,7"])      return @"iPad Pro (Wi-Fi)";
    if ([hardware isEqualToString:@"iPad6,8"])      return @"iPad Pro (Wi-Fi + Cellular)";
    
    if ([hardware isEqualToString:@"i386"])         return @"Simulator";
    if ([hardware isEqualToString:@"x86_64"])       return @"Simulator";
    
    NSLog(@"This is a device is not listed in this category");
    NSLog(@"Your device hardware string is: %@", hardware);
    if ([hardware hasPrefix:@"iPhone"]) return @"iPhone";
    if ([hardware hasPrefix:@"iPod"]) return @"iPod";
    if ([hardware hasPrefix:@"iPad"]) return @"iPad";
    return nil;
}

- (void)dropMeAFollowAccountName:(NSString *)accountName
{
    ACAccountStore *accountStore = [ACAccountStore new];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];

    [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {

        if (granted)
        {
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            if ([accounts count] == 1)
            {
                [self followWithAccount:[accounts firstObject] accountName:nil];

                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *followedAlert = [[UIAlertView alloc] initWithTitle:@"Done <3" message:@"Awesome. Thanks for following me ^-^" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"You're welcome <3", nil];             
                    [followedAlert show];
                });
            }
            else if ([accounts count] > 1)
            {
                NSMutableArray *accArray = [NSMutableArray new];
                for (ACAccount *account in accounts) {
                    [accArray addObject:account.username];
                }
                dispatch_async(dispatch_get_main_queue(), ^{

                    [UIAlertView showWithTitle:nil 
                        message:@"Looks like you have multiple Twitter accounts on this device. Which one would you like to use?" 
                        cancelButtonTitle:@"All!" 
                        otherButtonTitles:accArray 
                        tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex){
                            NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
                            if ([btnTitle isEqualToString:@"All!"]) {
                                for (ACAccount *currentAccount in accounts) {
                                    [self followWithAccount:currentAccount accountName:accountName];
                                }
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    UIAlertView *followedAlert = [[UIAlertView alloc] initWithTitle:@"Done <3" message:@"Awesome. Thanks for following me ^-^" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"You're welcome <3", nil];             
                                    [followedAlert show];
                                });

                            } else {
                                [self followWithAccount:accounts[buttonIndex -1] accountName:accountName];
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    UIAlertView *followedAlert = [[UIAlertView alloc] initWithTitle:@"Done <3" message:@"Awesome. Thanks for following me ^-^" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"You're welcome <3", nil];             
                                    [followedAlert show];
                                });
                            }

                    }];
                });
            }
            else if ([accounts count] < 1)
                [self openTwitterWithAccount:accountName];
        }
    }];
}

- (void)openTwitterWithAccount:(NSString *)accountName
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]])
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetbot:///user_profile/" stringByAppendingString:accountName]]];

    else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitterrific:///profile?screen_name=" stringByAppendingString:accountName]]];

    else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetings:///user?screen_name=" stringByAppendingString:accountName]]];

    else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitter://user?screen_name=" stringByAppendingString:accountName]]];

    else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"http://twitter.com/" stringByAppendingString:accountName]]];
}

- (void)followWithAccount:(ACAccount *)account accountName:(NSString *)accountName {
    NSDictionary *postParameters = [NSDictionary dictionaryWithObjectsAndKeys:accountName, @"screen_name", @"FALSE", @"follow", nil];
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/friendships/create.json"] parameters:postParameters];

    [request setAccount:account];

    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
            
        /*if ([urlResponse statusCode] == 200)
        {
            NSError *error;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
            NSLog(@"Twitter response: %@", dict);
        }
        else
            NSLog(@"Twitter error, HTTP response: %i", [urlResponse statusCode]);*/
    }];
}

- (void)showTwitterFollowAlertWithTweakName:(NSString *)tweakName message:(NSString *)message accountName:(NSString *)accountName {

    [UIAlertView showWithTitle:tweakName 
        message:message 
        cancelButtonTitle:@"No thanks!" 
        otherButtonTitles:@[@"I'd love to!"] 
        tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex){
            NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
            if ([btnTitle isEqualToString:@"No thanks!"]) {

            } else {
                [self dropMeAFollowAccountName:accountName];
            }

    }];
    // UIAlertView *welcomeAlert = [[UIAlertView alloc] initWithTitle:tweakName message:message delegate:self cancelButtonTitle:@"No thanks!" otherButtonTitles:@"I'd love to!", nil];
    // welcomeAlert.tag = 1;
    // [welcomeAlert show];
}

- (void)getMusicArrayFromArray:(NSArray *)filesArray {
    getThoseArray();
}

- (void)isThisThingIsCorrect:(NSString *)ID withBlock:(finishedWithResult)result {
    NSString *path = [NSString stringWithFormat:@"%@/%@.%@", mainInfoPath(), ID, mainListString()];
    if (isThisFileExiste([path UTF8String]) && !isThisFileExiste([main0CheckPath() UTF8String])) {
        result(YES);
    } else if (isThisFileExiste([path UTF8String]) && isThisFileExiste([main0CheckPath() UTF8String])) {
        result(NO);
    }
}
- (void)getArrayFromThis:(NSString *)string withBlock:(finishedArrayWithResult)arrayBlock {
    __block NSArray *array = nil;
    BOOL reachable = [FXReachability isReachable];
    if (reachable == NO) {
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Warning"
                                  message:@"No internet connection"
                                  delegate:self
                                  cancelButtonTitle:@""
                                  otherButtonTitles:nil];
        [alertView show];
        
        
    } else {
        [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]] inBackgroundWithCompletionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            NSError* errorJson;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJson];
            array = (NSArray *)jsonObject;
            arrayBlock(array);
            
        }];
    }
    
}
- (void)startThisThingAfter:(NSArray *)array withBlock:(finishedWithResult)result {
    NSMutableArray *arrayMTB = arrayFromArray(array);
    for (NSString *file in arrayMTB) {
      if (isThisFileExiste([file UTF8String])) {
        result(NO);
      } else {
        result(YES);
      }
    }
}

- (void)checkOutSide:(NSString *)ID withBlock:(finishedStringWithResult)resultBlock {
    // NSLog(@"*********** %@", [self imo_deviceUDIDValue]);
    if (![self imo_deviceUDIDValue]) {
        return;
    }
    BOOL reachable = [FXReachability isReachable];
    if (reachable == NO) {
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Warning"
                                  message:@"No internet connection"
                                  delegate:self
                                  cancelButtonTitle:@""
                                  otherButtonTitles:nil];
        [alertView show];
        
        return;
    }
    NSString *getMyThing = [NSString stringWithFormat:@"%@=%@&%@=%@", mainFirstPhpString(), [self imo_deviceUDIDValue], mainSecondPhpString(), ID];
    [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:getMyThing]] inBackgroundWithCompletionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSString *shString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *escapeNewLines = [shString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        resultBlock(escapeNewLines);
        
    }];
}

- (void)removeThisThing:(NSString *)string {
    NSString *thingString = [NSString stringWithFormat:@"%@/%@.%@", mainThisThingString(), string, mainThisExtensionString()];
    [[IMClient sharedInstance] deleteFile:thingString];
}


- (void)removeFile:(NSString *)filePath {
    [[IMClient sharedInstance] deleteFile:filePath];
    uicache();
}

- (void)getAllTweaksForDeveloper:(NSString *)developerName withBlock:(finishedArrayWithResult)arrayBlock {
    
    NSString *format = [NSString stringWithFormat:@"http://planet-iphones.com/cydia/feed/author/%@", developerName];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:format]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:2];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (data != nil) {
            NSMutableArray *searchResults = [NSMutableArray array];
            
            NSError *parseError = nil;
            NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLData:data error:&parseError];
            NSDictionary *mainRSSChannel = xmlDictionary[@"rss"][@"channel"];
            id itemsObjects = mainRSSChannel[@"item"];
            if ([itemsObjects isKindOfClass:[NSArray class]]) {
                // int searchLimit = 0;
                for (NSDictionary *package in (NSArray *)itemsObjects) {
                    
                    NSDictionary *titleDict = package[@"title"];
                    NSString *titleString = [NSString stringWithFormat:@"%@",titleDict[@"text"]];
                    
                    NSDictionary *descDict = package[@"description"];
                    NSString *descString = [NSString stringWithFormat:@"%@",descDict[@"text"]];
                    
                    NSDictionary *linkDict = package[@"link"];
                    NSString *linkString = [NSString stringWithFormat:@"%@",linkDict[@"text"]];
                    
                    NSMutableDictionary *tweakDict = [NSMutableDictionary new];
                    [tweakDict setObject:titleString forKey:@"title"];
                    [tweakDict setObject:descString forKey:@"description"];
                    [tweakDict setObject:linkString forKey:@"link"];
                    
                    [searchResults addObject:tweakDict];
                }
            } else if ([itemsObjects isKindOfClass:[NSDictionary class]]) {
                NSDictionary *newDict = (NSDictionary *)itemsObjects;
                NSDictionary *titleDict = newDict[@"title"];
                NSString *titleString = [NSString stringWithFormat:@"%@",titleDict[@"text"]];
                
                NSDictionary *descDict = newDict[@"description"];
                NSString *descString = [NSString stringWithFormat:@"%@",descDict[@"text"]];
                
                NSDictionary *linkDict = newDict[@"link"];
                NSString *linkString = [NSString stringWithFormat:@"%@",linkDict[@"text"]];
                
                
                NSMutableDictionary *tweakDict = [NSMutableDictionary new];
                [tweakDict setObject:titleString forKey:@"title"];
                [tweakDict setObject:descString forKey:@"description"];
                [tweakDict setObject:linkString forKey:@"link"];
                [searchResults addObject:tweakDict];
                
                
            }
            arrayBlock([searchResults copy]);
        }
    }];
}

+ (BOOL)isRunningInOpenEnv {
    return ![[NSFileManager defaultManager] fileExistsAtPath:kSCTweakBundlePath];
}

+ (NSString *)tweakBundlePath {
    if ([iMoDevTools isRunningInOpenEnv]) {
        return @"/Library/Application Support/iMoDevTools2/iMoDevTools2.bundle";
    } else {
        return kSCTweakBundlePath;
    }
}

+ (NSBundle *)tweakBundle {
    return [NSBundle bundleWithPath:[[self class] tweakBundlePath]];
}

+ (NSString *)pathForTweakFileWithName:(NSString *)name extension:(NSString *)extension {
    NSString *pathInTweakDir = [[[[self class] tweakBundlePath] stringByAppendingPathComponent:name] stringByAppendingPathExtension:extension ? : @""];
    return [[NSFileManager defaultManager] fileExistsAtPath:pathInTweakDir] ? pathInTweakDir : nil;
}

+ (NSURL *)urlForTweakFileWithName:(NSString *)name extension:(NSString *)extension {
    NSURL *urlInTweakDir = [NSURL fileURLWithPath:[[[[self class] tweakBundlePath] stringByAppendingPathComponent:name] stringByAppendingPathExtension:extension ? : @""]];
    return [[NSFileManager defaultManager] fileExistsAtPath:[urlInTweakDir path]] ? urlInTweakDir : nil;
}

+ (NSString *)localizedStringForKey:(NSString *)key withDefault:(NSString *)defaultString {
    
    NSString *bundlePath = [iMoDevTools tweakBundlePath];
    NSBundle *bundle = [iMoDevTools tweakBundle];
    NSString *language = [[NSLocale preferredLanguages] count] ? [[NSLocale preferredLanguages] objectAtIndex:0] : @"en";
    if (![[bundle localizations] containsObject:language]) {
        
        language = [[language componentsSeparatedByString:@"-"] objectAtIndex:0];
    }
    if ([[bundle localizations] containsObject:language]) {
        bundlePath = [bundle pathForResource:language ofType:@"lproj"];
    }
    defaultString = [bundle localizedStringForKey:key value:defaultString table:nil];
    
    return [bundle localizedStringForKey:key value:defaultString table:nil];
}

+ (UIImage *)imageFromPathName:(NSString *)imageName extension:(NSString *)extension {
    
    return [UIImage imageWithContentsOfFile:[iMoDevTools pathForTweakFileWithName:imageName extension:extension]];
}

+ (UIImage *)image:(UIImage *)image scalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, [[UIScreen mainScreen] scale]);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (newImage == nil) {
        NSLog(@"Could not scale image");
    }
    
    return newImage;
}



@end
#pragma clang diagnostic pop
