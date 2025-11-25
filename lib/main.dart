import 'package:flutter/material.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Button App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // Initialize CleverTap
  void _initializeCleverTap() async {
    CleverTapPlugin.setDebugLevel(3); // Enable debug logging

    // Record a test event
    CleverTapPlugin.recordEvent("App Opened", {});
    print('CleverTap: App Opened event recorded');
  }

  @override
  Widget build(BuildContext context) {
    // Initialize CleverTap when widget builds
    _initializeCleverTap();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('CleverTap Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                print('Button 1 pressed');

                // 1. Track Product Viewed event
                var productData = {
                  'Product ID': 1,
                  'Product Image':
                      'https://d35fo82fjcw0y8.cloudfront.net/2018/07/26020307/customer-success-clevertap.jpg',
                  'Product Name': 'CleverTap',
                };
                CleverTapPlugin.recordEvent('Product Viewed', productData);
                print('CleverTap: Product Viewed event recorded');

                // 2. Push Email ID to profile
                var profile = {'Email': 'clevertap+cavalgo@gmail.com'};
                CleverTapPlugin.profileSet(profile);
                print('CleverTap: Email profile updated');
              },
              child: const Text('Button 1 - Product Viewed + Email'),
            ),
          ],
        ),
      ),
    );
  }
}
