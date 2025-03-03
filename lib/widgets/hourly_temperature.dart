import 'package:flutter/material.dart';
// TODO: import google fonts and use it with the text styles

final primaryColor = const Color(0xFF326335);

final timeStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: primaryColor,
);

final temperatureStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.w400,
  color: primaryColor,
);

class HourlyTemperature extends StatelessWidget {
  final String time;
  final String temperature;

  const HourlyTemperature({
    Key? key,
    required this.time,
    required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(time, style: timeStyle),
            Text(temperature, style: temperatureStyle),
          ],
        ),
      ),
    );
  }
}