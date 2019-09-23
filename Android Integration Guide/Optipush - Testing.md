# Optipush: Testing

During the integration stage, you can test an Optipush push notification in two ways: our Postman collection, and your Optimove instance.
For multiple tests during integration, we recommend you use the Postman collection, and once your integration is ready, you can then use the Optimove instance to create an Optipush push notification with the dynamic deep links.

## Enable Test Mode
 In order to do this, you can enable _"test Optipush templates"_ on one or more devices by calling the following method:
`Optimove.getInstance().startTestMode(@Nullable SdkOperationListener operationListener);`
<br> 

**Code snippet example**
```java
public class MainActivity extends AppCompatActivity {

  public void startTestModeClickListener() {
    // Call this method once you verified that the SDK is initialized as described in the "Initializing the SDK" doc
    Optimove.getInstance().startTestMode(success -> {
      if (success) {
        Toast.makeText(this, "Test Mode is ON", Toast.LENGTH_SHORT).show();
      } else {
        Toast.makeText(this, "Failed to start Test Mode", Toast.LENGTH_SHORT).show();
      }
    });
  }

  public void stopTestModeClickListener() {    
    // Call this method once you verified that the SDK is initialized as described in the "Initializing the SDK" doc
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

>- It is recommended to maintain 2 apps - one with test mode enabled during integration, while the other for production.
>- The app that is published to Google Play should NOT have the test mode enabled.
>- Please request from the Optimove Product Integration to configure a test deep link
<br/>

## Test Optipush using Postman
Use this for both iOS & Android testing. 

[![Optipush Postman Collection](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/8de4eb0e7ec475c3656d)

>- The above `startTestMode` must be implemented in your code for testing using this **Postman collection**
>- In order to use the Postman collection, please request your unique `[CLIENT_FIREBASE_MESSAGING_SERVER_KEY]` from Optimove Product Integration

<br/>

## Test Optipush using your Optimove instance
[Create Optipush Template - Optimove UI](https://academy.optimove.com/successful-campaigns/create-optipush-template)

>- The above `startTestMode` must be implemented in your code for testing Optipush using your **Optimove instance**

