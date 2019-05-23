
**Use this as a refence to know what was changed from previous versions of Optimove Android SDK to version 2.0.**

## Dependencies:

* com.google.firebase:firebase-core => 16.0.8
* com.google.firebase:firebase-database => 16.1.0
* com.google.firebase:firebase-messaging => 17.5.0
* com.google.firebase:firebase-invites => 16.1.1
* com.firebase:firebase-jobdispatcher => 0.8.6


## Versioning
Optimove now follows using [semantic versioning](https://semver.org/), which means that you should automatically update your Optimove SDK every time we release a patch or a minor release:

- In you app module's `build.gradle` file, update your dependency statement (under `dependencies` object) to:
  ```groovy
  implementation 'com.optimove.sdk:optimove-sdk:2.+'
  ```

## Features

### Multiple environment support

- We added a flag to mark the specific `BuildType`s/`BuildFlavor`s that represent the app's _Staging_ environment. This flag should be enabled **only** for `BuildType`s that are **not** _Dev_ or _Production_. These are ususally the environemnts that are sent to Optimove's team during the integration and testing stages of the application.
```groovy
// Add this only for the BuildTypes that are considered "Staging"
buildConfigField "Boolean", "OPTIMOVE_CLIENT_STG_ENV", 'true' 
// No need to add "false" for the other BuildTypes, as this is the default value
```
> The SDK considers a _Staging_ environment one that is:
>   1. Safe to collect more metrics about the SDK's performance, disregarding battery/data use conservation
>   2. Not it use during development as we don't want to overflow our databases with information about the SDK everytime you open your development environment.

- We now support log levels by adding the optional flag  `OPTIMOVE_MIN_LOG_LEVEL` in the `BuildConfig` of the app. Optimove SDK would use the flag to set the minimal reported Log Level. 
  - Possible values are:  _DEBUG/INFO/WARN/ERROR_ (**case sensitive**)
  - NOTE: During the integration and testing stages, please use log level `DEBUG`.
```groovy
buildConfigField "String", "OPTIMOVE_MIN_LOG_LEVEL", '"<DEBUG/INFO/WARN/ERROR>"'    
```


## API Changes

 -   Changed `FcmTokenHandler`  to  `OptipushFcmTokenHandler`
 -   Changed `Optimove.getInstance().reportScreenVisit(...)`  to  `Optimove.getInstance().setScreenVisit(...)`
 - Removed the  `Optimove.connectToOptimoveFirebaseApp()`  function.
 -   In the  `build.gradle`, renamed the  `BuildConfig`  property  `OPTIMOVE_TOKEN`  to  `OPTIMOVE_TENANT_TOKEN`.
-   If the client's app uses Firebase and doesn't use the Google Play Services plugin to automatically initialize the app, the the app must:
    
    1.  Disable Optimove's automatic initialization by adding the  `BuildConfig`  flag  `OPTIMOVE_DISABLE_AUTO_INIT`:
    
    ```java
    buildConfigField "Boolean", "OPTIMOVE_DISABLE_AUTO_INIT", 'true'
    ```
    
    2.  To manually initialize the Optimove SDK  **after**  it initializes the default  `FirebaseApp`.
    
    ```java
    public class MyApplication extends Application {
    
      @Override
      public void onCreate() {
        super.onCreate();
        FirebaseApp.initializeApp(this, new FirebaseOptions.Builder().<Calling all the Setters>.build());
        Optimove.configure(this, new TenantInfo("<YOUR_TENANT_TOKEN>", "<YOUR_CONFIG_NAME>"));
      }
    }
    
    ```

**BuildConfig code snippet example:**
```groovy
android {
    buildTypes {
	// Optimove SDK Integration: Don't delete the single nor the double quote - just the value with the enclosing diamond brackets
	buildConfigField "String", "OPTIMOVE_TENANT_TOKEN", '"<YOUR_TENANT_TOKEN>"'
	buildConfigField "String", "OPTIMOVE_CONFIG_NAME", '"<YOUR_OPTIMOVE_CONFIG_NAME>"'
	//optional
	buildConfigField "Boolean", "OPTIMOVE_CLIENT_STG_ENV", 'true'	            
	//optional
	buildConfigField "String", "OPTIMOVE_MIN_LOG_LEVEL", '"DEBUG"'
	//optional
	buildConfigField "Boolean", "OPTIMOVE_DISABLE_AUTO_INIT", 'true'
       }
}
``` 

### Optipush (Dynamic Deep Link support)
 Optipush Deep Link intent-filter modification supports both "http" and "https" protocols:
 
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




## Notes

-   The SDK is compatible with both AppCompat and AndroidX

## Troubleshooting

-   **Issue**: The  `build.gradle`  file shows the following error:  _All com.android.support libraries must use the exact same version specification (mixing versions can lead to runtime crashes). Found versions 28.0.0, <X.X.X>._  
    **Solution**: Add an explicit dependency to your  `build.gradle`  file that forces Gradle to resolve the conflict on the V4 support library:  `implementation 'com.android.support:support-v4:28.0.0'`.
