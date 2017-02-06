#import <stdlib.h>
#import <unistd.h>
#import <stdint.h>
#import <stdio.h>
#import <sys/stat.h>
#import <sys/types.h>
#import <Foundation/Foundation.h>
#import <AppSupport/CPDistributedMessagingCenter.h>
#import <UIKit/UIKit.h>

@interface IMDelegate: NSObject {
	CPDistributedMessagingCenter *center;
	NSFileManager *fileManager;
	UIDevice *device;
}

- (NSDictionary *)handleMessageNamed:(NSString *)name userInfo:(NSDictionary *)info;
- (void)dummy;

@end
