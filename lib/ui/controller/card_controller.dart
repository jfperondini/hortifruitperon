import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hortifruitperon/cors/repository/repository.dart';
import 'package:hortifruitperon/cors/shared/utils/card_utils.dart';
import 'package:hortifruitperon/data/services/auth_service.dart';
import 'package:hortifruitperon/domain/model/card_model.dart';
import 'package:hortifruitperon/ui/controller/home_controller.dart';

class CardController extends ChangeNotifier {
  final AuthService authService;
  final HomeController homeController;
  final Repository<CardModel> repositoryCard;

  CardController(this.authService, this.homeController, this.repositoryCard);

  List<CardModel> listCard = [];
  CardModel? get orderSelect => homeController.orderSelect?.paymentModel.cardModel;

  CardType cardType = CardType.Others;

  final add = TextEditingController();
  final number = TextEditingController();
  final name = TextEditingController();
  final cvv = TextEditingController();
  final data = TextEditingController();

  int? _selectedCard;
  int get selectedCard => _selectedCard ??= -1;

  chooseCard(int value) {
    if (value >= 0 && value < listCard.length) _selectedCard = value;
    homeController.orderSelect?.paymentModel.cardModel = listCard[value];
    notifyListeners();
  }

  getCardTypeFrmNumber() {
    if (number.text.length <= 6) {
      CardType newCardtype = CardUtils.getCardTypeFrmNum(number.text);
      if (cardType != cardType) {
        cardType = newCardtype;
        notifyListeners();
      }
    }
  }

  initCardNumber() {
    number.addListener(() {
      getCardTypeFrmNumber();
    });
  }

  getListCard() async {
    User? user = await authService.getAuthUser();
    listCard = await repositoryCard.getListSubCollection(idUser: user?.uid ?? '');
    notifyListeners();
  }

  putCard() async {
    User? user = await authService.getAuthUser();
    repositoryCard.putSubCollection(idUser: user?.uid ?? '', values: {
      'number': int.parse(CardUtils.getCleanNum(number.text)),
      'name': name.text,
      'cvv': int.parse(cvv.text),
      'data': data.text,
    });
    notifyListeners();
  }

  deleteCard(int index) async {
    User? user = await authService.getAuthUser();
    repositoryCard.deleteSubCollection(idUser: user?.uid ?? '', idModel: listCard[index].id ?? '');
    notifyListeners();
  }

  clearCard() {
    number.text = '';
    name.text = '';
    cvv.text = '';
    data.text = '';
    _selectedCard = 1;
    notifyListeners();
  }
}
