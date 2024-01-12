import 'package:flutter/material.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';

class PlusMinusButtonWidget extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final String title;
  final VoidCallback addQuantity;

  const PlusMinusButtonWidget({
    Key? key,
    required this.deleteQuantity,
    required this.title,
    required this.addQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(shape: BoxShape.rectangle, color: Styles.white),
          child: IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove), iconSize: 20),
        ),
        const SizedBox(width: 10),
        Text(title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              letterSpacing: 0.8,
              color: Styles.black,
            )),
        const SizedBox(width: 10),
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(shape: BoxShape.rectangle, color: Styles.green),
          child: IconButton(onPressed: addQuantity, icon: const Icon(Icons.add), iconSize: 20, color: Styles.white),
        )
      ],
    );
  }
}
