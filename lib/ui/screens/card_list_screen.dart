import 'package:card_app/bloc/karta_event.dart';
import 'package:card_app/ui/screens/pul_kochirish.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_app/bloc/karta_bloc.dart';
import 'package:card_app/bloc/karta_state.dart';
import 'package:card_app/data/model/karta.dart';
import 'add_card_screen.dart';

class CardListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCardScreen()),
              ).then((_) {
                // Qaytgandan so'ng kartalarni qayta yuklash
                context.read<CardBloc>().add(LoadCards());
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          if (state is CardLoadSuccess) {
            final cards = state.cards;

            return ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];
                return CardItem(card: card);
              },
            );
          } else if (state is CardLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('Failed to load cards'));
          }
        },
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final CardModel card;

  CardItem({required this.card});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PulKochirishScreen(senderCard: card),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${card.fullName}', style: TextStyle(fontSize: 16)),
            Text('Number: ${card.number}', style: TextStyle(fontSize: 16)),
            Text('Expiry Date: ${card.expiryDate}', style: TextStyle(fontSize: 16)),
            Text('Balance: \$${card.balance.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
