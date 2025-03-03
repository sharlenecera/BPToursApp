import 'package:flutter/material.dart';
import 'widgets/widgets.dart';
import 'weather_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.username, super.key});

  final String username;

  @override
  State<HomePage> createState() => _HomePage();
}


class _HomePage extends State<HomePage> {
  int selectedIndex = 0;
  static const List<String> navbarOptions = [
    '',
    'Weather',
    'Profile'
  ];

  void onNavOptionPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onBookButtonPressed() {
    print('Book button pressed.');
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
                Text(navbarOptions.elementAt(selectedIndex), style: Theme.of(context).textTheme.displayMedium),
                SizedBox(width: 180),
                selectedIndex == 2 ? NotificationButton(onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                }) : Container(),
              ],
            ),
            bottom: selectedIndex == 0
              ? TabBar(
                  tabs: [
                    Tab(text: 'Tours'),
                    Tab(text: 'Booked'),
                  ],
                ) : null,
          ),
          body: selectedIndex == 0
            // Home Page ------------------------------------------------------------------------
            ? Container(
              color: const Color(0xFFACD4AE),
              child: TabBarView(
                  children: [
                    // Tours tab below ------------------------------------------------------------
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
                              Text('Includes London Eye, London Bridge, Big Ben,', textAlign: TextAlign.left,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text('1/10 Booked'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: TextButton(
                                      onPressed: onBookButtonPressed,
                                      child: PrimaryButton(label: 'Book', onPressed: onBookButtonPressed),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
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
            ) : selectedIndex == 1
                // Weather Page -----------------------------------------------------------------
                ? WeatherPage()
                // Profile Page -----------------------------------------------------------------
                : Container(
                  color: const Color(0xFFACD4AE),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('John Doe', style: Theme.of(context).textTheme.displaySmall),
                        Text('john_doe1', style: Theme.of(context).textTheme.labelLarge),
                        Text('Birthday', style: Theme.of(context).textTheme.headlineSmall),
                        Text('Unknown', style: Theme.of(context).textTheme.bodyLarge),
                        Text('Home City', style: Theme.of(context).textTheme.headlineSmall),
                        Text('Unknown', style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.cloud_outlined), label: 'Weather'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
            currentIndex: selectedIndex,
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