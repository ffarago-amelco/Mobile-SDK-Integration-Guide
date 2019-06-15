## Optipush: Testing
 During the integraiton stage, you can test an Optipush push notification in two ways. Either via out Postman colletion and through your Optimove instance.
 For multiple tests during integration, we recommend you use the Postman collection, and once your integration is ready, you can then use the Optimove instance to create an Optipush push notification with the dynamic deep links.
<br/>

## Enable Test Mode
TODO: Noy review this for start & stop and add optional, required etc
 In order to do this, you can enable _"test Optipush templates"_ on one or more devices by calling the following method:
`Optimove.shared.startTestMode(@Nullable SdkOperationListener operationListener);`
To stop receiving "test campaigns" call `Optimove.sharedInstance.stopTestMode()`.<br>

**Code snippet example**
TODO: Noy Dont we need an IF statement if success or not? like in android.
````swift
class ViewController: UIViewController 
{
    @IBAction func startReceivingOptipushTestNotifications(_ button: UIButton)
    {
        Optimove.sharedInstance.startTestMode()
    }
    @IBAction func stopReceivingOptipushTestNotifications(_ button: UIButton)
    {
        Optimove.sharedInstance.stopTestMode()
    }
}
````

>- It is recommended to maintain 2 apps - one with test mode enabled during integration, while the other for production.
>- The app that is published to Apple Store should NOT have the test mode enabled.
>- Please request from the Optimove Product Integration to configure a test deep link
<br/>

## Test Optipush using Postman
Use this for both iOS & Android testing. 

[![Optipush Postman Collection](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/8de4eb0e7ec475c3656d)

>- The above `startTestMode` must be implemented in your code for testing using this **Postman collection**
>- In order to use the Postman collection, please request your unique `[CLIENT_FIREBASE_MESSAGING_SERVER_KEY]` from Optimove Product Integration

<br/>

## Test Optipush using your Optimove instance
Stay tuned for our how-to guide 

>- The above `startTestMode` must be implemented in your code for testing Optipush using your **Optimove instance**

