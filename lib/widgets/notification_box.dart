import 'package:flutter/material.dart';

class NotificationBox extends StatelessWidget {
  final String message;
  final String time;
  final VoidCallback onPressed;

  const NotificationBox({
    Key? key,
    required this.message,
    required this.time,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right:10.0, top: 15.0),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium,
                  softWrap: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 24, // Minimum width for the close icon
                child: GestureDetector(
                  onTap: onPressed,
                  child: Icon(Icons.close, color: Color(0xFF326335)),
              ),
            ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
                child: Text(time, style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          ),
        ],
      ),
    );
  }
}