import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_weather_app/additional_info_item.dart';
import 'package:flutter_weather_app/hourly_forecast_item.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Weather App',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              "300 F",
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Icon(Icons.cloud, size: 64),
                            SizedBox(
                              height: 16,
                            ),
                            Text("Rain", style: TextStyle(fontSize: 20))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Weather Forecast",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    HourlyForecastItem(
                      icon: Icons.cloud,
                      time: "09:00",
                      value: "300 F",
                    ),
                    HourlyForecastItem(
                      icon: Icons.cloud,
                      time: "09:00",
                      value: "300 F",
                    ),
                    HourlyForecastItem(
                      icon: Icons.cloud,
                      time: "09:00",
                      value: "300 F",
                    ),
                    HourlyForecastItem(
                      icon: Icons.cloud,
                      time: "09:00",
                      value: "300 F",
                    ),
                    HourlyForecastItem(
                      icon: Icons.cloud,
                      time: "09:00",
                      value: "300 F",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Additional Information",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfoItem(
                    icon: Icons.water_drop,
                    lable: "Humidity",
                    value: "91",
                  ),
                  AdditionalInfoItem(
                    icon: Icons.water_drop,
                    lable: "Humidity",
                    value: "7.5",
                  ),
                  AdditionalInfoItem(
                    icon: Icons.beach_access,
                    lable: "Pressure",
                    value: "1000",
                  )
                ],
              )
            ],
          ),
        ));
  }
}
