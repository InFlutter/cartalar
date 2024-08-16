import 'package:card_app/data/model/karta.dart';

abstract class CardEvent {}

class LoadCards extends CardEvent {}

class AddCard extends CardEvent {
  final CardModel card;

  AddCard(this.card);
}
