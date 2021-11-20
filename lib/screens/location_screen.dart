import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_example/api/weather_api.dart';
import 'package:weather_example/models/weather_forecast_daily.dart';
import 'package:weather_example/screens/weather_forecast_screen.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  void getLocationData() async {
    try {
      WeatherForecast weatherInfo = await WeatherApi().fetchWeatherForecast();

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WeatherForecastScreen(
                    locationWeather: weatherInfo,
                  )));
    } catch (e) {
      print('$e');
    }
  }

  @override
  void initState() {
    super.initState();

    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitCircle(
          color: Colors.black87,
          size: 100,
        ),
      ),
    );
  }
}
