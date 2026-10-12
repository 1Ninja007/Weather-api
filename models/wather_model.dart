class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final int code;

  Weather({
    required this.cityName, 
    required this.temperature, 
    required this.mainCondition,
    required this.code
    });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['location']['name'], 
      temperature: json['current']['temp_c'].toDouble(), 
      mainCondition: json['current']['condition']['text'],
      code: json['current']['condition']['code'],
    );
  }
}