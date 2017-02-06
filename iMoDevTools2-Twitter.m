#import "iMoDevTools2-Twitter.h"
#import "iMoDevTools2-Firebase.h"



@implementation iMoDevTools (Twitter)

- (void)imodev_isAdsPurchasedForTweak:(NSSttring *)tweakId withBlock:(finishedWithResultError)result {
    
    if ([FIRAuth auth].currentUser) {
        
    } else {
        result(NO, nil);
    }
}
@end
