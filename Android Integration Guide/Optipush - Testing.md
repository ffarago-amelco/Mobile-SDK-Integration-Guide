## Optipush Testing
 You can test an Optipush template on your device *before* having to create an Optipush campaign by using our Postman Collection TODO: Add collection. This is useful during the integration stage of Optipush.

TODO: Execute via PostMan and/or Optimove UI

You can enable/disable _"test Optipush templates"_ on one or more devices by calling the following method:
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
