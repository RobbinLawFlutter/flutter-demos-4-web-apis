//Geolocator package from pub.dev
//https://pub.dev/packages/geolocator

//In android/app/src/main/AndroidManifest.xml
//we must copy the following directly under the
//<manifest> tag
//<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
//<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />

//In ios/Runner/Info.plist
//<key>NSLocationWhenInUseUsageDescription</key>
//<string>This app needs access to location when open.</string>
//<key>NSLocationAlwaysUsageDescription</key>
//<string>This app needs access to location when in the background.</string>

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:robbinlaw/services/location.dart';

class LoadingView1 extends StatefulWidget {
  @override
  _LoadingView1State createState() => _LoadingView1State();
}

class _LoadingView1State extends State<LoadingView1> {
  LocationService locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              await locationService.getCurrentLocation();
            },
            child: Text('Get Location'),
          ),
          SpinKitDoubleBounce(
            color: Colors.white,
            size: 100,
          ),
        ],
      ),
    );
  }
}
