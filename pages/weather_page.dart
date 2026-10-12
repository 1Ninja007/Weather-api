import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_test/models/wather_model.dart';
import 'package:weather_test/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const new({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final _weatherService = WeatherService('f422e0ba0e8e41ec90c105042261010');
  Weather? _weather;  

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      }); 
    }

    catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(int code) {
    switch (code) {
      case 1000:
        return 'assets/sunny.json';
      case <= 1148:
        return 'assets/cloud.json';
      case <= 1254:
        return 'assets/rain.json';
      default:
        return 'assets/storm.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 50, 48, 48),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(_weather?.cityName ?? "loading city..."),

          

          Lottie.asset(getWeatherAnimation(_weather?.code ?? 0)),

          Text('\n${_weather?.temperature.round()}°C\n'),

          Text(_weather?.mainCondition ?? ""),
        ],
        ),
      ),
    );
  }
}