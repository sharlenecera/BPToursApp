import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import '../widgets/widgets.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _storage = FlutterSecureStorage();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _homeCityController = TextEditingController();
  String _errorMessage = '';

  @override
  initState() {
    super.initState();
    loadProfile();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _surnameController.dispose();
    _usernameController.dispose();
    _birthdayController.dispose();
    _homeCityController.dispose();
    super.dispose();
  }

  void loadProfile() async {
    try {
      final currentUser = await _storage.read(key: 'currentUser');
      if (currentUser != null) {
        final usersJSON = await _storage.read(key: 'users');
        if (usersJSON != null) {
          List<Map<String, dynamic>> users = List<Map<String, dynamic>>.from(json.decode(usersJSON));
          // Get current user's user object
          final user = users.firstWhere((user) => user['username'] == currentUser, orElse: () => {});
          if (user.isNotEmpty) {
            // Display user's profile data into the text fields
            setState(() {
              _firstNameController.text = user['firstName'] ?? '';
              _surnameController.text = user['surname'] ?? '';
              _usernameController.text = user['username'] ?? '';
              _birthdayController.text = user['birthday'] ?? '';
              _homeCityController.text = user['homeCity'] ?? '';
            });
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
        _errorMessage = 'An error occurred while loading the profile: $e';
      });
    }
  }

  void updateProfile() async {
    try {
      final currentUser = await _storage.read(key: 'currentUser');
      if (currentUser != null) {
        final usersJSON = await _storage.read(key: 'users');
        if (usersJSON != null) {
          List<Map<String, dynamic>> users = List<Map<String, dynamic>>.from(json.decode(usersJSON));
          final userIndex = users.indexWhere((user) => user['username'] == currentUser);
          if (userIndex > -1) {
            // Assigning all the values whether changed or not to the users object.
            users[userIndex]['firstName'] = _firstNameController.text;
            users[userIndex]['surname'] = _surnameController.text;
            users[userIndex]['username'] = _usernameController.text;
            users[userIndex]['birthday'] = _birthdayController.text;
            users[userIndex]['homeCity'] = _homeCityController.text;

            // Writing the updated users object to the secure storage
            await _storage.write(key: 'users', value: json.encode(users));
            if (mounted) {
              Navigator.pop(context, true); // Return true to indicate success
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
        _errorMessage = 'An error occurred while updating the profile: $e';
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
            Text('Edit Profile', style: Theme.of(context).textTheme.displayMedium),
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
                  child: Text('First Name', style: Theme.of(context).textTheme.headlineSmall,),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Surname', style: Theme.of(context).textTheme.headlineSmall,),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _surnameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Username', style: Theme.of(context).textTheme.headlineSmall,),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Birthday', style: Theme.of(context).textTheme.headlineSmall,),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _birthdayController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Home City', style: Theme.of(context).textTheme.headlineSmall,),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _homeCityController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
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
            TextButton(
              onPressed: () {
                // Navigate to change password page
                Navigator.pushNamed(context, '/changePassword');
              },
              child: Text('Change Password?', style: Theme.of(context).textTheme.labelSmall),
            ),
            PrimaryButton(label: 'Save Changes', onPressed: updateProfile),
            SecondaryButton(label: 'Cancel', onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}