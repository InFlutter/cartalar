import 'package:card_app/bloc/karta_bloc.dart';
import 'package:card_app/bloc/karta_event.dart';
import 'package:card_app/data/model/karta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCardScreen extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Card')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: numberController,
              decoration: InputDecoration(labelText: 'Card Number'),
            ),
            TextField(
              controller: expiryDateController,
              decoration: InputDecoration(labelText: 'Expiry Date'),
            ),
            TextField(
              controller: balanceController,
              decoration: InputDecoration(labelText: 'Balance'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final card = CardModel(
                  id: '', // Unique ID generation if needed
                  fullName: fullNameController.text,
                  number: numberController.text,
                  expiryDate: expiryDateController.text,
                  balance: double.parse(balanceController.text),
                );
                context.read<CardBloc>().add(AddCard(card));
                Navigator.pop(context); // Return to previous screen
                context.read<CardBloc>().add(LoadCards()); // Refresh card list
              },
              child: Text('Add Card'),
            ),
          ],
        ),
      ),
    );
  }
}
