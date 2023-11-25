import 'package:flutter/material.dart';
import 'package:ta_ppb/pages/intropage.dart';
import 'package:ta_ppb/pages/home.dart';
import 'package:ta_ppb/pages/login.dart';
import 'package:ta_ppb/pages/review.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Car Rental Site',
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: const IntroPage(),
        routes: {
          '/home': (context) => const HomePage(),
          '/intropage': (context) => const IntroPage(),
          '/login': (context) => LoginPage(),
          '/review': (context) => ReviewPage(),
        });
  }
}
