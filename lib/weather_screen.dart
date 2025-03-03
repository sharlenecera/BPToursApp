import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widgets/widgets.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _controller = TextEditingController();
  Future<List<Map<String, dynamic>>>? _futureSearchResults;
  final apiKey = 'd092a571f74a5876b63f080987632294';
  
  String _latitude = '';
  String _longitude = '';
  String _errorMessage = '';
  String _cityName = '';
  String _weatherDescription = '';
  String _mainTemperature = '';


  Future<List<Map<String, dynamic>>> _searchLocation() async {
      //   final text = _controller.text;
      // print('Searching for $text (${text.characters.length})');
    String city = _controller.text;
    if (city.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a location.';
      });
      return [];
    }

    final countryCode = 'GB';
    final resultsLimit = 5;
    final apiUrl = 'http://api.openweathermap.org/geo/1.0/direct?q=$city,$countryCode&limit=$resultsLimit&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.isNotEmpty) {
          return List<Map<String, dynamic>>.from(data.map((result) => {
            'latitude': result['lat'].toString(),
            'longitude': result['lon'].toString(),
            'cityName': result['name'],
          }));
        } else {
          setState(() {
            _errorMessage = 'Location not found.';
          });
          return [];
        }
      } else {
        setState(() {
          _errorMessage = 'Error getting data: ${response.statusCode}';
        });
        return [];
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error occurred: $e';
      });
      return [];
    }
  }

  Future<void> _getWeatherData() async {
  final apiUrl = 'https://api.openweathermap.org/data/2.5/weather?units=metric&lat=$_latitude&lon=$_longitude&appid=$apiKey';

  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _mainTemperature = data['main']['temp'].round().toString();
      _weatherDescription = data['weather'][0]['main'];
    } else {
      setState(() {
        _errorMessage = 'Error getting weather data: ${response.statusCode}';
      });
    }
  } catch (e) {
    setState(() {
      _errorMessage = 'Error occurred: $e';
    });
  }
}

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    // _controller.addListener(_searchLocation);
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
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: IconButton(
                    iconSize: 40,
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        _futureSearchResults = _searchLocation();
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          (_futureSearchResults != null) ? Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>( // Future<List<Map<String, dynamic>>>
              future: _futureSearchResults,
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot){
                List<Widget> children;

                if (snapshot.hasData) {
                    final results = snapshot.data!;

                    if (results.isEmpty) {
                      children = <Widget>[Center(child: Text('No results found'))];
                    }
                    // print(results);

                    _latitude = results[0]['latitude'];
                    _longitude = results[0]['longitude'];
                    _cityName = results[0]['cityName'];
                    _getWeatherData();
                    
                    children = <Widget>[Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // trying to display the results but currently not working
                        // Expanded(
                        //   child: ListView.builder(
                        //     itemCount: results.length,
                        //     itemBuilder: (context, index) {
                        //       final result = results[index];
                        //       return ListTile(
                        //         title: Text(result['cityName']),
                        //         subtitle: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text('Latitude: ${result['latitude']}'),
                        //             Text('Longitude: ${result['longitude']}'),
                        //           ],
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        Text('Latitude: $_latitude'),
                        Text('Longitude: $_longitude'),
                        if (_errorMessage.isNotEmpty)
                          Text(
                            _errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Text(_cityName.isNotEmpty ? _cityName : 'No Location', style: Theme.of(context).textTheme.headlineLarge),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Text('$_mainTemperature°C', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 80.0)),
                              SizedBox(width: 10),
                              Text('$_weatherDescription', style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 32.0)),
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
                    )];
                  } else if (snapshot.hasError) {
                    children = <Widget>[Center(child: Text('Error: ${snapshot.error}'))];
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    children = const <Widget>[
                      SizedBox(width: 60, height: 60, child: CircularProgressIndicator()),
                      Padding(padding: EdgeInsets.only(top: 16), child: Text('Loading...')),
                    ];
                  } else {
                    children = <Widget>[Center(child: Text('No data available'))];
                  }

                return Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: children)
                );
              }
            )
          ) : Text('No results found'),
        ],
      ),
    ) ;
  }
}



