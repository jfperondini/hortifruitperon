import 'package:flutter/material.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final IconData? icon;

  const ElevatedButtonWidget({super.key, required this.onPressed, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        backgroundColor: Styles.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(color: Styles.white)),
          const SizedBox(width: 10),
          Icon(icon, color: Styles.white),
        ],
      ),
    );
  }
}
