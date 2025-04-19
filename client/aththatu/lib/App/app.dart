import 'package:flutter/material.dart';
import '../Home/home_page.dart';
import '../Profile/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aththatu',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.yellow[50],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}