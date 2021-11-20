import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_example/api/weather_api.dart';
import 'package:weather_example/models/weather_forecast_daily.dart';
import 'package:weather_example/screens/city_screen.dart';
import 'package:weather_example/widgets/button_list_view.dart';
import 'package:weather_example/widgets/city_view.dart';
import 'package:weather_example/widgets/detail_view.dart';
import 'package:weather_example/widgets/temp_view.dart';

class WeatherForecastScreen extends StatefulWidget {
  final locationWeather;

  const WeatherForecastScreen({Key? key, this.locationWeather})
      : super(key: key);

  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  Future<WeatherForecast>? forecastObject;
  String? _cityName;

  @override
  void initState() {
    super.initState();

    if (widget.locationWeather != null) {
      forecastObject = Future.value(widget.locationWeather);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('openweathermap.org'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.my_location),
          onPressed: () {
            setState(() {
              forecastObject = WeatherApi()
                  .fetchWeatherForecast(cityName: _cityName, isCity: true);
            });
          },
        ),
        actions: [
          IconButton(
              onPressed: () async {
                var tappedName = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CityScreen()));
                if (tappedName != null) {
                  _cityName = tappedName;
                  forecastObject = WeatherApi()
                      .fetchWeatherForecast(cityName: _cityName, isCity: true);
                  setState(() {});
                }
              },
              icon: Icon(Icons.location_city))
        ],
      ),
      body: ListView(
        children: [
          FutureBuilder<WeatherForecast>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    CityView(
                      snapshot: snapshot,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TempView(snapshot: snapshot),
                    const SizedBox(
                      height: 50,
                    ),
                    DetailView(
                      snapshot: snapshot,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ButtonListView(
                      snapshot: snapshot,
                    ),
                  ],
                );
              } else {
                return const Center(
                    child: Text(
                  'City not found\nPlease, enter correct city',
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ));
              }
            },
            future: forecastObject,
          )
        ],
      ),
    );
  }
}
