import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/firebase/firebase_options.dart';
import 'package:hortifruitperon/hortifruit_module.dart';
import 'package:hortifruitperon/hortifruit_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ModularApp(module: HortiFruitModule(), child: const HortFruitWidget()));
}
