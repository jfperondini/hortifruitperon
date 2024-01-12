import 'dart:math';
import 'package:hortifruitperon/cors/uid/uid_igenerate.dart';

class UidGenerate implements UidIGenerate {
  @override
  String generateUid() {
    String characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    String uid = '';

    for (int i = 0; i < 28; i++) {
      uid += characters[random.nextInt(characters.length)];
    }
    return uid;
  }
}
