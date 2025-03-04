import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
    final VoidCallback onPressed;

    const NotificationButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          Icon(
            Icons.notifications,
            color: Color(0xFF326335),
          ),
        ],
      ),
    );
  }
}