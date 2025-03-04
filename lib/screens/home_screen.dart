import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import '../widgets/widgets.dart';
import '../weather_screen.dart';
import '../profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}


class _HomePage extends State<HomePage> {
  final _storage = FlutterSecureStorage();
  String _username = '';
  int _selectedIndex = 0;
  static const List<String> navbarOptions = [
    '',
    'Weather',
    'Profile'
  ];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final currentUser = await _storage.read(key: 'currentUser');
    setState(() {
      _username = currentUser ?? '';
    });
  }

  void onNavOptionPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<List<Map<String, dynamic>>> getTours() async {
    final toursJSON = await _storage.read(key: 'tours');
    if (toursJSON != null) {
      return List<Map<String, dynamic>>.from(json.decode(toursJSON));
    } else {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getBookedTours() async {
    final toursJSON = await _storage.read(key: 'tours');
    if (toursJSON != null) {
      List<Map<String, dynamic>> tours = List<Map<String, dynamic>>.from(json.decode(toursJSON));
      return tours.where((tour) => tour['usersBooked'].contains(_username)).toList();
    } else {
      return [];
    }
  }

  void showError(String errorMessage) {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    });
  }

  Future<void> bookTour(String tourId) async {
    final toursJSON = await _storage.read(key: 'tours');
    final usersJSON = await _storage.read(key: 'users');

    if (toursJSON != null && usersJSON != null) {
      List<Map<String, dynamic>> tours = List<Map<String, dynamic>>.from(json.decode(toursJSON));
      List<Map<String, dynamic>> users = List<Map<String, dynamic>>.from(json.decode(usersJSON));
      final tourIndex = tours.indexWhere((tour) => tour['ID'] == tourId);
      final userIndex = users.indexWhere((user) => user['username'] == _username);
      if (tourIndex > -1 && userIndex > -1) {
        if (!tours[tourIndex]['usersBooked'].contains(_username)) {
          tours[tourIndex]['usersBooked'].add(_username);
          users[userIndex]['IdsOfToursBooked'].add(tourId);
          await _storage.write(key: 'tours', value: json.encode(tours));
          await _storage.write(key: 'users', value: json.encode(users));
          setState(() {});
        } else {
          showError('You have already booked this tour.');
        }
      }
    }
  }

  void onBookButtonPressed(tourID) {
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
                bookTour(tourID);

                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> cancelBooking(String tourId) async {
    final toursJSON = await _storage.read(key: 'tours');
    final usersJSON = await _storage.read(key: 'users');

    if (toursJSON != null && usersJSON != null) {
      List<Map<String, dynamic>> tours = List<Map<String, dynamic>>.from(json.decode(toursJSON));
      List<Map<String, dynamic>> users = List<Map<String, dynamic>>.from(json.decode(usersJSON));
      final tourIndex = tours.indexWhere((tour) => tour['ID'] == tourId);
      final userIndex = users.indexWhere((user) => user['username'] == _username);
      if (tourIndex > -1 && userIndex > -1) {
        if (tours[tourIndex]['usersBooked'].contains(_username)) {
          tours[tourIndex]['usersBooked'].remove(_username);
          users[userIndex]['IdsOfToursBooked'].remove(tourId);
          await _storage.write(key: 'tours', value: json.encode(tours));
          await _storage.write(key: 'users', value: json.encode(users));
          setState(() {});
        } else {
          showError('You have not booked this tour.');
        }
      }
    }
  }

  void onCancelButtonPressed(String tourId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Cancellation'),
          content: Text('Are you sure you want to cancel this booking?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                await cancelBooking(tourId);
                Navigator.of(context).pop(); // Close the dialog
                print('Booking cancelled.');
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
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
                _selectedIndex == 2 ? IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushNamed(context, '/editProfile');
                  },
                ) : Container(),
                SizedBox(width: 130),
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
                                final tourID = tour['ID'];
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
                                  buttonText: 'Book',
                                  onPressedButton: () {
                                    onBookButtonPressed(tourID);
                                  },
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
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: getBookedTours(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final bookedTours = snapshot.data!;
                          if (bookedTours.isEmpty) {
                            return Center(child: Text('No booked tours.'));
                          } else {
                            return ListView.builder(
                              itemCount: bookedTours.length,
                              itemBuilder: (context, index) {
                                final tour = bookedTours[index];
                                final tourID = tour['ID'];
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
                                  buttonText: 'Cancel',
                                  onPressedButton: () {
                                    onCancelButtonPressed(tourID);
                                  },
                                );
                              },
                            );
                          }
                        } else {
                          return Center(child: Text('No data available'));
                        }
                      },
                    )
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