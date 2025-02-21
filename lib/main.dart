import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomePage(username: 'admin'),
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
            ElevatedButton( // TODO: Change button style to button style
              onPressed: login,
              child: Text('Login', style: Theme.of(context).textTheme.labelLarge),
            ),
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
            ElevatedButton( // TODO: Change button style to button style
              onPressed: signUp,
              child: Text('Sign Up', style: Theme.of(context).textTheme.labelLarge),
            ),
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
    'Home',
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(navbarOptions.elementAt(selectedIndex), style: Theme.of(context).textTheme.displayMedium),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Tours'),
                Tab(text: 'Booked'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Tours tab below
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
                                child: Text('Book', style: Theme.of(context).textTheme.labelLarge),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ]
              ),
              // Booked tab below
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
                                child: Text('Cancel', style: Theme.of(context).textTheme.labelLarge),
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
