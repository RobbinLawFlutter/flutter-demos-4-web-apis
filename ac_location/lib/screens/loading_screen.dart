import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print('latitude is ${location.latitude}');
    print('longitude is ${location.longitude}');
  }

  void getData() async {
    http.Response response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?lat=53.5461&lon=113.4938&appid=b6907d289e10d714a6e88b30761fae22');
    print(response.statusCode);
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
    getData();
    return Scaffold();
  }
}
