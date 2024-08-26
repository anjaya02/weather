import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationService {
  Future<String> getCityNameFromCurrentLocation() async {
    // Get the permission from the user to access the location
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Get the current location using the updated settings
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Convert the location into a list of placemarks
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // Extract the city name from the placemarks
    String cityName = placeMarks[0].locality!;

    return cityName;
  }
}
