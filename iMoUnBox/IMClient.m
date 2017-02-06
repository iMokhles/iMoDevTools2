#import "IMClient.h"
#import "rocketbootstrap.h"

@implementation IMClient

+ (id)sharedInstance
{
	static id shared = nil;
	if (shared == nil) {
		shared = [[self alloc] init];
	}

	return shared;
}

- (id)init
{
	if ((self = [super init])) {
		center = [CPDistributedMessagingCenter centerNamed:@"com.imokhles.imounbox"];
		rocketbootstrap_distributedmessagingcenter_apply(center);
	}

	return self;
}

- (NSString *)temporaryFile
{
	CFUUIDRef uuidRef = CFUUIDCreate(NULL);
	CFStringRef uuid = CFUUIDCreateString(NULL, uuidRef);
	CFRelease(uuidRef);
	NSString *path = [NSString stringWithFormat:@"/tmp/%@.tmp", uuid];
	CFRelease(uuid);
	return path;
}

- (void)moveFile:(NSString *)file1 toFile:(NSString *)file2
{
	if (file1 == nil || file2 == nil) {
		return;
	}

	NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
	[info setObject:file1 forKey:@"IMSourceFile"];
	[info setObject:file2 forKey:@"IMTargetFile"];
	[center sendMessageAndReceiveReplyName:@"com.imokhles.imounbox.move" userInfo:info];
	[info release];
}

- (void)copyFile:(NSString *)file1 toFile:(NSString *)file2
{
	if (file1 == nil || file2 == nil) {
		return;
	}

	NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
	[info setObject:file1 forKey:@"IMSourceFile"];
	[info setObject:file2 forKey:@"IMTargetFile"];
	[center sendMessageAndReceiveReplyName:@"com.imokhles.imounbox.copy" userInfo:info];
	[info release];
}

- (void)symlinkFile:(NSString *)file1 toFile:(NSString *)file2
{
	if (file1 == nil || file2 == nil) {
		return;
	}

	NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
	[info setObject:file1 forKey:@"IMSourceFile"];
	[info setObject:file2 forKey:@"IMTargetFile"];
	[center sendMessageAndReceiveReplyName:@"com.imokhles.imounbox.symlink" userInfo:info];
	[info release];
}

- (void)deleteFile:(NSString *)file
{
	if (file == nil) {
		return;
	}

	NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
	[info setObject:file forKey:@"IMTargetFile"];
	[center sendMessageAndReceiveReplyName:@"com.imokhles.imounbox.delete" userInfo:info];
	[info release];
}

- (NSDictionary *)attributesOfFile:(NSString *)file
{
	if (file == nil) {
		return nil;
	}

	NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
	[info setObject:file forKey:@"IMTargetFile"];
	NSDictionary *reply = [center sendMessageAndReceiveReplyName:@"com.imokhles.imounbox.attributes" userInfo:info];
	[info release];
	return reply;
}

- (NSString *)deviceGetMobileGestaltValueForKey:(NSString *)value {
	NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
	[info setObject:value forKey:@"IMDeviceKEY"];
	NSDictionary *reply = [center sendMessageAndReceiveReplyName:@"com.imokhles.imounbox.getdevicemobilegestalt" userInfo:info];
	[info release];
	NSString *UDID = [reply objectForKey:@"IMDeviceUDID"];
	return UDID;
}

- (NSArray *)contentsOfDirectory:(NSString *)dir
{
	if (dir == nil) {
		return nil;
	}

	NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
	[info setObject:dir forKey:@"IMTargetFile"];
	NSDictionary *reply = [center sendMessageAndReceiveReplyName:@"com.imokhles.imounbox.dircontents" userInfo:info];
	[info release];
	NSArray *result = [reply objectForKey:@"IMDirContents"];
	return result;
}

- (void)chmodFile:(NSString *)file mode:(mode_t)mode
{
	if (file == nil) {
		return;
	}

	NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
	[info setObject:file forKey:@"IMTargetFile"];
	NSNumber *modeNumber = [[NSNumber alloc] initWithInt:mode];
	[info setObject:modeNumber forKey:@"IMFileMode"];
	[modeNumber release];
	[center sendMessageAndReceiveReplyName:@"com.imokhles.imounbox.chmod" userInfo:info];
	[info release];
}

- (BOOL)fileExists:(NSString *)file
{
	if (file == nil) {
		return NO;
	}

	NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
	[info setObject:file forKey:@"IMTargetFile"];
	NSDictionary *reply = [center sendMessageAndReceiveReplyName:@"com.imokhles.imounbox.exists" userInfo:info];
	[info release];
	BOOL result = [(NSNumber *)[reply objectForKey:@"IMFileExists"] boolValue];
	return result;
}

- (BOOL)fileIsDirectory:(NSString *)file
{
	if (file == nil) {
		return NO;
	}

	NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
	[info setObject:file forKey:@"IMTargetFile"];
	NSDictionary *reply = [center sendMessageAndReceiveReplyName:@"com.imokhles.imounbox.isdir" userInfo:info];
	[info release];
	BOOL result = [(NSNumber *)[reply objectForKey:@"IMIsDirectory"] boolValue];
	return result;
}

- (void)createDirectory:(NSString *)dir
{
	if (dir == nil) {
		return;
	}

	NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
	[info setObject:dir forKey:@"IMTargetFile"];
	[center sendMessageAndReceiveReplyName:@"com.imokhles.imounbox.mkdir" userInfo:info];
	[info release];
}

@end
