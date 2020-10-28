import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen2 extends StatefulWidget {
  @override
  _LoadingScreen2State createState() => _LoadingScreen2State();
}

class _LoadingScreen2State extends State<LoadingScreen2> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  var lat;
  var lon;
  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWether();
    var latitude = weatherData['coord']['lat'];
    print(latitude);
    var longitude = weatherData['coord']['lon'];
    print(longitude);
    var weatherDescription = weatherData['weather'][0]['description'];
    print(weatherDescription);
    var temperature = weatherData['main']['temp'];
    print(temperature);
    var cityName = weatherData['name'];
    print(cityName);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
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
