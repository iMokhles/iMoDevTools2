//
//  IMTWHelper.m
//  WAEnhancer10
//
//  Created by iMokhles on 02/02/2017.
//
//

#import "IMTWHelper.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "../iMoDevTools2Own.h"

static NSString * const kIMTWErrorDomain                          =   @"IMTWErrorDomain";

static NSString * const kIMTWTwitterAPIPostTweetURL               =   @"https://api.twitter.com/1.1/statuses/update.json";
static NSString * const kIMTWTwitterAPIPostTweetParameterTweet    =   @"status";

static NSString * const kIMTWLocalizationAlertButtonCancelKey     =   @"TWITTER_ALERT_BUTTON_CANCEL";
static NSString * const kIMTWLocalizationAlertButtonSendKey       =   @"TWITTER_ALERT_BUTTON_SEND";

@interface IMTWHelper () <UIAlertViewDelegate>
{
    NSArray *_twitterAccounts;
    NSString *_tweet;
}

@end

@implementation IMTWHelper

#pragma mark - Life cycle

- (id)init
{
    self = [super init];
    if (self)
    {
        ACAccountStore *store = [[ACAccountStore alloc] init];
        ACAccountType *accountType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        [store requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
            if (granted)
            {
                _twitterAccounts = [store accountsWithAccountType:accountType];
            }
        }];
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static IMTWHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - Instance methods

- (BOOL)canSendTweet
{
    return _twitterAccounts.count > 0;
}

- (void)showWithTitle:(NSString *)title tweetMessage:(NSString *)tweetMessage
{
    [self showWithTitle:title tweetMessage:tweetMessage prefixMessage:nil];
}

- (void)showWithTitle:(NSString *)title tweetMessage:(NSString *)tweetMessage prefixMessage:(NSString *)prefixMessage
{
//    NSAssert(tweetMessage.length <= 140, @"A tweet should not be up to 140 characters");
    
//    if ([self.delegate respondsToSelector:@selector(IMTWShouldDisplay)])
//    {
//        BOOL shouldDisplay = [self.delegate IMTWShouldDisplay];
//        if (!shouldDisplay) return;
//    }
    
    if (self.IMTWShouldDisplay) {
        BOOL shouldDisplay = self.IMTWShouldDisplay();
        if (!shouldDisplay) return;
        
    }
//    if ([self.delegate respondsToSelector:@selector(IMTWWillDisplay)])
//    {
//        [self.delegate IMTWWillDisplay];
//    }
    
    if (self.IMTWWillDisplay) {
        self.IMTWWillDisplay();
        
    }
    
    _tweet = [tweetMessage copy];
    if (prefixMessage && ![prefixMessage isEqualToString:@""])
    {
        tweetMessage = [prefixMessage stringByAppendingString:tweetMessage];
    }
    
    NSString *cancelString = [self localizedStringForKey:kIMTWLocalizationAlertButtonCancelKey withDefault:@"Cancel"];
    NSString *sendString = [self localizedStringForKey:kIMTWLocalizationAlertButtonSendKey withDefault:@"Send"];
//    [[[UIAlertView alloc] initWithTitle:title
//                                message:tweetMessage
//                               delegate:self
//                      cancelButtonTitle:cancelString
//                      otherButtonTitles:sendString, nil] show];
    
    [self sendTweet:_tweet];
//    if ([self.delegate respondsToSelector:@selector(IMTWDidDisplay)])
//    {
//        [self.delegate IMTWDidDisplay];
//    }
    if (self.IMTWDidDisplay) {
        self.IMTWDidDisplay();
        
    }
}

#pragma mark - Helper methods

- (void)reset
{
    _tweet = nil;
}

- (void)sendTweet:(NSString *)tweet
{
    if (tweet == nil || [tweet isEqualToString:@""])
    {
//        if ([self.delegate respondsToSelector:@selector(IMTWDidFailWithError:)])
//        {
//            NSError *error = [self errorForCode:IMTWErrorCodeEmptyTweet];
//            [self.delegate IMTWDidFailWithError:error];
//        }
        if (self.IMTWDidFailWithError) {
            NSError *error = [self errorForCode:IMTWErrorCodeEmptyTweet];
            self.IMTWDidFailWithError(error);
            
        }
        [self reset];
        return;
    }
    
    if (_twitterAccounts == nil || _twitterAccounts.count <= 0)
    {
//        if ([self.delegate respondsToSelector:@selector(IMTWDidFailWithError:)])
//        {
//            NSError *error = [self errorForCode:IMTWErrorCodeTwitterUnavailable];
//            [self.delegate IMTWDidFailWithError:error];
//        }
        if (self.IMTWDidFailWithError) {
            NSError *error = [self errorForCode:IMTWErrorCodeTwitterUnavailable];
            self.IMTWDidFailWithError(error);
            
        }
        [self reset];
        return;
    }
    
    NSURL *URL = [NSURL URLWithString:kIMTWTwitterAPIPostTweetURL];
    NSDictionary *parameters = @{kIMTWTwitterAPIPostTweetParameterTweet : tweet};
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                            requestMethod:SLRequestMethodPOST
                                                      URL:URL
                                               parameters:parameters];
    request.account = _twitterAccounts[0];
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300)
        {
//            if ([self.delegate respondsToSelector:@selector(IMTWDidSendTweet:)])
//            {
//                [self.delegate IMTWDidSendTweet:tweet];
//            }
            if (self.IMTWDidSendTweet) {
                self.IMTWDidSendTweet(tweet);
                
            }
        }
        else
        {
//            if ([self.delegate respondsToSelector:@selector(IMTWDidFailWithError:)])
//            {
//                NSError *error = [self errorForCode:IMTWErrorCodeFailedTweeting];
//                [self.delegate IMTWDidFailWithError:error];
//            }
            if (self.IMTWDidFailWithError) {
                NSError *error = [self errorForCode:IMTWErrorCodeFailedTweeting];
                self.IMTWDidFailWithError(error);
                
            }
        }
    }];
}

- (NSError *)errorForCode:(IMTWErrorCode)code
{
    switch (code) {
        case IMTWErrorCodeTwitterUnavailable:
        {
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey : @"Operation failed",
                                       NSLocalizedFailureReasonErrorKey : @"There is no Twitter account authentified"
                                       };
            return [NSError errorWithDomain:kIMTWErrorDomain
                                       code:IMTWErrorCodeTwitterUnavailable
                                   userInfo:userInfo];
            
        }
        case IMTWErrorCodeEmptyTweet:
        {
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey : @"Operation failed",
                                       NSLocalizedFailureReasonErrorKey : @"Tweet message should not be nil or empty"
                                       };
            return [NSError errorWithDomain:kIMTWErrorDomain
                                       code:IMTWErrorCodeEmptyTweet
                                   userInfo:userInfo];
        }
        case IMTWErrorCodeFailedTweeting:
        {
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey : @"Operation failed",
                                       NSLocalizedFailureReasonErrorKey : @"Failed tweeting"
                                       };
            return [NSError errorWithDomain:kIMTWErrorDomain
                                       code:IMTWErrorCodeFailedTweeting
                                   userInfo:userInfo];
        }
    }
}

#pragma mark - Localization methods

- (NSString *)localizedStringForKey:(NSString *)key withDefault:(NSString *)defaultString
{
    return [iMoDevTools localizedStringForKey:key withDefault:defaultString];
}

#pragma mark - UIAlertView delegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex)
    {
//        if ([self.delegate respondsToSelector:@selector(IMTWDidCancel)])
//        {
//            [self.delegate IMTWDidCancel];
//        }
        if (self.IMTWDidCancel) {
            self.IMTWDidCancel();
            
        }
    }
    else if (buttonIndex == 1)
    {
        [self sendTweet:_tweet];
    }
}

@end
