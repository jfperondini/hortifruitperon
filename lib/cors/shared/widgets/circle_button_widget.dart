import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hortifruitperon/cors/shared/styles/padding.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';

class CircleButtonWidget extends StatelessWidget {
  final Function()? onTap;
  final String photo;
  final String title;

  const CircleButtonWidget({
    Key? key,
    this.onTap,
    required this.photo,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: Paddings.edgeInsetRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Styles.grey,
              foregroundImage: MemoryImage(base64Decode(photo)),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
