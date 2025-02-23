import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SecondaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Theme.of(context).shadowColor),
        // padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 16)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
      onPressed: onPressed,
      child: Text(label, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white)),
    );
  }
}