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

    setState(() {
      if (users.any((user) => user['username'] == _username && user['password'] == _password)) {
        Navigator.pushNamed(context, '/home');
      } else {
        _errorMessage = 'Invalid credentials';
      }
    });
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