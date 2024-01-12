class CategoryModel {
  String? id;
  String typeName;
  String photo;

  CategoryModel({
    required this.id,
    required this.typeName,
    required this.photo,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'typeName': typeName,
      'photo': photo,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      typeName: map['typeName'] ?? '',
      photo: map['photo'] ?? '',
    );
  }

  factory CategoryModel.empty() {
    return CategoryModel.fromJson({});
  }
}
