import 'package:card_app/bloc/karta_bloc.dart';
import 'package:card_app/bloc/karta_event.dart';
import 'package:card_app/ui/screens/card_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardBloc()
        ..add(
            LoadCards()), // CardBloc ni yaratib, LoadCards hodisasini yuborish
      child: CardListScreen(),
    );
  }
}
