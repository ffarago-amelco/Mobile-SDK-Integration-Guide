#import "ViewController.h"
#import "PlacedOrderEvent.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [Optimove.shared registerSuccessStateDelegate:self];
    
    // Optipush Only
    [Optimove.shared registerWithDeepLinkResponder: [[OptimoveDeepLinkResponder alloc] init: self]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // Make sure to release the reference to the state listener and avoid memory leaks
    [Optimove.shared unregisterSuccessStateDelegate:self];
}

// MARK: - Optimove SDK Initialization

- (void)optimove:(Optimove *)optimove didBecomeActiveWithMissingPermissions:(NSArray<NSNumber *> *)missingPermissions {
    // Example for how to handle Optimove initialization
    self.isOptimoveInitialized = true;
    
    for (int i = 0; i < missingPermissions.count; i++) {
        NSNumber *missingPermission = missingPermissions[i];
        if (missingPermission == OptimoveDeviceRequirementAdvertisingId) {
            // Maybe prompt the user to enable IDFA report
        } else if (missingPermission == OptimoveDeviceRequirementAdvertisingId) {
            // Maybe prompt the user to enable Push Notifications
        }
    }
    
    // Make sure to call the Optimove SDK only after it has been initialized
    
    // Report screen visit like this
    [Optimove.shared setScreenVisitWithScreenPath:@"Home/Store/Footwear/Boots" screenTitle:@"<YOUR_TITLE>" screenCategory:@"<OPTIONAL: YOUR_CATEGORY>"];
    // OR
    [Optimove.shared setScreenVisitWithScreenPathArray:@[@"Home", @"Store", @"Footwear", @"Boots"] screenTitle:@"<YOUR_TITLE>" screenCategory:@"<OPTIONAL: YOUR_CATEGORY>"];
}

// Mark - Optimove SDK Indentification

- (void) loginWithEmail: (NSString *)email {
    // Some login logic through which the SDK ID is retrieved
    NSString *sdkId = [MyLoginService getSdkIdWithEmail: email];
    
    if (self.isOptimoveInitialized) {
        if (sdkId != nil) {
            // If the Optimove SDK is initialized AND both the email and the sdkId are valid, you can call the registerUser
            [Optimove.shared registerUserWithSdkId:sdkId email:email];
        } else {
            // If the Optimove SDK is initialized AND only the email is valid, you can call the setUserEmail
            [Optimove.shared setUserEmailWithEmail:email];
        }
    } else {
        // No need to wait for the SDK to be initialized when calling setUserId
        [Optimove.shared setUserId:sdkId];
    }
}


// Mark - Optimove SDK Events

- (void) reportSimpleEvent {
    if (!self.isOptimoveInitialized) { return; }
    [Optimove.shared reportEventWithName:@"signup" parameters: @{@"first_name": @"John",
                                                                 @"last_name": @"Doe",
                                                                 @"email": @"john@doe.com",
                                                                 @"age": @(42),
                                                                 @"opt_in": @(false)}];
}


- (void) reportComplexEvent {
    if (!self.isOptimoveInitialized) { return; }
    [Optimove.shared reportEvent:[[PlacedOrderEvent alloc] initWithCartItems: @[[[CartItem alloc] init]]]];
}


// Mark - Optimove SDK Optipush

- (void)didReceiveWithDeepLink:(OptimoveDeepLinkComponents *)deepLink {
    if (deepLink == nil) { return; }
    
    // Get the targetted screen's name
    NSString *screenName = deepLink.screenName;
    
    // Get the dynamic deep link's params
    NSDictionary *params = deepLink.parameters;
}

- (void) startOptipushTestMode {
    [Optimove.shared startTestMode];
}

- (void) stopOptipushTestMode {
    [Optimove.shared stopTestMode];
}

@end
