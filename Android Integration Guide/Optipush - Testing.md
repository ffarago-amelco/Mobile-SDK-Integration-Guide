## Optipush Testing
 During the integraiton stage, you can test an Optipush push notification in two ways. Either via out Postman colletion and through your Optimove instance.
 For multiple tests during integration, we recommend you use the Postman collection, and once your integration is ready, you can then use the Optimove instance to create an Optipush push notification with the dynamic deep links.

 In order to do this, you can enable _"test Optipush templates"_ on one or more devices by calling the following method:
`Optimove.getInstance().startTestMode(@Nullable SdkOperationListener operationListener);`
<br> 

### startTestMode code snippet
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

>**Important Notes:**
>- It is recommended to maintain 2 apps - one with test mode enabled during integration, while the other for production.
>- The app that is published to Google Play should NOT have the test mode enabled.

## Sending Optipush using Postman
Use this for both iOS & Android testing.
[Optipush Postman Collection]([![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/8de4eb0e7ec475c3656d)

## Sending Optipush using your Optimove instance
Stay tuned for our how-to guide 