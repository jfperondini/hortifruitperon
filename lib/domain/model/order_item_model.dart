import 'package:hortifruitperon/cors/shared/extension/doube_extesion.dart';
import 'package:hortifruitperon/domain/model/product_model.dart';

class OrderItemModel {
  String? id;
  int quantity;
  double valueItem;
  ProductModel productModel;

  OrderItemModel({
    required this.id,
    required this.quantity,
    required this.valueItem,
    required this.productModel,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'quantity': quantity,
      'valueItem': valueItem,
      'product': productModel.toJson(),
    };
  }

  factory OrderItemModel.fromJson(Map<String, dynamic> map) {
    return OrderItemModel(
      id: map['id'] ?? '',
      quantity: map['quantity'] ?? 0,
      valueItem: map['valueItem'] ?? 0.00,
      productModel: ProductModel.fromJson(map['product'] ?? {}),
    );
  }

  factory OrderItemModel.novo({
    required int quantity,
    required ProductModel productModel,
  }) {
    double valueItem = (productModel.price * quantity).toPrecision(2);
    return OrderItemModel(
      id: null,
      quantity: quantity,
      valueItem: valueItem,
      productModel: productModel,
    );
  }

  factory OrderItemModel.empty() {
    return OrderItemModel.fromJson({});
  }

  OrderItemModel copyWith({
    String? id,
    int? quantity,
    double? valueItem,
    ProductModel? productModel,
  }) {
    return OrderItemModel(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      valueItem: valueItem ?? this.valueItem,
      productModel: productModel ?? this.productModel,
    );
  }
}
