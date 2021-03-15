import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:robbinlaw/services/weather.dart';
import 'package:robbinlaw/views/location-view.dart';

class LoadingScreen2 extends StatefulWidget {
  @override
  _LoadingScreen2State createState() => _LoadingScreen2State();
}

class _LoadingScreen2State extends State<LoadingScreen2> {
  @override
  void initState() {
    print('initState started');
    super.initState();
    getPhoneLocationWeatherData();
  }

  void getPhoneLocationWeatherData() async {
    WeatherService weatherService = WeatherService();
    print('just before call to get weather data');
    var weatherData = await weatherService.getLocationWeatherData();
    print('just after call to get weather data');
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    print('build started');
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
