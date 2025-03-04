import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import '../widgets/widgets.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _storage = FlutterSecureStorage();
  String _errorMessage = '';
  String _oldPassword = '';
  String _newPassword = '';
  String _repeatNewPassword = '';

  void changePassword() async {
    try {
      final currentUser = await _storage.read(key: 'currentUser');
      if (currentUser != null) {
        final usersJSON = await _storage.read(key: 'users');
        if (usersJSON != null) {
          List<Map<String, dynamic>> users = List<Map<String, dynamic>>.from(json.decode(usersJSON));
          final userIndex = users.indexWhere((user) => user['username'] == currentUser);
          if (userIndex > -1) {
            final user = users[userIndex];
            if (user['password'] == _oldPassword) {
              if (_newPassword == _repeatNewPassword) {
                users[userIndex]['password'] = _newPassword;
                await _storage.write(key: 'users', value: json.encode(users));
                if (mounted) {
                  Navigator.pop(context, true); // Return true to indicate success
                }
              } else {
                setState(() {
                  _errorMessage = 'New passwords do not match.';
                });
              }
            } else {
              setState(() {
                _errorMessage = 'Old password is incorrect.';
              });
            }
          } else {
            setState(() {
              _errorMessage = 'User not found.';
            });
          }
        } else {
          setState(() {
            _errorMessage = 'No users found.';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'No current user found.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred while changing the password: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFACD4AE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFACD4AE),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Change Password', style: Theme.of(context).textTheme.displayMedium),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Old Password', style: Theme.of(context).textTheme.headlineSmall,),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => _oldPassword = value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('New Password', style: Theme.of(context).textTheme.headlineSmall,),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => _newPassword = value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Confirm New Password', style: Theme.of(context).textTheme.headlineSmall,),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => _repeatNewPassword = value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PrimaryButton(label: 'Submit', onPressed: changePassword),
                SecondaryButton(label: 'Cancel', onPressed: () => Navigator.pop(context)),
              ],
            )
          ],
        ),
      ),
    );
  }
}