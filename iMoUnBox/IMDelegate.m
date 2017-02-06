#import "IMDelegate.h"
#import "rocketbootstrap.h"

@interface UIDevice (_P_API)
- (id)_deviceInfoForKey:(NSString *)key;
@end

@implementation IMDelegate

- (id)init
{
	if ((self = [super init])) {
		center = [CPDistributedMessagingCenter centerNamed:@"com.imokhles.imounbox"];
		rocketbootstrap_distributedmessagingcenter_apply(center);
		[center runServerOnCurrentThread];

		[center registerForMessageName:@"com.imokhles.imounbox.move" target:self selector:@selector(handleMessageNamed:userInfo:)];
		[center registerForMessageName:@"com.imokhles.imounbox.copy" target:self selector:@selector(handleMessageNamed:userInfo:)];
		[center registerForMessageName:@"com.imokhles.imounbox.symlink" target:self selector:@selector(handleMessageNamed:userInfo:)];
		[center registerForMessageName:@"com.imokhles.imounbox.delete" target:self selector:@selector(handleMessageNamed:userInfo:)];
		[center registerForMessageName:@"com.imokhles.imounbox.attributes" target:self selector:@selector(handleMessageNamed:userInfo:)];
		[center registerForMessageName:@"com.imokhles.imounbox.dircontents" target:self selector:@selector(handleMessageNamed:userInfo:)];
		[center registerForMessageName:@"com.imokhles.imounbox.chmod" target:self selector:@selector(handleMessageNamed:userInfo:)];
		[center registerForMessageName:@"com.imokhles.imounbox.exists" target:self selector:@selector(handleMessageNamed:userInfo:)];
		[center registerForMessageName:@"com.imokhles.imounbox.isdir" target:self selector:@selector(handleMessageNamed:userInfo:)];
		[center registerForMessageName:@"com.imokhles.imounbox.mkdir" target:self selector:@selector(handleMessageNamed:userInfo:)];
		[center registerForMessageName:@"com.imokhles.imounbox.getdevicemobilegestalt" target:self selector:@selector(handleMessageNamed:userInfo:)];
		fileManager = [[NSFileManager alloc] init];
		device = [UIDevice currentDevice];
	}
	return self;
}

- (void)dealloc
{
	[fileManager release];
	[super dealloc];
}

- (NSDictionary *)handleMessageNamed:(NSString *)name userInfo:(NSDictionary *)info
{
	NSString *sourceFile = [info objectForKey:@"IMSourceFile"];
	NSString *targetFile = [info objectForKey:@"IMTargetFile"];
	NSNumber *modeNumber = [info objectForKey:@"IMFileMode"];
	NSString *deviceSecretKey = [info objectForKey:@"IMDeviceKEY"];

	const char *source = [sourceFile UTF8String];
	const char *target = [targetFile UTF8String];
	mode_t mode = [modeNumber intValue];
	NSMutableDictionary *result = [NSMutableDictionary dictionary];

	if ([name isEqualToString:@"com.imokhles.imounbox.move"]) {
		[fileManager moveItemAtPath:sourceFile toPath:targetFile error:NULL];
	} else if ([name isEqualToString:@"com.imokhles.imounbox.copy"]) {
		[fileManager copyItemAtPath:sourceFile toPath:targetFile error:NULL];
	} else if ([name isEqualToString:@"com.imokhles.imounbox.symlink"]) {
		symlink(source, target);
	} else if ([name isEqualToString:@"com.imokhles.imounbox.delete"]) {
		[fileManager removeItemAtPath:targetFile error:NULL];
	} else if ([name isEqualToString:@"com.imokhles.imounbox.attributes"]) {
		[result setDictionary:[fileManager attributesOfItemAtPath:targetFile error:NULL]];
	} else if ([name isEqualToString:@"com.imokhles.imounbox.dircontents"]) {
		NSArray *contents = [fileManager contentsOfDirectoryAtPath:targetFile error:NULL];
		if (contents) {
			[result setObject:contents forKey:@"IMDirContents"];
		}
	} else if ([name isEqualToString:@"com.imokhles.imounbox.chmod"]) {
		chmod(target, mode);
	} else if ([name isEqualToString:@"com.imokhles.imounbox.exists"]) {
		BOOL exists = access(target, F_OK);
		NSNumber *num = [[NSNumber alloc] initWithBool:exists];
		[result setObject:num forKey:@"IMFileExists"];
		[num release];
	} else if ([name isEqualToString:@"com.imokhles.imounbox.getdevicemobilegestalt"]) {
		NSString *devUID = [device _deviceInfoForKey:deviceSecretKey];	 	
		[result setObject:devUID forKey:@"IMDeviceUDID"];
		[devUID release];
	} else if ([name isEqualToString:@"com.imokhles.imounbox.isdir"]) {
		struct stat buf;
		stat(target, &buf);
		BOOL isDir = S_ISDIR(buf.st_mode);
		NSNumber *num = [[NSNumber alloc] initWithBool:isDir];
		[result setObject:num forKey:@"IMIsDirectory"];
		[num release];
	} else if ([name isEqualToString:@"com.imokhles.imounbox.mkdir"]) {
		[fileManager createDirectoryAtPath:targetFile withIntermediateDirectories:YES attributes:nil error:NULL];
	}

	return result;
}

- (void)dummy {
	// Keep the timer alive ;)
	NSLog(@"Keeping server alive");
}

@end
