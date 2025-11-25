package com.example.onboardingclever

import com.clevertap.android.sdk.ActivityLifecycleCallback
import io.flutter.app.FlutterApplication

class MyApplication : FlutterApplication() {
    override fun onCreate() {
        ActivityLifecycleCallback.register(this) // Must call this before super.onCreate()
        super.onCreate()
    }
}
