import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hortifruitperon/cors/repository/repository.dart';
import 'package:hortifruitperon/cors/shared/extension/date_time_extesion.dart';
import 'package:hortifruitperon/data/services/auth_service.dart';
import 'package:hortifruitperon/domain/model/order_model.dart';
import 'package:hortifruitperon/domain/model/user_model.dart';

class HomeController extends ChangeNotifier {
  final AuthService authService;
  final Repository<UserModel> repositoryUser;

  HomeController(this.authService, this.repositoryUser);

  UserModel? userSelect;
  OrderModel? orderSelect;

  final search = TextEditingController();

  int? _currentIndex;
  int get currentIndex => _currentIndex ??= 0;

  getUser() async {
    User? user = await authService.getAuthUser();
    userSelect = await repositoryUser.findUserById(id: user?.uid ?? '');
    notifyListeners();
  }

  getDateTime() {
    int hora = selectedDate.hour;
    if (hora >= 6 && hora < 12) {
      return 'Bom Dia';
    } else if (hora >= 12 && hora < 18) {
      return 'Boa Tarde';
    } else {
      return 'Boa Noite';
    }
  }
}
