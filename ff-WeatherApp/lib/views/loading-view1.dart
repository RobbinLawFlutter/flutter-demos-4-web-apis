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
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:robbinlaw/services/weather.dart';
import 'package:robbinlaw/views/location-view.dart';

class LoadingScreen1 extends StatefulWidget {
  @override
  _LoadingScreen1State createState() => _LoadingScreen1State();
}

class _LoadingScreen1State extends State<LoadingScreen1> {
  void getLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      print(position);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        RaisedButton(
          onPressed: () {
            getLocation();
          },
          child: Text('Get Location'),
        ),
        SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ]),
    );
  }
}
