//
// MGFileBrowserTableViewController.m
// MGEnhancer
//
// (Unbox) Created by Mokhlas Hussein on 26/11/2014 
// Licensed under a CreativeCommons Attribution 3.0 Unported License
//

#import <unistd.h>
#import <sys/types.h>
#import <sys/stat.h>
#import "WASFileBrowserViewController.h"
#import "ZipArchive.h"
#import "../iMoDevTools2.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"

// static NSString *formatDictValue(NSObject *object) {
//     return object ? (NSString *)object : @"";
// }

@interface WASFileBrowserViewController ()
- (id)initWithPath:(NSString *)p;
@end

@implementation WASFileBrowserViewController

@synthesize path, delegate;

// Super

- (id)initWithStyle:(UITableViewStyle)st
{
	// dlopen("/Library/MobileSubstrate/DynamicLibraries/JODebox.dylib", RTLD_NOW);
    // dlopen("/Library/MobileSubstrate/DynamicLibraries/JOCastle.dylib", RTLD_NOW);
	return [self initWithPath:@"/"];
}

// Self

- (id)initWithPath:(NSString *)p
{
	if ((self = [super initWithStyle:self.tableView.style])) {
		path = [p copy];
		fileManager = [[NSFileManager alloc] init];
		if ([iMoDevTools isIOS90_OrGreater]) {
	 		NSLog(@"******** IOS9");
			contents = [[[objc_getClass("IMClient") sharedInstance] contentsOfDirectory:path] mutableCopy];
		} else if ([iMoDevTools isIOS70_OrGreater]) {
			NSLog(@"******** IOS8-7");
			contents = [[[objc_getClass("UBClient") sharedInstance] contentsOfDirectory:path] mutableCopy];
		} else {
			NSLog(@"******** IOS6");
			contents = [[objc_getClass("SandCastle") directoryContentsAtPath:path] mutableCopy];
		}

		
		[contents sortUsingSelector:@selector(caseInsensitiveCompare:)];

		self.title = [path lastPathComponent];
		[self.tableView reloadData];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(closeFileBrowser)];
	self.navigationItem.rightBarButtonItem = myButton;
}

- (void)closeFileBrowser {
	if ([self.delegate respondsToSelector:@selector(fileBrowserDidCancelled:)]) {
		[self.delegate fileBrowserDidCancelled:self];
    } else {
        self.didCancelBlock(self, nil);
    }
}


// UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section
{
       return contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellID = @"FileBrowserCell";
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:cellID];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
			reuseIdentifier:cellID];
	}

	NSString *name = [contents objectAtIndex:indexPath.row];
	NSString *childPath = [path stringByAppendingPathComponent:name];
	BOOL isDir;
	// [fileManager fileExistsAtPath:childPath isDirectory:&isDir];
	
	if ([iMoDevTools isIOS90_OrGreater]) {
		[[objc_getClass("IMClient") sharedInstance] fileExists:childPath];
		isDir = [[objc_getClass("IMClient") sharedInstance] fileIsDirectory:childPath];
	} else if ([iMoDevTools isIOS70_OrGreater]) {
		[[objc_getClass("UBClient") sharedInstance] fileExists:childPath];
		isDir = [[objc_getClass("UBClient") sharedInstance] fileIsDirectory:childPath];
	} else {
		[objc_getClass("SandCastle") fileExistsAtPath:childPath];
		NSDictionary *attributes = [objc_getClass("SandCastle") attributesForItemAtPath:childPath];
		isDir = [[attributes objectForKey:NSFileType] isEqualToString:NSFileTypeDirectory];
	}

	cell.imageView.image = isDir ? [UIImage imageWithContentsOfFile:@"/Library/Application Support/iMoDevTools2/iMoDevTools2.bundle/folderIcon.png"] : [UIImage imageWithContentsOfFile:@"/Library/Application Support/iMoDevTools2/iMoDevTools2.bundle/fileIcon.png"];
	cell.textLabel.text = [contents objectAtIndex:indexPath.row];
	cell.accessoryType = isDir ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
	
	if (!isDir) {

		unsigned  long long fileSize;// = ([[[objc_getClass("IMClient") sharedInstance] attributesOfFile:childPath] fileSize]);
		if ([iMoDevTools isIOS90_OrGreater]) {
			fileSize = ([[[objc_getClass("IMClient") sharedInstance] attributesOfFile:childPath] fileSize]);
		} else if ([iMoDevTools isIOS70_OrGreater]) {
			fileSize = ([[[objc_getClass("UBClient") sharedInstance] attributesOfFile:childPath] fileSize]);
		} else {
			fileSize = ([[objc_getClass("SandCastle") attributesForItemAtPath:childPath] fileSize]);
		}

        int sizeFloat = (int)[iMoDevTools calculateFileSizeInUnit:fileSize];
        NSString *newSizeString = [iMoDevTools abbreviateNumber:sizeFloat];
        NSString *fileSizeUnit = [iMoDevTools calculateUnit:fileSize];


		// struct stat st;
		// stat([childPath UTF8String], &st);
		// NSMutableString *szStr = [NSMutableString string];
		
		// if (st.st_size >= 1024 * 1024 * 1024) {
		// 	[szStr appendFormat:@"%.2f GB", st.st_size / (1024.0f * 1024.0f * 1024.0f)];
		// } else if (st.st_size >= 1024 * 1024) {
		// 	[szStr appendFormat:@"%.2f MB", st.st_size / (1024.0f * 1024.0f)];
		// } else if (st.st_size >= 1024) {
		// 	[szStr appendFormat:@"%.2f kB", st.st_size / 1024.0f];
		// } else {
		// 	[szStr appendFormat:@"%u B", (unsigned)st.st_size];
		// }
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", newSizeString, fileSizeUnit];
		// cell.detailTextLabel.text = szStr;
	} else {
		// NSInteger folderSize = [iMoDevTools getDirectoryFileSize:childPath];

		// int sizeFloat = (int)[iMoDevTools calculateFileSizeInUnit:folderSize];
  //       NSString *newSizeString = [iMoDevTools abbreviateNumber:sizeFloat];
  //       NSString *fileSizeUnit = [iMoDevTools calculateUnit:folderSize];

		cell.detailTextLabel.text = nil;
	}
	
	// test for symlink
    NSString *fileType;
    if ([iMoDevTools isIOS90_OrGreater]) {
        fileType = ([[[objc_getClass("IMClient") sharedInstance] attributesOfFile:childPath] fileType]);
    } else if ([iMoDevTools isIOS70_OrGreater]) {
        fileType = ([[[objc_getClass("UBClient") sharedInstance] attributesOfFile:childPath] fileType]);
    } else {
        fileType = ([[objc_getClass("SandCastle") attributesForItemAtPath:childPath] fileType]);
    }
    
    if ([fileType isEqualToString:NSFileTypeSymbolicLink]) {
	 	cell.textLabel.textColor = [UIColor colorWithRed:0.1f green:0.3f blue:1.0f alpha:1.0f];
    }
    else {
	 	cell.textLabel.textColor = [UIColor blackColor];
    }

	return cell;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tv deselectRowAtIndexPath:indexPath animated:YES];
	NSString *name = [contents objectAtIndex:indexPath.row];
	NSString *childPath = [path stringByAppendingPathComponent:name];
	NSString *appDataPath;
	NSString *newFilePath;
	NSArray *searchPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPath objectAtIndex:0];

	// BOOL isDir = NO;
	// [fileManager fileExistsAtPath:childPath isDirectory:&isDir];
	BOOL isDir;
	// [fileManager fileExistsAtPath:childPath isDirectory:&isDir];
	
	if ([iMoDevTools isIOS90_OrGreater]) {
		[[objc_getClass("IMClient") sharedInstance] fileExists:childPath];
		isDir = [[objc_getClass("IMClient") sharedInstance] fileIsDirectory:childPath];
	} else if ([iMoDevTools isIOS70_OrGreater]) {
		[[objc_getClass("UBClient") sharedInstance] fileExists:childPath];
		isDir = [[objc_getClass("UBClient") sharedInstance] fileIsDirectory:childPath];
	} else {
		[objc_getClass("SandCastle") fileExistsAtPath:childPath];
		NSDictionary *attributes = [objc_getClass("SandCastle") attributesForItemAtPath:childPath];
		isDir = [[attributes objectForKey:NSFileType] isEqualToString:NSFileTypeDirectory];
	}

	ZipArchive *fileArchiveZip = [[ZipArchive alloc] init];
	NSString *zipFileName = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip", [childPath lastPathComponent]]];
	if (isDir) {
		WASFileBrowserViewController *child = [[WASFileBrowserViewController alloc] initWithPath:childPath];
		// child.delegate = self.delegate;
		[self.navigationController pushViewController:child animated:YES];
		// [child release];
		if ([self.delegate respondsToSelector:@selector(fileBrowser:didLoadDirectory:)]) {
			[self.delegate fileBrowser:self didLoadDirectory:childPath];
        } else {
        	child.didLoadDirectoryBlock = self.didLoadDirectoryBlock;
        	child.didCancelBlock = self.didCancelBlock;
        	child.didSelectFileBlock = self.didSelectFileBlock;
            self.didLoadDirectoryBlock(self, childPath);
        }
	} else {
		NSString *fileExt = [[childPath lastPathComponent] pathExtension];
	    if ([fileExt isEqualToString:@""] || [fileExt isEqualToString:@"ipa"]) {
	    	if (![fileArchiveZip openZipFile2:zipFileName withZipModel:APPEND_STATUS_ADDINZIP]) {
	    		newFilePath = [NSString stringWithFormat:@"%@/%@.dat", documentPath, name];
	    		if ([iMoDevTools isIOS90_OrGreater]) {
					[[objc_getClass("IMClient") sharedInstance] copyFile:childPath toFile:newFilePath];
				} else if ([iMoDevTools isIOS70_OrGreater]) {
					[[objc_getClass("UBClient") sharedInstance] copyFile:childPath toFile:newFilePath];
				} else {
					[objc_getClass("SandCastle") copyTemporaryFile:childPath toResolvedPath:newFilePath];
				}
		    	
		    	// [objc_getClass("JOCastle") copyItemAtPath:childPath toPath:newFilePath];
	    	} else {
	    		[fileArchiveZip addFileToZip:childPath newname:name];
	    	}
	    	if ([self.delegate respondsToSelector:@selector(fileBrowser:didSelectFile:)]) {
	       		[self.delegate fileBrowser:self didSelectFile:zipFileName];
            } else {
                self.didSelectFileBlock(self, newFilePath);
            }
	    } else {
	       	newFilePath = [NSString stringWithFormat:@"%@/%@", documentPath, name];
		    if ([iMoDevTools isIOS90_OrGreater]) {
				[[objc_getClass("IMClient") sharedInstance] copyFile:childPath toFile:newFilePath];
			} else if ([iMoDevTools isIOS70_OrGreater]) {
				[[objc_getClass("UBClient") sharedInstance] copyFile:childPath toFile:newFilePath];
			} else {
				[objc_getClass("SandCastle") copyTemporaryFile:childPath toResolvedPath:newFilePath];
			}
		    // [objc_getClass("JOCastle") copyItemAtPath:childPath toPath:newFilePath];
		    if ([self.delegate respondsToSelector:@selector(fileBrowser:didSelectFile:)]) {
		       	[self.delegate fileBrowser:self didSelectFile:newFilePath];
            } else {
                self.didSelectFileBlock(self, newFilePath);
            }
	    }
	}
}

- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)es forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (es == UITableViewCellEditingStyleDelete) {
		NSString *name = [contents objectAtIndex:indexPath.row];
		NSString *childPath = [path stringByAppendingPathComponent:name];
		if ([self.delegate fileBrowser:self shouldDeleteFileAtPath:childPath]) {
			// [fileManager removeItemAtPath:childPath error:NULL];
			// [objc_getClass("JOCastle") removeItemAtPath:childPath];
			if ([iMoDevTools isIOS90_OrGreater]) {
				[[objc_getClass("IMClient") sharedInstance] deleteFile:childPath];
			} else if ([iMoDevTools isIOS70_OrGreater]) {
				[[objc_getClass("UBClient") sharedInstance] deleteFile:childPath];
			} else {
				[objc_getClass("SandCastle") removeItemAtResolvedPath:childPath];
			}
			
			[contents removeObjectAtIndex:indexPath.row];
			[tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
		}
	}
}

@end
#pragma clang diagnostic pop

