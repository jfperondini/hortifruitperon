// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hortifruitperon/cors/shared/styles/styles.dart';

class RowIconTextWidget extends StatelessWidget {
  final Color color;
  final String typeName;
  final String adress;

  const RowIconTextWidget({
    Key? key,
    required this.color,
    required this.typeName,
    required this.adress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: color,
          size: 50.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              typeName,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.27,
                color: Styles.grey,
              ),
            ),
            SizedBox(
              width: size.width * 0.7,
              child: Text(
                adress,
                maxLines: 2,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 0.27,
                  color: Styles.black,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
