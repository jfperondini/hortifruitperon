import 'package:hortifruitperon/cors/repository/repository_firestore.dart';
import 'package:hortifruitperon/domain/model/user_model.dart';

class UserRepository extends RepositoryFireStore<UserModel> {
  @override
  UserModel convertJsonToModel(Map<String, dynamic> map) {
    return UserModel.fromJson(map);
  }

  @override
  Map<String, dynamic> convertModelToJson(UserModel model) {
    return model.toJson();
  }

  @override
  String get nameCollection => 'user';
}
