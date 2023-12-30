import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:dtheme/weather_model.dart';

class WeatherServices {
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherServices(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to load weather data. Status code: ${response.statusCode}');
      print('Error message: ${response.body}');
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    // get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      String? city = placemarks[0].locality;
      return city ?? "";
    } else {
      throw Exception('Failed to fetch current city');
    }
  }
}
