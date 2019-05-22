## Optipush Deep Linking
In order to route end users back to the application from the notification, you must support *Deep Linking*.
Other than _UI attributes_, an **_Optipush Notification_** can contain metadata that can lead the user to a specific screen within the hosting application.<br>

To support deep linking, update your application's `manifest.xml` file to reflect which screen can be targeted for both http and http protocols. Each `Activity` that can be targeted must have the following `intent-filter`:

If the **_Main Activity_** (i.e. has `<intent-filter>` with `<action android:name="android.intent.action.MAIN"/>` and `<category android:name="android.intent.category.LAUNCHER"/>`) needs to be targeted by a **_deep link_**, add `android:launchMode="singleInstance"` to the activity's declaration. <br/>
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
        android:scheme="http"/>
</intent-filter>

<!-- You must also add support for HTTP(S) -->
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

## Optional: Customize Optipush message
You add icons & color to your Optipush message by adding the following meta-data to `manifest.xml`:

```xml
<meta-data
    android:name="com.optimove.sdk.custom-notification-icon"
    android:resource="@drawable/send_icon"/>
<meta-data
    android:name="com.optimove.sdk.custom-notification-color"
    android:resource="@android:color/holo_red_light"/>
 ```