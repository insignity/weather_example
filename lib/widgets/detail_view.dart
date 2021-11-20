import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_example/models/weather_forecast_daily.dart';
import 'package:weather_example/utilities/constants.dart';
import 'package:weather_example/utilities/forecast_util.dart';

class DetailView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast>? snapshot;
  const DetailView({this.snapshot});

  @override
  Widget build(BuildContext context) {
    List<WeatherList>? forecastList = snapshot?.data?.list;
    var pressure = forecastList![0].pressure! * 0.750062;
    var humidity = forecastList[0].humidity as int;
    var speed = forecastList[0].speed?.toInt() as int;
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Util.getItem(FontAwesomeIcons.thermometerThreeQuarters,
              pressure.round(), 'mm Hg'),
          Util.getItem(FontAwesomeIcons.cloudRain, humidity, '%'),
          Util.getItem(FontAwesomeIcons.wind, speed, 'm/s'),
        ],
      ),
    );
  }
}
