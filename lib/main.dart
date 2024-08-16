import 'package:card_app/bloc/karta_event.dart';
import 'package:card_app/ui/screens/home_screen.dart';
import 'package:card_app/ui/screens/login_screen.dart';
import 'package:card_app/ui/screens/card_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_app/bloc/karta_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CardBloc()..add(LoadCards()), // Dastlabki kartalarni yuklash
      child: MaterialApp(
        title: 'Online Bank',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
        // Agar `CardListScreen` asosiy ekran bo'lsa, quyidagi qatorni o'zgartiring:
        // home: CardListScreen(),
      ),
    );
  }
}
