## Optipush: Enable Deep Linking
Other than _UI attributes_, an **_Optipush Notification_** can contain metadata that can lead the user to a specific screen within the hosting application by using *Deep Linking*.<br>

To support deep linking, update your application's `AndroidManifest.xml` file to reflect which screen can be targeted for HTTP(s) protocol. Each `Activity` that can be targeted must have the following `intent-filter`:

If the **_Main Activity_** (i.e. has `<intent-filter>` with `<action android:name="android.intent.action.MAIN"/>` and `<category android:name="android.intent.category.LAUNCHER"/>`) needs to be targeted by a **_deep link_**, add `android:launchMode="singleInstance"` to the activity's declaration. <br/><br/>
The Activity `android:launchMode="singleInstance"` ensures that if an _Optipush_ notification is open while the _application_ is running (either in the **foreground** or **background**), **_Android_** will not start a new `Task`, nor will it kill the current one, but will call the `onNewIntent(Intent intent)` with the notification's `Intent`.

```xml
<intent-filter>
    <action android:name="android.intent.action.VIEW"/>

    <category android:name="android.intent.category.DEFAULT"/>
    <category android:name="android.intent.category.BROWSABLE"/>
            
    <!--The host must match the app's package-->
    <!--The pathPrefix must match the screen's name as defined on the Optimove site-->
    <data 
        android:host="REPLACE.WITH.THE.APP.PACKAGE"  
        android:pathPrefix="/REPLACE_WITH_A_CUSTOM_SCREEN_NAME" 
        android:scheme="https"/>
</intent-filter>
```

## Optipush: Handling Dynamic Deep Links from Optimove

To handle **Dynamic Deep Links** the `Activity` that receives the deep links should implement/initialize the `LinkDataExtractedListener` interface. Then, pass the instance of the `LinkDataExtractedListener` and the `Intent` that initialized the `Activity` by using the following code snippet:
```java
new DeepLinkHandler(getIntent()).extractLinkData(linkDataExtractedListenerInstance);
```

If the `Intent` that opened the `Activity` contained an **Optipush Deep Link** then the `onDataExtracted` callback is called with the `screenName` that was targeted and payload's `parameters`.

Example of handling **Dynamic Deep Links**:
```java
public class DeepLinkActivity extends AppCompatActivity implements LinkDataExtractedListener {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_promo);

    // The DeepLinkHandler doesn't hold strong reference to the Activity so this example is safe
    new DeepLinkHandler(getIntent()).extractLinkData(this);
  }

  @Override
  public void onDataExtracted(String screenName, Map<String, String> parameters) {
    // This is only an example of extracting the data and displaying it to the user
    TextView outputTv = findViewById(R.id.outputTextView);
    StringBuilder builder = new StringBuilder(screenName).append(":\n");
    for (String key : parameters.keySet()) {
      builder.append(key).append("=").append(parameters.get(key)).append("\n");
    }
    outputTv.setText(builder.toString());
  }

  @Override
  public void onErrorOccurred(LinkDataError error) {
    // This callback will also be called if no deep link was found, that's why it's just an INFO level log and not ERROR
    Log.i("OPTIPUSH_DEEP_LINK", String.format("Failed to get deep link due to: %s", error));
  }
}
```


## Optional: Customize Optipush message
You add icons & color to your Optipush message by adding the following meta-data to `AndroidManifest.xml`, inside the `<application></application>` tag:

```xml
<meta-data
    android:name="com.optimove.sdk.custom-notification-icon"
    android:resource="@drawable/send_icon"/>
<meta-data
    android:name="com.optimove.sdk.custom-notification-color"
    android:resource="@android:color/holo_red_light"/>
 ```
