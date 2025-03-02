
import 'package:flutter/material.dart';
import 'widgets/widgets.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  void searchLocation(String location) {
    print('Searching for $location');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFACD4AE),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField( // TODO: Implement a text input widget to reuse
              decoration: InputDecoration(
                hintText: 'Search Location',
                border: OutlineInputBorder(),
              ),
              
              onChanged: (value) {
                searchLocation(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                Text('London', style: Theme.of(context).textTheme.headlineLarge),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                Text('5°C', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 80.0)),
                SizedBox(width: 10),
                Text('Cloudy', style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 32.0)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                Text('Feb 11, 2025', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20.0)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 104,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        HourlyTemperature(time: '7:00', temperature: '5°C'),
                        HourlyTemperature(time: '8:00', temperature: '5°C'),
                        HourlyTemperature(time: '9:00', temperature: '5°C'),
                        HourlyTemperature(time: '10:00', temperature: '5°C'),
                        HourlyTemperature(time: '11:00', temperature: '6°C'),
                        HourlyTemperature(time: '12:00', temperature: '7°C'),
                        HourlyTemperature(time: '13:00', temperature: '8°C'),
                        HourlyTemperature(time: '14:00', temperature: '7°C'),
                      ],
                    )
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ) ;
  }
}
