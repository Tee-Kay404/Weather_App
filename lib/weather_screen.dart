import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/additionalInfoItem.dart';
import 'package:weather_app/secrets.dart';
import 'package:weather_app/hourly_forecast_item.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;
  final List<Map<String, String>> cities = [
    {
      'cityName': 'London',
      'countryName': 'United Kingdom',
      'countryCode': 'uk'
    },
    {
      'cityName': 'New York',
      'countryName': 'United States',
      'countryCode': 'us'
    },
    {'cityName': 'Tokyo', 'countryName': 'Japan', 'countryCode': 'jp'},
    {'cityName': 'Paris', 'countryName': 'France', 'countryCode': 'fr'},
    {'cityName': 'Sydney', 'countryName': 'Australia', 'countryCode': 'au'},
    {'cityName': 'Berlin', 'countryName': 'Germany', 'countryCode': 'de'},
    {'cityName': 'Moscow', 'countryName': 'Russia', 'countryCode': 'ru'},
    {
      'cityName': 'Cape Town',
      'countryName': 'South Africa',
      'countryCode': 'za'
    },
    {
      'cityName': 'Dubai',
      'countryName': 'United Arab Emirates',
      'countryCode': 'ae'
    },
    {
      'cityName': 'Rio de Janeiro',
      'countryName': 'Brazil',
      'countryCode': 'br'
    },
    {'cityName': 'Beijing', 'countryName': 'China', 'countryCode': 'cn'},
    {'cityName': 'Mexico City', 'countryName': 'Mexico', 'countryCode': 'mx'},
    {'cityName': 'Mumbai', 'countryName': 'India', 'countryCode': 'in'},
    {'cityName': 'Toronto', 'countryName': 'Canada', 'countryCode': 'ca'},
    {
      'cityName': 'Buenos Aires',
      'countryName': 'Argentina',
      'countryCode': 'ar'
    },
    {'cityName': 'Istanbul', 'countryName': 'Turkey', 'countryCode': 'tr'},
    {'cityName': 'Seoul', 'countryName': 'South Korea', 'countryCode': 'kr'},
    {'cityName': 'Rome', 'countryName': 'Italy', 'countryCode': 'it'},
    {'cityName': 'Bangkok', 'countryName': 'Thailand', 'countryCode': 'th'},
    {'cityName': 'Nairobi', 'countryName': 'Kenya', 'countryCode': 'ke'},
    {'cityName': 'Lagos', 'countryName': 'Nigeria', 'countryCode': 'ng'},
    {'cityName': 'Jakarta', 'countryName': 'Indonesia', 'countryCode': 'id'},
    {'cityName': 'Madrid', 'countryName': 'Spain', 'countryCode': 'es'},
    {
      'cityName': 'Kuala Lumpur',
      'countryName': 'Malaysia',
      'countryCode': 'my'
    },
    {'cityName': 'Cairo', 'countryName': 'Egypt', 'countryCode': 'eg'},
    {'cityName': 'Hong Kong', 'countryName': 'Hong Kong', 'countryCode': 'hk'},
    {'cityName': 'Lima', 'countryName': 'Peru', 'countryCode': 'pe'},
    {'cityName': 'Singapore', 'countryName': 'Singapore', 'countryCode': 'sg'},
    {'cityName': 'Athens', 'countryName': 'Greece', 'countryCode': 'gr'},
    {'cityName': 'Vienna', 'countryName': 'Austria', 'countryCode': 'at'},
    {'cityName': 'Tehran', 'countryName': 'Iran', 'countryCode': 'ir'},
    {'cityName': 'Santiago', 'countryName': 'Chile', 'countryCode': 'cl'},
    {'cityName': 'Baghdad', 'countryName': 'Iraq', 'countryCode': 'iq'},
    {'cityName': 'Helsinki', 'countryName': 'Finland', 'countryCode': 'fi'},
    {'cityName': 'Warsaw', 'countryName': 'Poland', 'countryCode': 'pl'},
    {'cityName': 'Lisbon', 'countryName': 'Portugal', 'countryCode': 'pt'},
    {'cityName': 'Stockholm', 'countryName': 'Sweden', 'countryCode': 'se'},
    {'cityName': 'Oslo', 'countryName': 'Norway', 'countryCode': 'no'},
    {'cityName': 'Brussels', 'countryName': 'Belgium', 'countryCode': 'be'},
    {'cityName': 'Zurich', 'countryName': 'Switzerland', 'countryCode': 'ch'},
    {'cityName': 'Budapest', 'countryName': 'Hungary', 'countryCode': 'hu'},
    {
      'cityName': 'Prague',
      'countryName': 'Czech Republic',
      'countryCode': 'cz'
    },
    {'cityName': 'Vienna', 'countryName': 'Austria', 'countryCode': 'at'},
    {'cityName': 'Kiev', 'countryName': 'Ukraine', 'countryCode': 'ua'},
    {'cityName': 'Havana', 'countryName': 'Cuba', 'countryCode': 'cu'},
    {'cityName': 'Lagos', 'countryName': 'Nigeria', 'countryCode': 'ng'},
    {'cityName': 'Accra', 'countryName': 'Ghana', 'countryCode': 'gh'},
    {
      'cityName': 'Dar es Salaam',
      'countryName': 'Tanzania',
      'countryCode': 'tz'
    },
    {'cityName': 'Addis Ababa', 'countryName': 'Ethiopia', 'countryCode': 'et'},
    {'cityName': 'Casablanca', 'countryName': 'Morocco', 'countryCode': 'ma'},
    {'cityName': 'Abuja', 'countryName': 'Nigeria', 'countryCode': 'ng'},
    {'cityName': 'Riyadh', 'countryName': 'Saudi Arabia', 'countryCode': 'sa'},
    {'cityName': 'Karachi', 'countryName': 'Pakistan', 'countryCode': 'pk'},
    {'cityName': 'Amman', 'countryName': 'Jordan', 'countryCode': 'jo'},
    {'cityName': 'Manila', 'countryName': 'Philippines', 'countryCode': 'ph'},
    {'cityName': 'Kathmandu', 'countryName': 'Nepal', 'countryCode': 'np'},
    {'cityName': 'Hanoi', 'countryName': 'Vietnam', 'countryCode': 'vn'},
    {'cityName': 'Colombo', 'countryName': 'Sri Lanka', 'countryCode': 'lk'},
    {'cityName': 'Kampala', 'countryName': 'Uganda', 'countryCode': 'ug'},
    {'cityName': 'Harare', 'countryName': 'Zimbabwe', 'countryCode': 'zw'},
  ];

  Future<Map<String, dynamic>> getCurrentWeather(
      String cityName, String countryCode, String countryName) async {
    try {
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,$countryCode&APPID=$openWeatherAPIKey'),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                // Refresh the data
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          final city = cities[index];
          return FutureBuilder<Map<String, dynamic>>(
            future: getCurrentWeather(
                city['cityName']!, city['countryName']!, city['countryCode']!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 500,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('No data available'));
              }

              final data = snapshot.data;

              if (data == null ||
                  data['list'] == null ||
                  data['list'].isEmpty) {
                return const Center(child: Text('No weather data found'));
              }

              final currentWeatherData = data['list'][0];
              final currentTemp = currentWeatherData['main']['temp'];
              final currentSky = currentWeatherData['weather'][0]['main'];
              final currentPressure = currentWeatherData['main']['pressure'];
              final currentWind = currentWeatherData['wind']['speed'];
              final currentHumidity = currentWeatherData['main']['humidity'];

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main card
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text(
                                    city['cityName']!,
                                    style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '$currentTemp K',
                                    style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                      currentSky == 'Clouds' ||
                                              currentSky == 'Rain'
                                          ? Icons.cloud
                                          : Icons.sunny,
                                      size: 64),
                                  Text(currentSky,
                                      style: const TextStyle(fontSize: 25))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Hourly forecast cards
                    const SizedBox(height: 20),
                    const Text('Hourly Forecast',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final hourlyForecast = data['list'][index + 1];
                          final hourlySky =
                              hourlyForecast['weather'][0]['main'];
                          final hourlyTemp =
                              hourlyForecast['main']['temp'].toString();
                          final time = DateTime.parse(hourlyForecast['dt_txt']);
                          return HourlyForecastItem(
                            // Correcting the DateFormat usage
                            time: DateFormat.j().format(time),
                            temperature: '$hourlyTemp K',
                            icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Additional information
                    const Text(
                      'Additional Information',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AdditionalInfoItem(
                            icon: Icons.water_drop,
                            label: 'Humidity',
                            value: currentHumidity.toString()),
                        AdditionalInfoItem(
                            icon: Icons.air,
                            label: 'Wind Speed',
                            value: currentWind.toString()),
                        AdditionalInfoItem(
                            icon: Icons.beach_access_sharp,
                            label: 'Pressure',
                            value: currentPressure.toString()),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
