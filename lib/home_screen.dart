import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'widgets/widgets.dart';
import 'weather_screen.dart';
import 'profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.username, super.key});

  final String username;

  @override
  State<HomePage> createState() => _HomePage();
}


class _HomePage extends State<HomePage> {
  final storage = FlutterSecureStorage();
  int _selectedIndex = 0;
  static const List<String> navbarOptions = [
    '',
    'Weather',
    'Profile'
  ];

  void onNavOptionPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<List<Map<String, dynamic>>> getTours() async {
  final toursJSON = await storage.read(key: 'tours');
  if (toursJSON != null) {
    return List<Map<String, dynamic>>.from(json.decode(toursJSON));
  } else {
    return [];
  }
}

  void onBookButtonPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Booking'),
          content: Text('Are you sure you want to book this tour?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                

                Navigator.of(context).pop(); // Close the dialog
                print('Tour booked.');
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void onCancelButtonPressed() {
    print('Cancel button pressed.');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFACD4AE),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Text(navbarOptions.elementAt(_selectedIndex), style: Theme.of(context).textTheme.displayMedium),
                SizedBox(width: 180),
                _selectedIndex == 2 ? NotificationButton(onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                }) : Container(),
              ],
            ),
            bottom: _selectedIndex == 0
              ? TabBar(
                  tabs: [
                    Tab(text: 'Tours'),
                    Tab(text: 'Booked'),
                  ],
                ) : null,
          ),
          body: _selectedIndex == 0
            // Home Page ------------------------------------------------------------------------
            ? Container(
              color: const Color(0xFFACD4AE),
              child: TabBarView(
                  children: [
                    // Tours tab below ------------------------------------------------------------
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: getTours(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final tours = snapshot.data!;
                          if (tours.isEmpty) {
                            return Center(child: Text('No tours available'));
                          } else {
                            return ListView.builder(
                              itemCount: tours.length,
                              itemBuilder: (context, index) {
                                final tour = tours[index];
                                final cityName = tour['cityName'];
                                final date = tour['date'];
                                final description = tour['description'];
                                final maxCapacity = tour['maxCapacity'];
                                final numberOfUsersBooked = tour['usersBooked'].length.toString();

                                return TourCard(
                                  cityName: cityName,
                                  date: date,
                                  description: description,
                                  maxCapacity: maxCapacity,
                                  numberOfUsersBooked: numberOfUsersBooked,
                                  onPressedButton: onBookButtonPressed,
                                );
                              },
                            );
                          }
                        } else {
                          return Center(child: Text('No data available'));
                        }
                      },
                    ),
                    // Booked tab below -----------------------------------------------------------
                    Column(
                      children: [
                        Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text('London'),
                                subtitle: Text('February 2nd, 2025'),
                              ),
                              Text('Includes Buckingham Palace, Piccadilly Circus', textAlign: TextAlign.left,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text('3/10 Booked'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: TextButton(
                                      onPressed: onBookButtonPressed,
                                      child: SecondaryButton(label: 'Cancel', onPressed: onCancelButtonPressed),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ]
                    ),
                  ],
                ),
            ) : _selectedIndex == 1
                // Weather Page -----------------------------------------------------------------
                ? WeatherPage()
                // Profile Page -----------------------------------------------------------------
                : ProfilePage(),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.cloud_outlined), label: 'Weather'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xFF326335),
            onTap: onNavOptionPressed,
          ),
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(title: Text('Profile Screen')),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text(
    //           'Welcome, $username!',
    //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //         ),
    //         SizedBox(height: 20),
    //         ElevatedButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //           child: Text('Logout'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}