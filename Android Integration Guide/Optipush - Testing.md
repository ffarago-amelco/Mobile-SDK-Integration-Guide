# Optipush Testing
During the integraiton stage, you can test an Optipush push notification in two different ways: via our Postman collection or through your Optimove instance. For running multiple tests during integration, it is recommended to use the Postman collection, and then, once your integration is ready, to use the Optimove instance to create an Optipush push notification with [deep links](https://github.com/optimove-tech/Mobile-SDK-Integration-Guide/blob/mobile-sdk-general-page-v2.0/Android%20Integration%20Guide/Optipush%20-%20Deep%20Links.md).
 
## Enable Test Mode
In order to do this, enable _"test Optipush templates"_ on one or more devices, by calling the `Optimove.getInstance().startTestMode(@Nullable SdkOperationListener operationListener);` method.
 
**Sample Code Snippet**
```java
public class MainActivity extends AppCompatActivity implements OptimoveSuccessStateListener {
 
   public void startTestModeClickListener() {
     Optimove.getInstance().startTestMode(success -> {
       if (success) {
         Toast.makeText(this, "Test Mode is ON", Toast.LENGTH_SHORT).show();
       } else {
         Toast.makeText(this, "Failed to start Test Mode", Toast.LENGTH_SHORT).show();
       }
     });
   }
 
   public void stopTestModeClickListener() {    
     Optimove.getInstance().stopTestMode(success -> {
       if (success) {
         Toast.makeText(this, "Test Mode is OFF", Toast.LENGTH_SHORT).show();
       } else {
         Toast.makeText(this, "Failed to stop Test Mode", Toast.LENGTH_SHORT).show();
       }
     });
   }
}
```

*Notes:* 
- It is recommended to maintain two apps: one with test mode enabled during integration, and the other for production.
- The app that is published to Google Play should NOT have test mode enabled.
- To configure deep linka for testing, contact the Optimove Product Integration Team.

 
## Test Optipush Using Postman
Click here to get started:
 
 [![Optipush Postman Collection](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/8de4eb0e7ec475c3656d)
 
*Notes:* 
- The above `startTestMode` must be implemented in your code for testing using this Postman collection.
- In order to use the Postman collection, request your unique `[CLIENT_FIREBASE_MESSAGING_SERVER_KEY]` from the Optimove Product Integration Team.
 

 
## Test Optipush Using Your Optimove Instance
Stay tuned for a how-to testing guide.
 
> The above `startTestMode` must be implemented in your code for testing Optipush using your **Optimove instance**
 
