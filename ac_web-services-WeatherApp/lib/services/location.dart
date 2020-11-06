import 'package:geolocator/geolocator.dart';

class Location {
  double lat;
  double lon;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      lat = position.latitude;
      lon = position.longitude;
      print('geolocation of phone retrieved: YES');
      print('geolocation latitude is $lat');
      print('geolocation longitude is $lon');
    } catch (e) {
      print('geolocation of phone retrieved: NO');
      print(e);
    }
  }
}
