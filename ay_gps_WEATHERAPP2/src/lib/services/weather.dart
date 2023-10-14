//Edmonton, Alberta Data
//lon = -113.469
//lat = 53.55

import 'package:robbinlaw/services/location.dart';
import 'package:robbinlaw/services/network.dart';

const apiKey = 'eada4f9ea302c58abd6d02fb791a812a';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherService {
  Future<dynamic> getLocationWeatherData() async {
    LocationService locationService = LocationService();
    await locationService.getCurrentLocation();
    Uri url = Uri(
      scheme: 'https',
      host: 'api.openweathermap.org',
      path: '/data/2.5/weather',
      query: 'lat=${locationService.lat}&lon=${locationService.lon}&units=metric&appid=$apiKey'
    );
    print('url is: $url');
    
    NetworkService networkService = NetworkService(url);
    var weatherData = await networkService.getData();
    return weatherData;
  }

  Future<dynamic> getCityWeatherData(String cityName) async {
    var urla = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    Uri url = Uri(
      scheme: 'https',
      host: 'api.openweathermap.org',
      path: '/data/2.5/weather',
      query: 'q=$cityName&appid=$apiKey&units=metric'
    );
    NetworkService networkService = NetworkService(url);
    var weatherData = await networkService.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
