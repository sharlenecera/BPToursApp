import 'package:bp_tours_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _storage = FlutterSecureStorage();
  late Future<Map<String, String>> _futureUserDetails;

  @override
  void initState() {
    super.initState();
    _futureUserDetails = getUserDetails();
  }

  Future<Map<String, String>> getUserDetails() async {
    try {
      final currentUserUsername = await _storage.read(key: 'currentUser');
      if (currentUserUsername == null) {
        return {'error': 'No user is logged in'};
      }

      final usersJSON = await _storage.read(key: 'users');
      if (usersJSON == null) {
        return {'error': 'No users found'};
      }

      List<Map<String, dynamic>> users = List<Map<String, dynamic>>.from(json.decode(usersJSON));
      final currentUser = users.firstWhere((user) => user['username'] == currentUserUsername, orElse: () => {});

      if (currentUser.isNotEmpty) {
        return {
          'firstName': currentUser['firstName'],
          'surname': currentUser['surname'],
          'username': currentUser['username'],
          'birthday': currentUser['birthday'],
          'homeCity': currentUser['homeCity'],
        };
      } else {
        return {'error': 'User not found'};
      }
    } catch (e) {
      return {'error': 'Error occurred: $e'};
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _futureUserDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final userDetails = snapshot.data!;
          if (userDetails.containsKey('error')) {
            return Center(child: Text(userDetails['error']!));
          } else {
            print(userDetails);
            final firstName = userDetails['firstName'];
            final surname = userDetails['surname'];
            final username = userDetails['username'];
            final birthday = userDetails['birthday'];
            final homeCity = userDetails['homeCity'];

            return Container(
              color: Color(0xFFACD4AE),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$firstName $surname',
                      style: Theme.of(context).textTheme.displaySmall,
                      softWrap: true,
                    ),
                    Text(username!, style: Theme.of(context).textTheme.labelLarge),
                    if ((birthday != null) && birthday.isNotEmpty) ...[
                      Text('Birthday', style: Theme.of(context).textTheme.headlineSmall),
                      Text(birthday, style: Theme.of(context).textTheme.bodyLarge)
                    ],
                    if ((homeCity != null) && homeCity.isNotEmpty) ...[
                      Text('Home City', style: Theme.of(context).textTheme.headlineSmall),
                      Text(homeCity, style: Theme.of(context).textTheme.bodyLarge),
                    ],
                    SizedBox(height: 20),
                    PrimaryButton(label: 'Refresh to see changes', onPressed: (){
                      setState(() {
                        _futureUserDetails = getUserDetails();
                      });
                    }),
                  ],
                ),
              ),
            );
          }
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }
}