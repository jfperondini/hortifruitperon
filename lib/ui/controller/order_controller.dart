import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hortifruitperon/cors/repository/repository.dart';
import 'package:hortifruitperon/cors/uid/uid_igenerate.dart';
import 'package:hortifruitperon/data/services/auth_service.dart';
import 'package:hortifruitperon/domain/model/order_item_model.dart';
import 'package:hortifruitperon/domain/model/order_model.dart';
import 'package:hortifruitperon/domain/model/product_model.dart';
import 'package:hortifruitperon/domain/model/user_model.dart';
import 'package:hortifruitperon/ui/controller/home_controller.dart';

class OrderController extends ChangeNotifier {
  final AuthService authService;
  final UidIGenerate uidIGenerate;
  final HomeController homeController;
  final Repository<OrderModel> repositoryOrder;

  OrderController(this.authService, this.uidIGenerate, this.homeController, this.repositoryOrder);

  UserModel? get userSelect => homeController.userSelect;
  OrderModel? get orderSelect => homeController.orderSelect;
  List<OrderModel> listOrder = [];

  getListOrder() async {
    User? user = await authService.getAuthUser();
    listOrder = await repositoryOrder.getListSubCollection(idUser: user?.uid ?? '');
    notifyListeners();
  }

  setOrder() async {
    String id = orderSelect?.id ?? '';
    if (id == '' && id.isEmpty) {
      OrderModel newOrder = OrderModel.novo(
        uidIGenerate: uidIGenerate,
        listCartItem: homeController.orderSelect?.listOrderItemModel ?? [],
        userModel: userSelect ?? UserModel.empty(),
      );
      homeController.orderSelect = newOrder;
    }
    notifyListeners();
  }

  setItemOrder({
    required int quantity,
    required ProductModel productModel,
  }) {
    OrderItemModel newCartItem = OrderItemModel.novo(
      quantity: quantity,
      productModel: productModel,
    );
    int? index = orderSelect?.listOrderItemModel.indexWhere(
      (e) => e.productModel.name == newCartItem.productModel.name,
    );
    (index != null && index != -1)
        ? orderSelect?.listOrderItemModel[index].quantity += newCartItem.quantity
        : homeController.orderSelect = orderSelect?.copyWith(
            listOrderItemModel: List.from(orderSelect?.listOrderItemModel ?? [])..add(newCartItem),
          );
    orderSelect?.subTotalAmount =
        orderSelect!.listOrderItemModel.map((e) => e.valueItem).fold(0.00, (value, element) => value + element);
    notifyListeners();
  }

  increaseQuantity(int index) {
    orderSelect?.listOrderItemModel[index].quantity++;
    int quantity = orderSelect?.listOrderItemModel[index].quantity ?? 0;
    double price = orderSelect?.listOrderItemModel[index].productModel.price ?? 0.00;
    orderSelect?.listOrderItemModel[index].valueItem = (price * quantity);
    orderSelect?.subTotalAmount =
        orderSelect!.listOrderItemModel.map((e) => e.valueItem).fold(0.00, (value, element) => value + element);
    notifyListeners();
  }

  decreaseQuantity(int index) {
    int? quantity = orderSelect?.listOrderItemModel[index].quantity;
    if (quantity != null && quantity > 1) {
      orderSelect?.listOrderItemModel[index].quantity--;
      int quantity = orderSelect?.listOrderItemModel[index].quantity ?? 0;
      double price = orderSelect?.listOrderItemModel[index].productModel.price ?? 0.00;
      orderSelect?.listOrderItemModel[index].valueItem = (price * quantity);
      orderSelect?.subTotalAmount =
          orderSelect!.listOrderItemModel.map((e) => e.valueItem).fold(0.00, (value, element) => value + element);
      notifyListeners();
    } else {
      orderSelect?.listOrderItemModel.removeAt(index);
      orderSelect?.subTotalAmount = 0.00;
      notifyListeners();
    }
  }

  putOrder() async {
    User? user = await authService.getAuthUser();

    repositoryOrder.putSubCollection(idUser: user?.uid ?? '', values: {
      'subTotalAmount': orderSelect?.subTotalAmount ?? 0.00,
      'datePurchase': orderSelect?.datePurchase ?? '',
      'totalAmount': orderSelect?.totalAmount ?? 0.00,
      'payment': {
        'amountPaid': orderSelect?.paymentModel.amountPaid ?? 0.00,
        'card': {
          "id": orderSelect?.paymentModel.cardModel.id ?? '',
        },
      },
      'user': {
        'id': orderSelect?.userModel.id ?? '',
      },
      "listOrderItem": orderSelect?.listOrderItemModel.map((e) => e.toJson()).toList(),
    });
    notifyListeners();
  }

  clearOrder() {
    homeController.orderSelect = OrderModel.empty();
    notifyListeners();
  }
}
