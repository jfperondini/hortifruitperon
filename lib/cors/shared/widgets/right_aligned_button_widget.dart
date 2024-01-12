import 'package:flutter/material.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';

class RightAlignedButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String title;

  const RightAlignedButtonWidget({
    Key? key,
    this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
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
              Icon(Icons.shopping_cart_outlined, color: Styles.white),
            ],
          ),
        ),
      ],
    );
  }
}
