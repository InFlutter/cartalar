import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_app/data/model/karta.dart';
import 'karta_event.dart';
import 'karta_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CardBloc() : super(CardLoadInProgress()) {
    on<AddCard>(_onAddCard);
    on<LoadCards>(_onLoadCards);
  }

  Future<void> _onAddCard(AddCard event, Emitter<CardState> emit) async {
    try {
      await _firestore.collection('cards').add({
        'fullName': event.card.fullName,
        'number': event.card.number,
        'expiryDate': event.card.expiryDate,
        'balance': event.card.balance,
      });

      // Kartalar ro'yxatini yangilash uchun LoadCards hodisasini qo'shish
      add(LoadCards());
    } catch (error) {
      emit(CardOperationFailure(error.toString()));
    }
  }

  Future<void> _onLoadCards(LoadCards event, Emitter<CardState> emit) async {
    try {
      emit(CardLoadInProgress());
      final QuerySnapshot snapshot = await _firestore.collection('cards').get();
      final cards = snapshot.docs
          .map((doc) => CardModel(
                id: doc.id,
                fullName: doc['fullName'],
                number: doc['number'],
                expiryDate: doc['expiryDate'],
                balance: doc['balance'],
              ))
          .toList();
      emit(CardLoadSuccess(cards));
    } catch (error) {
      emit(CardOperationFailure(error.toString()));
    }
  }
}
