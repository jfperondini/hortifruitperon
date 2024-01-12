import 'package:hortifruitperon/domain/model/category_model.dart';

class ProductModel {
  String? id;
  String name;
  double price;
  String photo;
  bool isFavorite;
  CategoryModel categoryModel;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.photo,
    this.isFavorite = false,
    required this.categoryModel,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'photo': photo,
      'isFavorite': isFavorite,
      'category': categoryModel.toJson(),
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? 0.0,
      photo: map['photo'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
      categoryModel: CategoryModel.fromJson(map['category'] ?? {}),
    );
  }

  factory ProductModel.empty() {
    return ProductModel.fromJson({});
  }
}
