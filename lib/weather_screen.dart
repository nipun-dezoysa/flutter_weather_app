import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather_app/additional_info_item.dart';
import 'package:flutter_weather_app/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      await dotenv.load(fileName: ".env");
      String key = dotenv.get('API_KEY');
      String city = "London";
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$city,uk&APPID=$key'));
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'An Unexpected error occurred';
      }

      return data;
      // temp = data['list'][0]['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

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
        body: FutureBuilder(
          future: getCurrentWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: const CircularProgressIndicator.adaptive());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            final data = snapshot.data!;
            final currentData = data['list'][0];
            final currentTemp = currentData['main']['temp'];
            final currentSky = currentData['weather'][0]['main'];
            return Padding(
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
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  "$currentTemp F",
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Icon(
                                    currentSky == 'Clouds' ||
                                            currentSky == 'Rain'
                                        ? Icons.cloud
                                        : Icons.sunny,
                                    size: 64),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(currentSky,
                                    style: const TextStyle(fontSize: 20))
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
            );
          },
        ));
  }
}
