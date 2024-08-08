import 'package:device_info_plus/device_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';

Widget connectivityWidget(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: const Text(
        'GitHub Users App Offline',
        style: TextStyle(color: Colors.white),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.asset(
            'assets/no_internet.png', // Replace with your image asset path
            width: 200, // Adjust the width as needed
            height: 200, // Adjust the height as needed
            fit: BoxFit.contain, // Adjust the fit as needed
          ),
          const SizedBox(height: 20), // Space between image and text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              'Oops! No Internet Connection!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              'It seems there is something wrong with your internet connection. Please connect to the internet and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(height: 20), // Space between text and button
          ElevatedButton(
            onPressed: () {
              Connectivity().checkConnectivity().then((result) {
                if (result == ConnectivityResult.none) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "Check your network cables, modem, routers, and Wi-Fi connection",
                        ),
                        content: const Text(
                          "Please check your connection and try again.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              openSettings();
                            },
                            child: const Text(
                              "Internet Settings",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Button background color
            ),
            child: const Text(
              'Try Again',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
