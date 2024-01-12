import 'package:hortifruitperon/cors/shared/extension/date_time_extesion.dart';
import 'package:hortifruitperon/cors/shared/extension/doube_extesion.dart';
import 'package:hortifruitperon/cors/uid/uid_igenerate.dart';
import 'package:hortifruitperon/domain/model/order_item_model.dart';
import 'package:hortifruitperon/domain/model/payment_model.dart';
import 'package:hortifruitperon/domain/model/user_model.dart';

class OrderModel {
  String? id;
  double subTotalAmount;
  double totalAmount;
  String datePurchase;
  UserModel userModel;
  List<OrderItemModel> listOrderItemModel;
  PaymentModel paymentModel;

  OrderModel({
    required this.id,
    required this.subTotalAmount,
    required this.totalAmount,
    required this.datePurchase,
    required this.userModel,
    required this.listOrderItemModel,
    required this.paymentModel,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'subTotalAmount': subTotalAmount,
      'totalAmount': totalAmount,
      'datePurchase': datePurchase,
      'user': userModel.toJson(),
      'listOrderItem': listOrderItemModel.map((e) => e.toJson()).toList(),
      'payment': paymentModel.toJson(),
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      subTotalAmount: map['subTotalAmount'] ?? 0.00,
      totalAmount: map['totalAmount'] ?? 0.00,
      datePurchase: map['datePurchase'] ?? '',
      userModel: UserModel.fromJson(map['user'] ?? {}),
      listOrderItemModel:
          (map['listOrderItem'] as List<dynamic>?)?.map((e) => OrderItemModel.fromJson(e)).toList() ?? [],
      paymentModel: PaymentModel.fromJson(map['payment'] ?? {}),
    );
  }

  factory OrderModel.novo({
    required UidIGenerate uidIGenerate,
    required List<OrderItemModel> listCartItem,
    required UserModel userModel,
  }) {
    double subTotalAmount = (listCartItem.isNotEmpty)
        ? listCartItem.map((item) => item.valueItem.toPrecision(2)).fold(0.00, (value, element) => value + element)
        : 0.00;

    return OrderModel(
      id: uidIGenerate.generateUid(),
      subTotalAmount: subTotalAmount,
      totalAmount: 0.00,
      datePurchase: DateTime.now().formatDateTime,
      userModel: userModel,
      listOrderItemModel: [],
      paymentModel: PaymentModel.empty(),
    );
  }

  factory OrderModel.empty() {
    return OrderModel.fromJson({});
  }

  OrderModel copyWith(
      {String? id,
      double? subTotalAmount,
      double? totalAmount,
      String? datePurchase,
      UserModel? userModel,
      List<OrderItemModel>? listOrderItemModel,
      PaymentModel? paymentModel}) {
    return OrderModel(
      id: id ?? this.id,
      subTotalAmount: subTotalAmount ?? this.subTotalAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      datePurchase: datePurchase ?? this.datePurchase,
      userModel: userModel ?? this.userModel,
      listOrderItemModel: listOrderItemModel ?? this.listOrderItemModel,
      paymentModel: paymentModel ?? this.paymentModel,
    );
  }
}
