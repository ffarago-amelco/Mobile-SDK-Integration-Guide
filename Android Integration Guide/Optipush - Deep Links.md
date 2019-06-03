# Optipush Deep Linking
In addition to _UI attributes_, an _Optipush Notification_ can contain metadata that links directly to a specific screen within yout app. This is known as _Deep Linking_.

To enable deep linking in your app, update your app's `AndroidManifest.xml` file to reflect which screens can be targeted via the HTTP(S) protocol. Each `Activity` that can be targeted must have the following `intent-filter`:

If the _Main Activity_ needs to be targeted by a _deep link_ (i.e., it has `<intent-filter>` with `<action android:name="android.intent.action.MAIN"/>` and `<category android:name="android.intent.category.LAUNCHER"/>`),  add `android:launchMode="singleInstance"` to the activity's declaration.

The Activity `android:launchMode="singleInstance"` ensures that, if an _Optipush_ notification is open while the _application_ is running (either in the foreground or background), Android will neither start a new Task nor kill the current one; instead, it will call the `onNewIntent(Intent intent)` with the notification's `Intent`.

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

## Optipush: Using Dynamic Deep Links

Dynamic deep links are deep links that are personalized for individual recipients by passing `parameters` in the payload. To implement them, the `Activity` that receives the deep links must implement/initialize the `LinkDataExtractedListener` interface. Then, pass the instance of the `LinkDataExtractedListener` and the `Intent` that initialized the `Activity`, by using the following code snippet:
```java
new DeepLinkHandler(getIntent()).extractLinkData(linkDataExtractedListenerInstance);
```

If the `Intent` that opened the `Activity` contained a deep link, then the `onDataExtracted` callback is called with the `screenName` that was targeted along with the payload's `parameters`.

Sample code snippet using dynamic deep links:
```java
public class DeepLinkActivity extends AppCompatActivity implements LinkDataExtractedListener {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_promo);

    // This example is safe, as the DeepLinkHandler doesn't hold a strong reference to the Activity
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
    // This callback will also be called if no deep link was found - for this reason, it is just an INFO level log and not ERROR
    Log.i("OPTIPUSH_DEEP_LINK", String.format("Failed to get deep link due to: %s", error));
  }
}
```

## Optional: Customize an Optipush Message
You may include icons and specify colors for your Optipush messages, by adding the following meta-data to `AndroidManifest.xml`, inside the `<application></application>` tag:

```xml
<meta-data
    android:name="com.optimove.sdk.custom-notification-icon"
    android:resource="@drawable/send_icon"/>
<meta-data
    android:name="com.optimove.sdk.custom-notification-color"
    android:resource="@android:color/holo_red_light"/>
```
