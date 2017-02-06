#import "iMoDevTools2-Firebase.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wconstant-conversion"

@interface NSString (iMoDevTools)

- (NSString *)imodev_rebuildString;

@end

@implementation NSString (iMoDevTools)

- (NSString *)imodev_rebuildString {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end

__attribute__((always_inline, visibility("hidden")))
static NSString *imodev_getSecretStringFrom(NSString *sec1, NSString *sec2) {
    
    NSString *secretString = [NSString stringWithFormat:@"%@%@", sec1, sec2];
    return [secretString imodev_rebuildString];
}

__attribute__((always_inline, visibility("hidden")))
static void uicache(){
    pid_t pid;
    int status;
    const char* args[] = {"uicache", NULL};
    posix_spawn(&pid,"/usr/bin/uicache",NULL,NULL,(char*const*)args,NULL);
    waitpid(pid,&status,WEXITED);
}

__attribute__((always_inline, visibility("hidden")))
static BOOL isThisFileExiste(const char *path) {
    return (access(path,F_OK) != -1);
}





@implementation iMoDevTools (Firebase)

+ (FIROptions *)imo_defaultsOptionsFromPlist {
    FIROptions *defaultOptions = [[FIROptions alloc] initWithContentsOfFile:[iMoDevTools pathForTweakFileWithName:@"GoogleService-Info" extension:@"plist"]];
    return defaultOptions;
}
+ (void)imo_configureDefaultApp {
    [FIRApp configureWithOptions:[iMoDevTools imo_defaultsOptionsFromPlist]];
}
+ (void)imo_setUserInformationWithEmail:(NSString *)userEmail withBlock:(finishedWithResultError)result {
    
    if (![[iMoDevTools sharedInstance] imo_deviceUDIDValue] || ![[iMoDevTools sharedInstance] imo_deviceSerialValue]) {
        result(NO, nil);
    }
    [[FIRAuth auth]
     createUserWithEmail:userEmail.lowercaseString
     password:[imodev_getSecretStringFrom([[iMoDevTools sharedInstance] imo_deviceUDIDValue], [[iMoDevTools sharedInstance] imo_deviceSerialValue]) lowercaseString]
     completion:^(FIRUser *_Nullable user,
                  NSError *_Nullable error) {
         
         if (error == nil) {
             if (user) {
                 result(YES, nil);
             } else {
                 result(NO, nil);
             }
         } else {
             result(NO, error);
         }
     }];
}
+ (void)imo_getUserInformationWithEmail:(NSString *)userEmail withBlock:(finishedWithResultError)result {
    if (![[iMoDevTools sharedInstance] imo_deviceUDIDValue] || ![[iMoDevTools sharedInstance] imo_deviceSerialValue]) {
        result(NO, nil);
    }
    [[FIRAuth auth] signInWithEmail:userEmail.lowercaseString
                           password:[imodev_getSecretStringFrom([[iMoDevTools sharedInstance] imo_deviceUDIDValue], [[iMoDevTools sharedInstance] imo_deviceSerialValue]) lowercaseString]
                         completion:^(FIRUser *user, NSError *error) {
         if (error == nil) {
             if (user) {
                 result(YES, nil);
             } else {
                 result(NO, nil);
             }
         } else {
             result(NO, error);
         }
     }];
}
+ (FIRDatabaseReference *)imo_mainReferenceDatabase {
    return [[FIRDatabase database] reference];
}
+ (NSString *)imo_currentUserUid {
    return [[FIRAuth auth].currentUser uid];
}
@end
#pragma clang diagnostic pop
