import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dtheme/services/weather_services.dart';
import 'package:dtheme/weather_model.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherServices('83f657e977a8dc11075a4e62c70290b9');
  Weather? _weather;
  bool _isLoading = true;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
        _isLoading = false; // Set loading to false after data is loaded
      });
    } catch (e) {
      print(e);
      _isLoading = false; // Set loading to false on error
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/sunny.json";

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'dust':
      case 'mist':
      case 'smoke':
      case 'fog':
      case 'haze':
        return "assets/Cloud.json";
      case 'rain':
      case 'shower rain':
      case 'drizzle':
        return "assets/rain.json";
      case 'thunderstorm':
        return "assets/thunder.json";
      case 'clear':
        return "assets/sunny.json";
      default:
        return "assets/sunny.json";
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Weather App',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: _isLoading ? _buildLoadingWidget() : _buildWeatherWidget(),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitCircle(
          color: Colors.blue, // Customize the color as needed
          size: 50.0,
        ),
        SizedBox(height: 20.0),
        Text('Loading...'),
      ],
    );
  }

  Widget _buildWeatherWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_weather?.cityName ?? "Loading City Name..."),
        Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
        Text('${_weather?.temperature.round().toString()}°C'),
        Text(_weather?.mainCondition ?? "")
      ],
    );
  }
}
