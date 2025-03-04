import 'package:flutter/material.dart';
import 'widgets/widgets.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}


class _NotificationsPageState extends State<NotificationsPage> {
  final List<NotificationBox> _notifications = [];
  final List<Map<String, String>> _notificationData = [
      {
        'message': 'You booked a tour in London for February 2nd',
        'time': '1 day ago',
      },
      {
        'message': 'You booked a tour in Bath for February 5th',
        'time': '2 days ago',
      },
    ];

  void removeNotification(int index) {
    if (index >= 0 && index < _notificationData.length) {
      setState(() {
        _notificationData.removeAt(index);
      });
    }
    else {
      print('Invalid index: $index');
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Notifications', style: Theme.of(context).textTheme.displayMedium),
          ],
        ),
      ),
      body: _notificationData.isEmpty
      ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No notifications', style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20.0)),
          ],
        ),
      ) : Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView.builder(
            itemCount: _notificationData.length,
            itemBuilder: (context, index) {
              final notification = _notificationData[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: NotificationBox(
                  message: notification['message'] ?? 'No message',
                  time: notification['time'] ?? 'No time',
                  onPressed: () {
                    removeNotification(index);
                  },
                ),
              );
            },
          ),
        ),
      )
    );
  }
}