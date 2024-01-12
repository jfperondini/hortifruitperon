import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/routes/routes.dart';
import 'package:hortifruitperon/data/services/auth_service.dart';
import 'package:hortifruitperon/domain/model/user_model.dart';
import 'package:hortifruitperon/ui/controller/home_controller.dart';

class LoginController extends ChangeNotifier {
  final AuthService authService;
  final HomeController homeController;

  LoginController(this.authService, this.homeController);

  final email = TextEditingController();

  UserModel? get userSelect => homeController.userSelect;

  bool valueIsAdmin = true;

  Future<void> setRegister() async {
    await authService.register(email: email.text);
    notifyListeners();
  }

  toggleIsAdmin() {
    valueIsAdmin = !valueIsAdmin;
    userSelect?.isAdmin = valueIsAdmin;
    notifyListeners();
  }

  getRoute() async {
    await homeController.getUser();
    if (homeController.userSelect?.id != null) {
      Modular.to.pushNamedAndRemoveUntil(Routes.home, ModalRoute.withName(Routes.home));
      notifyListeners();
    } else {
      Modular.to.pushNamedAndRemoveUntil(Routes.user, ModalRoute.withName(Routes.user));
      notifyListeners();
    }
  }

  clearLogin() {
    email.text = '';
    notifyListeners();
  }
}
