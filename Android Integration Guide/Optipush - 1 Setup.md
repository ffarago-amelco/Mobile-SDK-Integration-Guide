## Optipush setup
TODO: Joel to add intro and explain this is an addon product

In order to route end users back to the application from the notification, you must support *Deep Linking*.
Other than _UI attributes_, an **_Optipush Notification_** can contain metadata that can lead the user to a specific screen within the hosting application.<br>

To support deep linking, update your application's `manifest.xml` file to reflect which screen can be targeted for both http and http protocols. Each `Activity` that can be targeted must have the following `intent-filter`:


```xml
 <intent-filter>
    <action android:name="android.intent.action.MAIN"/>
    <category android:name="android.intent.category.LAUNCHER"/>
</intent-filter>
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