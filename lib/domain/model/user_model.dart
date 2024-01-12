class UserModel {
  String? id;
  String name;
  String email;
  String? photo;
  String? phone;
  String? birth;
  bool isAdmin;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photo,
    required this.phone,
    required this.birth,
    required this.isAdmin,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
      'phone': phone,
      'birth': birth,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photo: map['photo'] ?? '',
      phone: map['phone'] ?? '',
      birth: map['birth'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
    );
  }

  factory UserModel.empty() {
    return UserModel.fromJson({});
  }
}
