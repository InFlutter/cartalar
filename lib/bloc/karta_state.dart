import 'package:card_app/data/model/karta.dart';

abstract class CardState {}

class CardLoadInProgress extends CardState {}

class CardLoadSuccess extends CardState {
  final List<CardModel> cards;

  CardLoadSuccess(this.cards);
}

class CardOperationFailure extends CardState {
  final String error;

  CardOperationFailure(this.error); // Xatolik xabarini qabul qiladigan holat
}
