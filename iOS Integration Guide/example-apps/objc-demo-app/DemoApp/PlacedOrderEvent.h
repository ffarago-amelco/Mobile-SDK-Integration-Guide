#import <Foundation/Foundation.h>
#import "CartItem.h"

@import OptimoveSDK;

NS_ASSUME_NONNULL_BEGIN

@interface PlacedOrderEvent : NSObject <OptimoveEvent>

@property NSArray<CartItem *> *_cartItems;

- (instancetype) initWithCartItems:(NSArray *)cartItems;

@end

NS_ASSUME_NONNULL_END
