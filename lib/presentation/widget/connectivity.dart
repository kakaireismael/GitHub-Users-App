import 'package:device_info_plus/device_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';

Widget connectivityWidget(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue[700],
      centerTitle: true,
      title: const Text(
        'GitHub Users',
        style: TextStyle(color: Colors.white),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'No Internet Connection Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey, // Ensure text is visible on a white background
            ),
          ),
          const SizedBox(height: 20), // Added space between the text and button
          ElevatedButton(
            onPressed: () {
              Connectivity().checkConnectivity().then((result) {
                if (result == ConnectivityResult.none) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "Check your network cables, modem, routers and Wi-Fi connection",
                        ),
                        content: const Text(
                          "Please check your connection and try again",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              openSettings();
                            },
                            child: const Text(
                              "Internet Settings",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
            child: const Text(
              'Try Again',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Button background color
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> openSettings() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

  if (androidInfo.version.sdkInt >= 21) {
    const AndroidIntent intent = AndroidIntent(
      action: 'android.settings.SETTINGS',
    );
    await intent.launch();
  } else {
    throw 'Device does not support required settings';
  }
}
