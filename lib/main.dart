import 'package:flutter/material.dart';
import 'widgets/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFACD4AE)),
        shadowColor: Color(0xFF797979),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomePage(username: 'admin'),
        '/notifications': (context) => const NotificationsPage(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';
  String errorMessage = '';

  void onSignUpButtonPressed() {
    print('Sign up button pressed.');
    Navigator.pushNamed(context, '/signup');
  }

  void login() {
    setState(() {
      if (username == 'admin' && password == '1234') {
        Navigator.pushNamed(context, '/home');
      } else {
        errorMessage = 'Invalid credentials';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Login Screen')),
      backgroundColor: const Color(0xFFACD4AE),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => username = value,
                decoration: InputDecoration(
                  label: Text('Username', style: Theme.of(context).textTheme.bodyMedium),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => password = value,
                decoration: InputDecoration(
                  label: Text('Password', style: Theme.of(context).textTheme.bodyMedium),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Do not have an account?', style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13.0)),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: onSignUpButtonPressed, // TODO: Direct user to sign up screen
                  child: Text('Sign Up', style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 13.0)),
                ),
                // TextButton(
                //   onPressed: () {},
                //   child: Text('Sign Up', style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 13.0)),
                // ),
              ],
            ),
            PrimaryButton(label: 'Login', onPressed: login),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String firstName = '';
  String surname = '';
  String username = '';
  String password = '';
  String repeatPassword = '';
  String errorMessage = '';

  void onBackButtonPressed() {
    print('Back button pressed.');
    Navigator.pop(context);
  }

  void signUp() {
    print('nothing so far');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFACD4AE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFACD4AE),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color(0xFF326335),),
          onPressed: onBackButtonPressed,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => username = value,
                decoration: InputDecoration(
                  label: Text('First Name', style: Theme.of(context).textTheme.bodyMedium),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => username = value,
                decoration: InputDecoration(
                  label: Text('Surname', style: Theme.of(context).textTheme.bodyMedium),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => username = value,
                decoration: InputDecoration(
                  label: Text('Username', style: Theme.of(context).textTheme.bodyMedium),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => password = value,
                decoration: InputDecoration(
                  label: Text('Password', style: Theme.of(context).textTheme.bodyMedium),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => password = value,
                decoration: InputDecoration(
                  label: Text('Repeat Password', style: Theme.of(context).textTheme.bodyMedium),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            PrimaryButton(label: 'Sign Up', onPressed: signUp),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

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

  void searchLocation(String location) {
    print('Searching for $location');
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
                ? Container(
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
                ) 
                // Profile Page -----------------------------------------------------------------
                : Container(
                  color: const Color(0xFFACD4AE),
                  child: Column(
                    children: [
                      Text('Profile'),
                      
                    ],
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

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}