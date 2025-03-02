import 'package:flutter/material.dart';
import 'widgets/widgets.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _controller = TextEditingController();

  void _searchLocation() {
    final text = _controller.text;
    print('Searching for $text (${text.characters.length})');

  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _controller.addListener(_searchLocation);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFACD4AE),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField( // TODO: Implement a text input widget to reuse
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Search Location',
                      border: OutlineInputBorder(),
                    ),
                    
                    // onChanged: (value) {
                    //   searchLocation(value);
                    // },
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: IconButton(
                    iconSize: 40,
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _searchLocation();
                    },
                  ),
                )
              ],
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
