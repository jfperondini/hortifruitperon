import 'package:hortifruitperon/cors/repository/repository_firestore.dart';
import 'package:hortifruitperon/domain/model/order_model.dart';

class OrderRepository extends RepositoryFireStore<OrderModel> {
  @override
  OrderModel convertJsonToModel(Map<String, dynamic> map) {
    return OrderModel.fromJson(map);
  }

  @override
  Map<String, dynamic> convertModelToJson(OrderModel model) {
    return model.toJson();
  }

  @override
  String get nameCollection => 'order';
}
