import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_test/models/wather_model.dart';
import 'package:http/http.dart' as http;


final Geocoding geocoding = Geocoding();

class WeatherService {

  static const BASE_URL = 'http://api.weatherapi.com/v1/current.json';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$BASE_URL?&key=$apiKey&q=$cityName&aqi=no'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } 
    else {
      throw Exception('Failed to load the weather data');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;

    return city ?? "";
  }
}