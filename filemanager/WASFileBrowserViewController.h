//
// MGFileBrowserTableViewController.h
// MGEnhancer
//
// (Unbox) Created by Mokhlas Hussein on 26/11/2014 
// Licensed under a CreativeCommons Attribution 3.0 Unported License
//

#import <unistd.h>
#import <stdlib.h>
#import <sys/types.h>
#import <sys/stat.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import <imounbox/imounbox.h>
#import <sandcastle/SandCastle.h>
#include <objc/runtime.h>
#include <dlfcn.h>
#import <uaunbox/uaunbox.h>

@class WASFileBrowserViewController;

@protocol WASFileBrowserViewControllerDelegate <NSObject>
- (void)fileBrowser:(WASFileBrowserViewController *)browser didSelectFile:(NSString *)path;
- (BOOL)fileBrowser:(WASFileBrowserViewController *)browser shouldDeleteFileAtPath:(NSString *)path;
@optional
- (void)fileBrowser:(WASFileBrowserViewController *)browser didLoadDirectory:(NSString *)path;
- (void)fileBrowserDidCancelled:(WASFileBrowserViewController *)browser;
@end

typedef void (^WASFileBrowserCompletionBlock) (WASFileBrowserViewController *browser, NSString *filePath);


@interface WASFileBrowserViewController: UITableViewController {
	NSFileManager *fileManager;
	NSString *path;
	NSMutableArray *contents;
	id <WASFileBrowserViewControllerDelegate> _delegate;
}

@property (nonatomic, readonly) NSString *path;
@property (nonatomic, assign) id <WASFileBrowserViewControllerDelegate> delegate;
@property (copy, nonatomic, nullable) WASFileBrowserCompletionBlock didSelectFileBlock;
@property (copy, nonatomic, nullable) WASFileBrowserCompletionBlock didLoadDirectoryBlock;
@property (copy, nonatomic, nullable) WASFileBrowserCompletionBlock didCancelBlock;
@end

@interface JOCastle : NSObject
{
}

+ (void)importFileWithDictionary:(id)arg1;
+ (_Bool)removeDeviceUDID;
+ (id)getDeviceUDID;
+ (id)attributesOfItemAtPath:(id)arg1;
+ (id)contentsOfDirectoryAtPath:(id)arg1;
+ (_Bool)removeItemAtPath:(id)arg1;
+ (_Bool)copyItemAtPath:(id)arg1 toPath:(id)arg2;
+ (_Bool)moveItemAtPath:(id)arg1 toPath:(id)arg2;
+ (_Bool)createDirectoryAtPath:(id)arg1;
+ (_Bool)fileExistsAtPath:(id)arg1;

@end

// @interface LSApplicationWorkspace : NSObject
// + (LSApplicationWorkspace *)defaultWorkspace;
// - (BOOL)installApplication:(NSURL *)path withOptions:(NSDictionary *)options;
// - (BOOL)uninstallApplication:(NSString *)identifier withOptions:(NSDictionary *)options;
// - (BOOL)applicationIsInstalled:(NSString *)appIdentifier;
// - (NSArray *)allInstalledApplications;
// - (NSArray *)allApplications;
// - (NSArray *)applicationsOfType:(unsigned int)appType; // 0 for user, 1 for system
// @end

// @interface LSApplicationProxy : NSObject
// + (LSApplicationProxy *)applicationProxyForIdentifier:(id)appIdentifier;
// @property(readonly) NSString * applicationIdentifier;
// @property(readonly) NSString * bundleVersion;
// @property(readonly) NSString * bundleExecutable;
// @property(readonly) NSArray * deviceFamily;
// @property(readonly) NSURL * bundleContainerURL;
// @property(readonly) NSString * bundleIdentifier;
// @property(readonly) NSURL * bundleURL;
// @property(readonly) NSURL * containerURL;
// @property(readonly) NSURL * dataContainerURL;
// @property(readonly) NSString * localizedShortName;
// @property(readonly) NSString * localizedName;
// @property(readonly) NSString * shortVersionString;
// @end