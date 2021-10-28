import 'package:flutter/material.dart';
import 'package:soccer_app/screens/index_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soccer App',
      home: IndexScreen(),
    );
  }
}