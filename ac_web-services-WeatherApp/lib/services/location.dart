import 'package:geolocator/geolocator.dart';

class LocationService {
  double lat;
  double lon;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      lat = position.latitude;
      lon = position.longitude;
      print('phone location retrieved: YES  lon: $lon  lat: $lat');
    } catch (e) {
      print('phone location retrieved: NO  ERROR: $e');
    }
  }
}
