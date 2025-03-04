import 'package:flutter/material.dart';
import 'primary_button.dart';

class TourCard extends StatelessWidget {
  final String cityName;
  final String date;
  final String description;
  final String maxCapacity;
  final String numberOfUsersBooked;
  final VoidCallback onPressedButton;

  const TourCard({
    Key? key,
    required this.cityName,
    required this.date,
    required this.description,
    required this.maxCapacity,
    required this.numberOfUsersBooked,
    required this.onPressedButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title: Text(cityName),
            subtitle: Text(date),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(description, textAlign: TextAlign.left,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('$numberOfUsersBooked/$maxCapacity Booked'),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                  onPressed: onPressedButton,
                  child: PrimaryButton(label: 'Book', onPressed: onPressedButton),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}