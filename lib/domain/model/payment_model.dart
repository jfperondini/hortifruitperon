import 'package:hortifruitperon/domain/model/card_model.dart';

class PaymentModel {
  String? id;
  double amountPaid;
  CardModel cardModel;

  PaymentModel({
    required this.id,
    required this.amountPaid,
    required this.cardModel,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'amountPaid': amountPaid,
      'card': cardModel.toJson(),
    };
  }

  factory PaymentModel.fromJson(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'] ?? '',
      amountPaid: map['amountPaid'] ?? 0.00,
      cardModel: CardModel.fromJson(map['card'] ?? {}),
    );
  }

  factory PaymentModel.empty() {
    return PaymentModel.fromJson({});
  }
}
