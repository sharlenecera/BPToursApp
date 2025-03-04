import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  final storage = FlutterSecureStorage();
  String _username = '';
  String _password = '';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    clearSecureStorage();
    initialiseStorage();
  }

  void initialiseStorage() async {
    // Storing an admin user
    await storage.write(key: 'users', value: json.encode([
      {
        'firstName': 'John',
        'surname': 'Doe',
        'username': 'admin',
        'password': '1234',
        'birthday': '01/01/2000',
        'homeCity': 'Nottingham',
        'IdsOfToursBooked': [1],
      },
    ]));

    // Initialising tours list
    await storage.write(key: 'tours', value: json.encode([
      {
        'ID': '1',
        'cityName': 'London',
        'date': 'February 2nd, 2025',
        'description': 'Includes London Eye, London Bridge and Big Ben.',
        'maxCapacity': '10',
        'usersBooked': ['admin'],
      },
      {
        'ID': '2',
        'cityName': 'Paris',
        'date': 'March 3rd, 2025',
        'description': 'Includes Eiffel Tower, Louvre Museum and Notre-Dame Cathedral.',
        'maxCapacity': '12',
        'usersBooked': [],
      },
    ]));
    print('Storage initialised');
  }

  void clearSecureStorage() async {
    await storage.deleteAll();
    print('All data cleared from secure storage');
  }

  void onSignUpButtonPressed() {
    print('Sign up button pressed.');
    Navigator.pushNamed(context, '/signup');
  }

  Future<void> login() async {
    final usersJSON = await storage.read(key: 'users');
    List<Map<String, dynamic>> users = usersJSON != null ? List<Map<String, dynamic>>.from(json.decode(usersJSON)) : [];
    print('users: $users');

    final user = users.firstWhere(
      (user) => user['username'] == _username && user['password'] == _password,
      orElse: () => {},
    );

    if (user.isNotEmpty) {
      // Store the logged-in username
      await storage.write(key: 'currentUser', value: _username);

      if (mounted) {
        Navigator.pushNamed(context, '/home');
      }
    } else {
      setState(() {
        _errorMessage = 'Invalid credentials';
      });
    }
  }

  // void login() {
  //   setState(() {
  //     if (username == 'admin' && password == '1234') {
  //       Navigator.pushNamed(context, '/home');
  //     } else {
  //       errorMessage = 'Invalid credentials';
  //     }
  //   });
  // }

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
                onChanged: (value) => _username = value,
                decoration: InputDecoration(
                  label: Text('Username', style: Theme.of(context).textTheme.bodyMedium),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => _password = value,
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
                  onTap: onSignUpButtonPressed,
                  child: Text('Sign Up', style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 13.0)),
                ),
                // TextButton(
                //   onPressed: () {},
                //   child: Text('Sign Up', style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 13.0)),
                // ),
              ],
            ),
            PrimaryButton(label: 'Login', onPressed: login),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}