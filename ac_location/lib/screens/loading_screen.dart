import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  static const apiKey = 'eada4f9ea302c58abd6d02fb791a812a';
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  var lat;
  var lon;
  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    lat = location.latitude;
    lon = location.longitude;
    lat = 53.55;
    lon = -113.469;
    print('latitude is $lat');
    print('longitude is $lon');
    getData();
  }

  void getData() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey');
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      var latitude = decodedData['coord']['lat'];
      print(latitude);
      var longitude = decodedData['coord']['lon'];
      print(longitude);
      var weatherDescription = decodedData['weather'][0]['description'];
      print(weatherDescription);
      var temperature = decodedData['main']['temp'];
      print(temperature);
      var cityName = decodedData['name'];
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
