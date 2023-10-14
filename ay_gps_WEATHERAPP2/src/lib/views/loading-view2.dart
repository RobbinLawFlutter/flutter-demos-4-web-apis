import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:robbinlaw/services/weather.dart';
import 'package:robbinlaw/views/location-view.dart';

class LoadingView2 extends StatefulWidget {
  const LoadingView2 ({Key? key}) : super(key: key);
  @override
  LoadingView2State createState() => LoadingView2State();
}

class LoadingView2State extends State<LoadingView2> {
  @override
  void initState() {
    print('initState started');
    super.initState();
    getPhoneLocationWeatherData();
  }

  void getPhoneLocationWeatherData() async {
    WeatherService weatherService = WeatherService();
    print('just before call to weatherService.getLocationWeatherData()');
    var weatherData = await weatherService.getLocationWeatherData();
    print('just after call to weatherService.getLocationWeatherData()');
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationView(locationWeather: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    print('build started');
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
