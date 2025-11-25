# CleverTap Integration Documentation

## Project Information

- **CleverTap Account ID**: TEST-WR7-899-K67Z
- **CleverTap Token**: TEST-ccb-a20
- **Region**: us1
- **Dashboard URL**: https://us1.dashboard.clevertap.com

## Integration Status: ✅ COMPLETE

---

## 1. Flutter SDK Setup

### pubspec.yaml

```yaml
dependencies:
  clevertap_plugin: ^3.6.0
```

**Installed**: ✅ Run `flutter pub get` to install

---

## 2. Android Configuration

### 2.1 AndroidManifest.xml

Location: `android/app/src/main/AndroidManifest.xml`

**Permissions** (Added):

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
```

**CleverTap Credentials** (Added inside `<application>` tag):

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

**Application Class** (Updated):

```xml
<application
    android:name=".MyApplication"
    ...>
```

### 2.2 Gradle Configuration

**settings.gradle.kts** (Project level):

```kotlin
plugins {
    id("com.google.gms.google-services") version "4.4.1" apply false
}
```

**app/build.gradle.kts**:

```kotlin
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // For Firebase Messaging
}

dependencies {
    // Firebase Messaging (for push notifications)
    implementation("com.google.firebase:firebase-messaging:23.4.0")
    implementation("androidx.core:core:1.12.0")
    implementation("androidx.fragment:fragment:1.6.2")

    // MANDATORY for App Inbox
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("androidx.recyclerview:recyclerview:1.3.2")
    implementation("androidx.viewpager:viewpager:1.0.0")
    implementation("com.google.android.material:material:1.11.0")
    implementation("com.github.bumptech.glide:glide:4.16.0")

    // For CleverTap Android SDK v3.6.4 and above
    implementation("com.android.installreferrer:installreferrer:2.2")

    // Optional AndroidX Media3 Libraries for Audio/Video Inbox Messages
    implementation("androidx.media3:media3-exoplayer:1.2.1")
    implementation("androidx.media3:media3-exoplayer-hls:1.2.1")
    implementation("androidx.media3:media3-ui:1.2.1")
}
```

### 2.3 Application Class

Location: `android/app/src/main/kotlin/com/example/onboardingclever/MyApplication.kt`

```kotlin
package com.example.onboardingclever

import com.clevertap.android.sdk.ActivityLifecycleCallback
import io.flutter.app.FlutterApplication

class MyApplication : FlutterApplication() {
    override fun onCreate() {
        ActivityLifecycleCallback.register(this) // Must call before super.onCreate()
        super.onCreate()
    }
}
```

### 2.4 Firebase Setup (For Push Notifications)

**TODO**: Add `google-services.json` file

- Download from: https://console.firebase.google.com/
- Package name: `com.example.onboardingclever`
- Place in: `android/app/google-services.json`

---

## 3. iOS Configuration

### 3.1 Info.plist

Location: `ios/Runner/Info.plist`

**CleverTap Credentials** (Added):

```xml
<key>CleverTapAccountID</key>
<string>TEST-WR7-899-K67Z</string>
<key>CleverTapToken</key>
<string>TEST-ccb-a20</string>
<key>CleverTapRegion</key>
<string>us1</string>
```

### 3.2 AppDelegate.swift

Location: `ios/Runner/AppDelegate.swift`

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
    CleverTap.autoIntegrate() // Integrate CleverTap SDK
    CleverTapPlugin.sharedInstance()?.applicationDidLaunch(options: launchOptions)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### 3.3 CocoaPods

**Installed**: ✅ Run `pod install` in `ios/` directory

### 3.4 Firebase Setup (For Push Notifications)

**TODO**: Add `GoogleService-Info.plist` file

- Download from: https://console.firebase.google.com/
- Bundle ID: Check your Info.plist or project settings
- Place in: `ios/Runner/GoogleService-Info.plist`

---

## 4. Flutter Implementation

### 4.1 Import CleverTap Plugin

```dart
import 'package:clevertap_plugin/clevertap_plugin.dart';
```

### 4.2 Initialize CleverTap

```dart
void initializeCleverTap() async {
  CleverTapPlugin.setDebugLevel(3); // Enable debug logging (0-3)

  // Record initial event
  CleverTapPlugin.recordEvent("App Opened", {});
}
```

### 4.3 Track User Profile

```dart
void trackUserProfile() {
  var profile = {
    'Name': 'John Doe',
    'Email': 'john@example.com',
    'Identity': 'user123',  // Unique user identifier
    'Phone': '+1234567890',
    'Gender': 'M',          // M/F
    'DOB': '1990-01-01',    // Date format: YYYY-MM-DD
    // Add custom properties
    'Plan': 'Premium',
    'Registered On': DateTime.now().toString(),
  };
  CleverTapPlugin.onUserLogin(profile);
}
```

### 4.4 Track Custom Events

```dart
void trackCustomEvent(String eventName, Map<String, dynamic> properties) {
  CleverTapPlugin.recordEvent(eventName, properties);
}

// Example usage:
trackCustomEvent('Product Viewed', {
  'Product Name': 'iPhone 15',
  'Category': 'Electronics',
  'Price': 999.99,
  'Currency': 'USD',
});
```

### 4.5 Update User Profile (Without Login)

```dart
void updateUserProfile() {
  var profileUpdate = {
    'Favorite Color': 'Blue',
    'Last Purchase': DateTime.now().toString(),
  };
  CleverTapPlugin.profilePush(profileUpdate);
}
```

---

## 5. Implemented Features in App

### Current Implementation (lib/main.dart)

**Button 1**: Track Custom Event

- Event: "Button 1 Clicked"
- Properties: Button name, timestamp

**Button 2**: Set User Profile

- Creates/updates user profile with test data
- Identity: "12345"
- Name: "Test User"
- Email: "test@example.com"

**On App Open**: Automatically tracks "App Opened" event

---

## 6. Testing & Verification

### Test the Integration:

1. **Run the app**:

   ```bash
   flutter run
   ```

2. **Check logs** for CleverTap debug messages:

   - Android: Look for "CleverTap" in logcat
   - iOS: Look for "CleverTap" in Xcode console

3. **Verify in Dashboard**:
   - Go to: https://us1.dashboard.clevertap.com
   - Navigate to: **Dashboard** → See new active user
   - Navigate to: **Events** → See "App Opened" and custom events
   - Navigate to: **Segments** → **Find People** → Search by email to see user profile

### Expected Behavior:

- ✅ New user appears in dashboard within 1-2 minutes
- ✅ "App Opened" event tracked automatically
- ✅ Custom events appear when buttons are clicked
- ✅ User profile created/updated when Button 2 is clicked

---

## 7. Common CleverTap APIs

### User Profile Management

```dart
// Login/Create user
CleverTapPlugin.onUserLogin(profile);

// Update profile
CleverTapPlugin.profilePush(properties);

// Get CleverTap ID
String? cleverTapId = await CleverTapPlugin.profileGetCleverTapID();

// Remove profile value
CleverTapPlugin.profileRemoveValueForKey('keyName');
```

### Event Tracking

```dart
// Record event
CleverTapPlugin.recordEvent(eventName, properties);

// Record charged event (purchase)
CleverTapPlugin.recordChargedEvent({
  'Amount': 99.99,
  'Currency': 'USD',
  'Payment Mode': 'Credit Card',
}, [
  {'Product Name': 'Product 1', 'Price': 49.99},
  {'Product Name': 'Product 2', 'Price': 50.00},
]);
```

### Push Notifications

```dart
// Create notification channel (Android)
CleverTapPlugin.createNotificationChannel(
  'channelId',
  'Channel Name',
  'Channel Description',
  5, // importance
  true, // showBadge
);

// Request push permission
CleverTapPlugin.promptForPushPermission(true);
```

### App Inbox

```dart
// Get inbox message count
int? unread = await CleverTapPlugin.getInboxMessageUnreadCount();
int? total = await CleverTapPlugin.getInboxMessageCount();

// Show App Inbox
CleverTapPlugin.showAppInbox({});
```

### In-App Notifications

```dart
// Suspend/Resume in-apps
CleverTapPlugin.suspendInAppNotifications();
CleverTapPlugin.resumeInAppNotifications();

// Discard in-app queue
CleverTapPlugin.discardInAppNotifications();
```

---

## 8. Debug Mode

### Enable/Disable Debug Logging

```dart
CleverTapPlugin.setDebugLevel(3); // 0 = off, 1 = info, 2 = debug, 3 = verbose
```

### Android Logs

```bash
adb logcat | grep CleverTap
```

### iOS Logs

View in Xcode Console or:

```bash
flutter run --verbose
```

---

## 9. Next Steps

### Optional Enhancements:

1. **Push Notifications**:

   - [ ] Add google-services.json (Android)
   - [ ] Add GoogleService-Info.plist (iOS)
   - [ ] Set up APNs certificates (iOS)
   - [ ] Test push notifications

2. **In-App Messaging**:

   - [ ] Create campaigns in CleverTap dashboard
   - [ ] Test in-app notifications

3. **App Inbox**:

   - [ ] Implement App Inbox UI
   - [ ] Add badge counts

4. **Advanced Features**:
   - [ ] Product Config (Remote Config)
   - [ ] A/B Testing
   - [ ] Geofencing

---

## 10. Important Notes

### Privacy & Compliance

- **GDPR**: Use `CleverTapPlugin.setOptOut(true/false)` for user consent
- **Data Deletion**: Use `CleverTapPlugin.profileRemoveValueForKey()` to remove data

### Google Advertising ID (Optional)

Not added - if needed, add to AndroidManifest.xml:

```xml
<meta-data
    android:name="CLEVERTAP_USE_GOOGLE_AD_ID"
    android:value="1"/>
```

⚠️ Requires prominent disclosure to users per GDPR

### Multi-Instance Support

Not configured - single instance mode (default)

---

## 11. Resources

- **CleverTap Dashboard**: https://us1.dashboard.clevertap.com
- **Documentation**: https://developer.clevertap.com/docs/flutter-quick-start-guide
- **Flutter SDK GitHub**: https://github.com/CleverTap/clevertap-flutter
- **Example Project**: https://github.com/CleverTap/clevertap-flutter/tree/master/example
- **Support**: support@clevertap.com

---

## 12. Troubleshooting

### Issue: Events not showing in dashboard

- Check internet connection
- Verify credentials (Account ID, Token, Region)
- Enable debug logging and check logs
- Wait 1-2 minutes for data to sync

### Issue: Push notifications not working

- Ensure google-services.json is added
- Check FCM setup in Firebase Console
- Verify package name matches

### Issue: Build errors

- Run `flutter clean`
- Run `flutter pub get`
- Android: Run `./gradlew clean` in android folder
- iOS: Run `pod install` in ios folder

---

**Last Updated**: November 24, 2025
**Integration Completed By**: GitHub Copilot
**Status**: Production Ready (pending Firebase config files)
