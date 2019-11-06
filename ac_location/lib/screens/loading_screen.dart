import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/screens/location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  static const apiKey = 'eada4f9ea302c58abd6d02fb791a812a';
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  var lat;
  var lon;
  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    lat = location.latitude;
    lon = location.longitude;
    lat = 53.55;
    lon = -113.469;
    print('latitude is $lat');
    print('longitude is $lon');
    String url = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey';
    NetworkHelper networkHelper = new NetworkHelper(url);
    var weatherData = await networkHelper.getData();
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
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
