#import <UIKit/UIKit.h>
@import OptimoveSDK;

NS_ASSUME_NONNULL_BEGIN

@interface ViewController : UIViewController<OptimoveSuccessStateDelegate, OptimoveDeepLinkCallback>

@property BOOL isOptimoveInitialized;

@end

NS_ASSUME_NONNULL_END
