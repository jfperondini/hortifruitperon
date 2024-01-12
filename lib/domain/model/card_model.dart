class CardModel {
  String? id;
  String name;
  int number;
  int cvv;
  String data;

  CardModel({
    required this.id,
    required this.name,
    required this.number,
    required this.cvv,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'number': number,
      'cvv': cvv,
      'data': data,
    };
  }

  factory CardModel.fromJson(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      number: map['number'] ?? 0,
      cvv: map['cvv'] ?? 0,
      data: map['data'] ?? '',
    );
  }

  factory CardModel.empty() {
    return CardModel.fromJson({});
  }
  CardModel copyWith({
    String? id,
    String? name,
    int? number,
    int? cvv,
    String? data,
  }) {
    return CardModel(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.number,
      cvv: cvv ?? this.cvv,
      data: data ?? this.data,
    );
  }
}
