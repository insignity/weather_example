import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_example/models/weather_forecast_daily.dart';
import 'package:weather_example/utilities/forecast_util.dart';

void main() => runApp(CityView());

class CityView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast>? snapshot;
  const CityView({this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot?.data?.list;
    var city = snapshot?.data?.city.name;
    var country = snapshot?.data?.city.country;
    var formattedDate =
        DateTime.fromMillisecondsSinceEpoch(forecastList![0].dt! * 1000);

    return Container(
      child: Column(
        children: [
          Text(
            '$city, $country',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.black87),
          ),
          Text(
            '${Util.getFromattedDate(formattedDate)}',
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
