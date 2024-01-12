import 'package:flutter/cupertino.dart';
import 'package:hortifruitperon/data/services/auth_service.dart';

class AuthController extends ChangeNotifier {
  final AuthService authService;

  AuthController(this.authService);

  bool? isLogin;

  Future<bool> authCheckLoading() async {
    final user = await authService.getAuthUser();
    isLogin = (user != null) ? await authService.isTokenValid() : false;
    if (isLogin == false) await authService.logout();
    return isLogin ?? false;
  }
}
