import UIKit
import OptimoveSDK

class ViewController: UIViewController {
    
    private var isOptimoveInitialized: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Optimove.shared.registerSuccessStateListener(self)
        
        // Optipush Only
        Optimove.shared.register(deepLinkResponder: OptimoveDeepLinkResponder(self))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Make sure to release the reference to the state listener and avoid memory leaks
        Optimove.shared.unregisterSuccessStateListener(self)
    }
}

// MARK: - Optimove SDK Initialization

extension ViewController: OptimoveSuccessStateListener {
    
    func optimove(_ optimove: Optimove, didBecomeActiveWithMissingPermissions missingPermissions: [OptimoveDeviceRequirement]) {
        // Example for how to handle Optimove initialization
        self.isOptimoveInitialized = true
        
        for missingPermission in missingPermissions {
            if missingPermission == .advertisingId {
                // Maybe prompt the user to enable IDFA report
            } else if missingPermission == .userNotification {
                // Maybe prompt the user to enable Push Notifications
            }
        }
        
        // Make sure to call the Optimove SDK only after it has been initialized
        
        // Report screen visit like this
        Optimove.shared.setScreenVisit(screenPath: "Home/Store/Footwear/Boots", screenTitle: "<YOUR_TITLE>", screenCategory: "<OPTIONAL: YOUR_CATEGORY>")
        // OR
        Optimove.shared.setScreenVisit(screenPathArray: ["Home", "Store", "Footwear", "Boots"], screenTitle: "<YOUR_TITLE>", screenCategory: "<OPTIONAL: YOUR_CATEGORY>")
    }
}

// Mark - Optimove SDK Indentification

extension ViewController {
    
    func login(email: String) {
        // Some login logic through which the SDK ID is retrieved
        let sdkId = MyLoginService.getSdkId(email)
        
        
        if self.isOptimoveInitialized {
            if sdkId != nil {
                // If the Optimove SDK is initialized AND both the email and the sdkId are valid, you can call the registerUser
                Optimove.shared.registerUser(sdkId: sdkId, email: email)
            } else {
                // If the Optimove SDK is initialized AND only the email is valid, you can call the setUserEmail
                Optimove.shared.setUserEmail(email: email)
            }
        } else {
            // No need to wait for the SDK to be initialized when calling setUserId
            Optimove.shared.setUserId(sdkId)
        }
    }
}

// Mark - Optimove SDK Events

extension ViewController {
    
    func reportSimpleEvent() {
        if !self.isOptimoveInitialized { return }
        Optimove.shared.reportEvent(name: "signup", parameters: [
            "first_name": "John",
            "last_name": "Doe",
            "email": "john@doe.com",
            "age": 42,
            "opt_in": false
        ])
    }
    
    func reportComplexEvent() {
        if !self.isOptimoveInitialized { return }
        Optimove.shared.reportEvent(PlacedOrderEvent([CartItem]()))
    }
}

// Mark - Optimove SDK Optipush

extension ViewController: OptimoveDeepLinkCallback {

    func didReceive(deepLink: OptimoveDeepLinkComponents?) {
        guard let deepLink = deepLink else {return}
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "deepLinkVc") as? DeepLinkViewController else { return }
        vc.deepLinkComp = deepLink
        present(vc, animated: true)
    }
    
    @IBAction func startOptipushTestMode(_ sender: UIButton) {
        Optimove.shared.startTestMode()
    }
    
    @IBAction func stopOptipushTestMode(_ sender: UIButton)
    {
        Optimove.shared.stopTestMode()
    }
}
