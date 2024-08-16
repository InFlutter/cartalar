import 'package:card_app/data/model/pul_kochirish.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PulKochirishManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> otkazish(PulKochirish pulKochirish, String senderCardId) async {
    try {
      final senderCardRef = _firestore.collection('cards').doc(senderCardId);

      // Qabul qiluvchi karta uchun DocumentReference olish
      final receiverCardQuery = await _firestore
          .collection('cards')
          .where('number', isEqualTo: pulKochirish.boshqaKartaRaqami)
          .limit(1)
          .get();

      if (receiverCardQuery.docs.isEmpty) {
        throw Exception('Receiver card not found');
      }

      final receiverCardRef = receiverCardQuery.docs.first.reference;

      // O'tkazuvchi karta ma'lumotlarini olish
      final senderCardDoc = await senderCardRef.get();
      final senderCardData = senderCardDoc.data()!;
      final senderBalance = senderCardData['balance'] as double;

      if (senderBalance < pulKochirish.otkazishSummasi) {
        throw Exception('Insufficient balance');
      }

      // O'tkazuvchi va qabul qiluvchi kartalarni yangilash
      await _firestore.runTransaction((transaction) async {
        final senderCardSnapshot = await transaction.get(senderCardRef);
        final receiverCardSnapshot = await transaction.get(receiverCardRef);

        if (!senderCardSnapshot.exists) {
          throw Exception('Sender card does not exist');
        }

        final updatedSenderBalance =
            senderCardSnapshot['balance'] - pulKochirish.otkazishSummasi;
        final updatedReceiverBalance =
            receiverCardSnapshot['balance'] + pulKochirish.otkazishSummasi;

        transaction.update(senderCardRef, {'balance': updatedSenderBalance});
        transaction
            .update(receiverCardRef, {'balance': updatedReceiverBalance});
      });
    } catch (e) {
      print('Error: $e');
    }
  }
}
