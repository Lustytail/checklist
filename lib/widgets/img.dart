import 'package:flutter/material.dart';

class Img extends StatelessWidget {
  const Img({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/home.jpg',
      width: 600,
    );
  }
}
