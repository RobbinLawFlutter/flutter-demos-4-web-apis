import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen1 extends StatefulWidget {
  @override
  _LoadingScreen1State createState() => _LoadingScreen1State();
}

class _LoadingScreen1State extends State<LoadingScreen1> {
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
