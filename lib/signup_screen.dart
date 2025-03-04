import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {
  final _storage = FlutterSecureStorage();
  String _firstName = '';
  String _surname = '';
  String _username = '';
  String _password = '';
  String _repeatPassword = '';
  String _errorMessage = '';

  void onBackButtonPressed() {
    print('Back button pressed.');
    Navigator.pop(context);
  }

  Future<void> signUp() async {
    // Checks if repeat password matches password
    if (_password != _repeatPassword) {
      setState(() {
        _errorMessage = 'Passwords do not match';
      });
      return;
    }

    final usersJSON = await _storage.read(key: 'users');
    List<Map<String, dynamic>> users = usersJSON != null ? List<Map<String, dynamic>>.from(json.decode(usersJSON)) : [];

    // Check if username already exists
    if (users.any((user) => user['username'] == _username)) {
      setState(() {
        _errorMessage = 'Username already exists';
      });
      return;
    }

    users.add({
      'firstName': _firstName,
      'surname': _surname,
      'username': _username,
      'password': _password,
      'birthday': '',
      'homeCity': '',
      'IdsOfToursBooked': [],
    });
    await _storage.write(key: 'users', value: json.encode(users));
    await _storage.write(key: 'currentUser', value: _username);
    print({
      'firstName': _firstName,
      'surname': _surname,
      'username': _username,
      'password': _password
    });

    // Navigate to home screen after async operations are complete
    if (mounted) {
      Navigator.pushNamed(context, '/home');
    }
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
                onChanged: (value) => _firstName = value,
                decoration: InputDecoration(
                  label: Text('First Name', style: Theme.of(context).textTheme.bodyMedium),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => _surname = value,
                decoration: InputDecoration(
                  label: Text('Surname', style: Theme.of(context).textTheme.bodyMedium),
                  border: OutlineInputBorder(),
                ),
              ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => _repeatPassword = value,
                decoration: InputDecoration(
                  label: Text('Repeat Password', style: Theme.of(context).textTheme.bodyMedium),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            PrimaryButton(label: 'Sign Up', onPressed: signUp),
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