# CleverTap Integration Steps

**Project**: onboardingclever  
**Account ID**: TEST-WR7-899-K67Z  
**Token**: TEST-ccb-a20  
**Region**: us1

---

## Step 1: Add CleverTap Plugin to pubspec.yaml

```yaml
dependencies:
  clevertap_plugin: ^3.6.0
```

Run: `flutter pub get`

---

## Step 2: Android Configuration

### 2.1 AndroidManifest.xml - Add Permissions

File: `android/app/src/main/AndroidManifest.xml`

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
```

### 2.2 AndroidManifest.xml - Add CleverTap Credentials

Inside `<application>` tag:

```xml
<meta-data
    android:name="CLEVERTAP_ACCOUNT_ID"
    android:value="TEST-WR7-899-K67Z"/>
<meta-data
    android:name="CLEVERTAP_TOKEN"
    android:value="TEST-ccb-a20"/>
<meta-data
    android:name="CLEVERTAP_REGION"
    android:value="us1"/>
```

### 2.3 AndroidManifest.xml - Update Application Name

```xml
<application
    android:name=".MyApplication"
    ...>
```

### 2.4 Create Application Class

File: `android/app/src/main/kotlin/com/example/onboardingclever/MyApplication.kt`

```kotlin
package com.example.onboardingclever

import com.clevertap.android.sdk.ActivityLifecycleCallback
import io.flutter.app.FlutterApplication

class MyApplication : FlutterApplication() {
    override fun onCreate() {
        ActivityLifecycleCallback.register(this)
        super.onCreate()
    }
}
```

### 2.5 settings.gradle.kts - Add Google Services

File: `android/settings.gradle.kts`

```kotlin
plugins {
    id("com.google.gms.google-services") version "4.4.1" apply false
}
```

### 2.6 app/build.gradle.kts - Add Plugin and Dependencies

File: `android/app/build.gradle.kts`

**Add to plugins block:**

```kotlin
plugins {
    id("com.google.gms.google-services")
}
```

**Add dependencies:**

```kotlin
dependencies {
    implementation("com.google.firebase:firebase-messaging:23.4.0")
    implementation("androidx.core:core:1.12.0")
    implementation("androidx.fragment:fragment:1.6.2")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("androidx.recyclerview:recyclerview:1.3.2")
    implementation("androidx.viewpager:viewpager:1.0.0")
    implementation("com.google.android.material:material:1.11.0")
    implementation("com.github.bumptech.glide:glide:4.16.0")
    implementation("com.android.installreferrer:installreferrer:2.2")
    implementation("androidx.media3:media3-exoplayer:1.2.1")
    implementation("androidx.media3:media3-exoplayer-hls:1.2.1")
    implementation("androidx.media3:media3-ui:1.2.1")
}
```

---

## Step 3: iOS Configuration

### 3.1 Info.plist - Add CleverTap Credentials

File: `ios/Runner/Info.plist`

```xml
<key>CleverTapAccountID</key>
<string>TEST-WR7-899-K67Z</string>
<key>CleverTapToken</key>
<string>TEST-ccb-a20</string>
<key>CleverTapRegion</key>
<string>us1</string>
```

### 3.2 AppDelegate.swift - Initialize CleverTap

File: `ios/Runner/AppDelegate.swift`

```swift
import Flutter
import UIKit
import CleverTapSDK
import clevertap_plugin

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    CleverTap.autoIntegrate()
    CleverTapPlugin.sharedInstance()?.applicationDidLaunch(options: launchOptions)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### 3.3 Install CocoaPods

Run in terminal:

```bash
cd ios && pod install
```

---

## Step 4: Flutter Implementation

### 4.1 Import Plugin

```dart
import 'package:clevertap_plugin/clevertap_plugin.dart';
```

### 4.2 Initialize CleverTap

```dart
CleverTapPlugin.setDebugLevel(3);
CleverTapPlugin.recordEvent("App Opened", {});
```

### 4.3 Track User Profile

```dart
var profile = {
  'Name': 'Test User',
  'Email': 'test@example.com',
  'Identity': '12345',
};
CleverTapPlugin.onUserLogin(profile);
```

### 4.4 Track Custom Events

```dart
var eventData = {
  'Button': 'Button 1',
  'Timestamp': DateTime.now().toString(),
};
CleverTapPlugin.recordEvent('Button Clicked', eventData);
```

---

## Step 5: Test Integration

Run the app:

```bash
flutter run
```

Verify in CleverTap Dashboard:

- https://us1.dashboard.clevertap.com
- Check for new user in Dashboard
- Check Events tab for tracked events
- Search for user profile in Segments → Find People

---

## Notes

### Firebase (Optional - for Push Notifications)

To enable push notifications, add:

- **Android**: `google-services.json` in `android/app/`
- **iOS**: `GoogleService-Info.plist` in `ios/Runner/`

Download from: https://console.firebase.google.com/

---

**Status**: ✅ Integration Complete  
**Date**: November 24, 2025
