import 'package:dictionary/screen/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dictionary',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Signika Negative',
          appBarTheme: const AppBarTheme(backgroundColor: Colors.pink)),
      home: const MainScreen(),
    );
  }
}
