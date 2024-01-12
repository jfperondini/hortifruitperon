import 'package:flutter/material.dart';
import 'package:hortifruitperon/cors/shared/extension/doube_extesion.dart';
import 'package:hortifruitperon/data/services/auth_service.dart';
import 'package:hortifruitperon/domain/model/order_model.dart';
import 'package:hortifruitperon/ui/controller/home_controller.dart';

class PaymentController extends ChangeNotifier {
  final AuthService authService;
  final HomeController homeController;

  PaymentController(this.authService, this.homeController);

  OrderModel? get orderSelect => homeController.orderSelect;

  setTotalAmout() {
    double subtotalAmount = orderSelect?.subTotalAmount ?? 0.0;
    orderSelect?.totalAmount = subtotalAmount.toPrecision(2);
    notifyListeners();
  }

  setPayment({required double amountPaid}) async {
    orderSelect?.paymentModel.amountPaid = amountPaid;
    notifyListeners();
  }
}
