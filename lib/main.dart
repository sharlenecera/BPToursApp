import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final mainColour = const Color(0xFF326335);
final backgroundColour = const Color(0xFFACD4AE);

// Setting the theme for colours and text
final ThemeData appTheme = ThemeData(
  // primarySwatch: Colors.blue,
  // primaryColor: Colors.blue,
  // colorScheme: appTheme.colorScheme.copyWith(secondary: Colors.orange),
  colorScheme:  ColorScheme.fromSeed(seedColor: mainColour),
  scaffoldBackgroundColor: backgroundColour,
  textTheme: GoogleFonts.interTextTheme(),
  // textTheme: TextTheme(
  //   headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
  //   bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
  // ),
  buttonTheme: ButtonThemeData(
    buttonColor: mainColour,
    textTheme: ButtonTextTheme.primary,
  ),
  appBarTheme: AppBarTheme(
    color: mainColour,
    toolbarTextStyle: GoogleFonts.inter(
      textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    titleTextStyle: GoogleFonts.inter(
      textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  ),
    useMaterial3: true,
);

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
      theme: appTheme,
      home: LoginScreen(),
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

  void login() {
    setState(() {
      if (username == 'admin' && password == '1234') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen(username: username)),
        );
      } else {
        errorMessage = 'Invalid credentials';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => username = value,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              onChanged: (value) => password = value,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({required this.username, super.key});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, $username!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
