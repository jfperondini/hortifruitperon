import 'package:hortifruitperon/cors/repository/repository_firestore.dart';
import 'package:hortifruitperon/domain/model/category_model.dart';

class CategoryRepository extends RepositoryFireStore<CategoryModel> {
  @override
  CategoryModel convertJsonToModel(Map<String, dynamic> map) {
    return CategoryModel.fromJson(map);
  }

  @override
  Map<String, dynamic> convertModelToJson(CategoryModel model) {
    return model.toJson();
  }

  @override
  String get nameCollection => 'category';
}
