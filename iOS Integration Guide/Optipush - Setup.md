# Optipush Setup

## Notification Service Extension

### 1. Add `Notification Service Extension` Target

> Skip this step if you already have a Notification Service Extension target.

In order to enable Optimove to track the push notifications, you'll need to add a `Notification Service Extension` to your project. This app extension creates a process that handles incoming Push Notifications manipulation. To add this extension to your app:

1. Select `File > New > Target` on XCode.
2. Select the Notification Service Extension target from the `iOS > Application` section.
3. Click `Next`.
4. Specify a name for your extension.
5. Click `Finish`.
6. In your `Podfile` add a new target matching the extension's name.

**`Podfile` code snippet**

```ruby
platform :ios, '10.0'

target 'My Application' do # Your app target
  use_frameworks!
  pod 'OptimoveSDK', '~> 2.0' # We've added this dependency in a previous step
end

target 'NotificationExtension' do # Your new extension target
  use_frameworks!
  # Dependencies will be added here
end
```

### 2. Add the OptimoveNotificationServiceExtension SDK

1. Open your `Podfile`
2. Locate the `Notification Service Extension`'s `target` declaration
3. Adds

**`Podfile` code snippet**
```ruby
platform :ios, '10.0'
target 'My Application' do #Your app target
  use_frameworks!
  pod 'OptimoveSDK'
end
target 'NotificationExtension' do #Your new extension target
  use_frameworks!
  # Add OptimoveNotificationServiceExtension below
  pod 'OptimoveNotificationServiceExtension'
end
``` 

> **Important Note**: 
> The extension versioning must be aligned with the application, so make sure that the extension's `Deployment Target` (found in the project's settings page) is the **same** as the app's `Deployment Target


## App Group
In order to enable communication between the extension and the application, add an `App group` capability in both the app and the extension targets. The group name convention should be: `group.<the application bundle id>.optimove`<br>

![\[Screenshot\]](https://raw.githubusercontent.com/optimove-tech/Optipush-Guide/master/Opitpush%20for%20iOS/Screen%20Shot%202018-07-02%20at%2018.06.21.png)

To implement the service's logic open the `NotificationService.swift` file.
Inside, you'll find 2 callbacks that are defined by iOS:

- `func didReceive(request:contentHandler:)` - Called with the content of the push notification
- `func serviceExtensionTimeWillExpire()` - Called when the OS is about to _force kill_ the extension's process

Both of these callbacks must be implemented by **your** extension and forwarded to the **Optimove Notification Extension Module**.


## `didReceive` callback
TODO: Noy do we need this bit "NotificationExtensionTenantInfo" ?


## Optipush: Handling Dynamic Deep Links from Optimove
To handle **Dynamic Deep Links** the `OptimoveDeepLinkComponents` Object has a new property called `parameters` to support dynamic parameters when using deep linking.

Example of handling **Dynamic Deep Links**:
TODO: What about error handling? ELI: Added placeholder to an error handling.
TODO: Noy can we give a real example for ios and android how to parse the params - best practice?
```swift
class ViewController: UIViewController, OptimoveDeepLinkCallback {

    func didReceive(deepLink: OptimoveDeepLinkComponents?) {
        let deepLinkVC = storyboard?.instantiateViewController(withIdentifier: "deepLinkVc")
        guard let deepLink = deepLink,
              let deepLinkVC as? DeepLinkViewController else { 
              // Here you could handle an error
              return 
        }
        
        deepLinkVC.deepLinkComp = deepLink
        
        // Retrieve the targetted screen name
        let screenName = deepLink.screenName
        
        // Retrieve the deep link Key-Value parameters
        let deepLinkParams = deepLink.parameters
        
        present(deepLinkVC, animated: true)
    }
}
```

TODO: Noy User Notification Center Delegate ???


## Optional: Customize Optipush message
TODO: Noy do we even have this in iOS?
You add icons & color to your Optipush message by adding the following meta-data to `AndroidManifest.xml`, inside the `<application></application>` tag:

```xml
<meta-data
    android:name="com.optimove.sdk.custom-notification-icon"
    android:resource="@drawable/send_icon"/>
<meta-data
    android:name="com.optimove.sdk.custom-notification-color"
    android:resource="@android:color/holo_red_light"/>
 ```
