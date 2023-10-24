import 'package:flutter/material.dart';
import 'package:robbinlaw/utilities/constants.dart';
import 'package:robbinlaw/services/weather.dart';
import 'package:robbinlaw/views/city-view.dart';

class LocationView extends StatefulWidget {
  const LocationView ({Key? key, required this.locationWeather}) : super(key: key);
  //const LocationView(this.locationWeather);
  final locationWeather;
  @override
  LocationViewState createState() => LocationViewState();
}

class LocationViewState extends State<LocationView> {
  
  WeatherService weatherService = WeatherService();
  late String weatherDescription;
  late int temperature;
  //double temperature;
  late String weatherIcon;
  late String cityName;
  late String weatherMessage;

  @override
  void initState() {
    super.initState();
    //print(widget.locationWeather);
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      weatherDescription = weatherData['weather'][0]['description'];
      print(weatherDescription);
      double temp = weatherData['main']['temp'];
      //temperature = temp;
      temperature = temp.toInt();
      print(temperature);
      int condition = weatherData['weather'][0]['id'];
      print(condition);
      weatherIcon = weatherService.getWeatherIcon(condition);
      cityName = weatherData['name'];
      print(cityName);
      weatherMessage = weatherService.getMessage(temperature);
      print(weatherMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData =
                          await weatherService.getLocationWeatherData();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedCityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityView();
                          },
                        ),
                      );
                      print('User entered City Name: $typedCityName');
                      if (typedCityName != null) {
                        var weatherData = await weatherService
                            .getCityWeatherData(typedCityName);
                        updateUI(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°C',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
