import 'package:hortifruitperon/cors/repository/repository_firestore.dart';
import 'package:hortifruitperon/domain/model/card_model.dart';

class CardRepository extends RepositoryFireStore<CardModel> {
  @override
  CardModel convertJsonToModel(Map<String, dynamic> map) {
    return CardModel.fromJson(map);
  }

  @override
  Map<String, dynamic> convertModelToJson(CardModel model) {
    return model.toJson();
  }

  @override
  String get nameCollection => 'card';
}
