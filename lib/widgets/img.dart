import 'package:flutter/material.dart';

class Img extends StatelessWidget {
  Img({super.key});

  int a = 1;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/home.jpg',
      width: 600,
    );
  }
}
