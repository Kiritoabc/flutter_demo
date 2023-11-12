import 'package:flutter/material.dart';
import 'package:my_app_1/user/Login/login_screen.dart';

import 'layout/layout.dart';
import 'package:fijkplayer/fijkplayer.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chinese Learning',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.amber,
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Hind'),
        ),
      ),
      home: LoginScreen(),
    );
  }
}

