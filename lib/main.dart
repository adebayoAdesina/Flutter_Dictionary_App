import 'package:dictionary/screen/main_screen.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(null);
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 3));
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
