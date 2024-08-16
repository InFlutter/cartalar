import 'package:card_app/data/model/pul_kochirish.dart';
import 'package:card_app/ui/widgets/pul_kochirish_manager.dart';
import 'package:flutter/material.dart';
import 'package:card_app/data/model/karta.dart';

class PulKochirishScreen extends StatelessWidget {
  final CardModel senderCard;
  final TextEditingController boshqaKartaRaqamiController = TextEditingController();
  final TextEditingController otkazishSummasiController = TextEditingController();

  PulKochirishScreen({required this.senderCard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pul O\'tkazish')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Sender Card: ${senderCard.fullName} (${senderCard.number})'),
            SizedBox(height: 20),
            TextField(
              controller: boshqaKartaRaqamiController,
              decoration: InputDecoration(labelText: 'Boshqa Karta Raqami'),
            ),
            TextField(
              controller: otkazishSummasiController,
              decoration: InputDecoration(labelText: 'O\'tkazish Summasi'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final pulKochirish = PulKochirish(
                  boshqaKartaRaqami: boshqaKartaRaqamiController.text,
                  otkazishSummasi: double.parse(otkazishSummasiController.text),
                );
                final manager = PulKochirishManager();

                manager.otkazish(pulKochirish, senderCard.id);

                Navigator.pop(context); // Ekrandan chiqish
              },
              child: Text('Pul O\'tkazish'),
            ),
          ],
        ),
      ),
    );
  }
}
