//
//  IMTWHelper.h
//  WAEnhancer10
//
//  Created by iMokhles on 02/02/2017.
//
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, IMTWErrorCode)
{
    IMTWErrorCodeTwitterUnavailable,
    IMTWErrorCodeEmptyTweet,
    IMTWErrorCodeFailedTweeting,
};

@protocol IMTWDelegate <NSObject>

@optional
//- (BOOL)IMTWShouldDisplay;
//- (void)IMTWWillDisplay;
//- (void)IMTWDidDisplay;
//- (void)IMTWDidCancel;
//- (void)IMTWDidSendTweet:(NSString *)tweet;
//- (void)IMTWDidFailWithError:(NSError *)error;

@end

@interface IMTWHelper : NSObject

// delegate for implementing custom behavior
//@property (strong, nonatomic) id<IMTWDelegate> delegate;

@property (nonatomic, copy) BOOL (^IMTWShouldDisplay)(void);
@property (nonatomic, copy) void (^IMTWWillDisplay)(void);
@property (nonatomic, copy) void (^IMTWDidDisplay)(void);
@property (nonatomic, copy) void (^IMTWDidCancel)(void);
@property (nonatomic, copy) void (^IMTWDidSendTweet)(NSString *tweet);
@property (nonatomic, copy) void (^IMTWDidFailWithError)(NSError *error);

// get singleton object
+ (instancetype)sharedInstance;

// return NO if there's no Twitter account binded on the device
- (BOOL)canSendTweet;

// call showWithTitle:tweetMessage:prefixMessage with prefixMessage set to nil
- (void)showWithTitle:(NSString *)title tweetMessage:(NSString *)tweetMessage;

// display an UIAlertView that prompt a user to send an advertising tweet
// prefixMessage parameter is just an informative message an will not be sent with the tweet
// warning : this method will throw an exception if tweetMessage characters count > 140
- (void)showWithTitle:(NSString *)title tweetMessage:(NSString *)tweetMessage prefixMessage:(NSString *)prefixMessage;


@end
