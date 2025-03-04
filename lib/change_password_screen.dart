import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'widgets/widgets.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String _errorMessage = '';
  String _oldPassword = '';
  String _newPassword = '';
  String _repeatNewPassword = '';

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
                PrimaryButton(label: 'Submit', onPressed: (){}),
                SecondaryButton(label: 'Cancel', onPressed: () => Navigator.pop(context)),
              ],
            )
          ],
        ),
      ),
    );
  }
}