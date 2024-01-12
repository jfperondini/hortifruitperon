import 'package:hortifruitperon/cors/repository/repository_firestore.dart';
import 'package:hortifruitperon/domain/model/product_model.dart';

class ProductRepository extends RepositoryFireStore<ProductModel> {
  @override
  ProductModel convertJsonToModel(Map<String, dynamic> map) {
    return ProductModel.fromJson(map);
  }

  @override
  Map<String, dynamic> convertModelToJson(ProductModel model) {
    return model.toJson();
  }

  @override
  String get nameCollection => 'product';
}
