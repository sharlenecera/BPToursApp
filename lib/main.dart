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
  textTheme: GoogleFonts.interTextTheme(
    TextTheme(
      displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.w800, color: mainColour),
      displayMedium: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w800, color: mainColour),
      displaySmall: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w800, color: mainColour),

      headlineLarge: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700, color: mainColour),
      headlineMedium: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w700, color: mainColour),
      headlineSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: mainColour),

      titleLarge: TextStyle(fontSize: 80.0, fontWeight: FontWeight.w400, color: mainColour),
      titleMedium: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w500, color: mainColour),
      titleSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: mainColour),

      labelLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: mainColour),
      labelMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500, color: mainColour),
      // use below for links
      labelSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800, color: mainColour),

      bodyLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400, color: mainColour),
      bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: mainColour),
      // use below for sub mini titles
      bodySmall: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w300, color: mainColour),
    )
  ),
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

import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/change_password_screen.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomePage(),
        '/notifications': (context) => const NotificationsPage(),
        '/editProfile': (context) => const EditProfilePage(),
        '/changePassword': (context) => const ChangePasswordPage(),
      },
      
      home: LoginScreen(),
    );
  }
}