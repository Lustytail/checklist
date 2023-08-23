import 'package:flutter/material.dart';
import 'widgets/mainPage.dart';

void main() {
  runApp(const MyApp());
}

//TESTSTETSTSETS1
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Page',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
