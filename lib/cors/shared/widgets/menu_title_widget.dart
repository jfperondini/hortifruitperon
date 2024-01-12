import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';

class MenuTitleWidget extends StatelessWidget {
  final IconData icon;
  final String title;

  final String route;

  const MenuTitleWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Styles.transparent,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        leading: Icon(icon, color: Styles.green),
        title: Text(title),
        onTap: () {
          Modular.to.pushNamed(route);
        },
        trailing: Icon(Icons.keyboard_arrow_right, color: Styles.green),
      ),
    );
  }
}
