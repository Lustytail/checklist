import 'package:flutter/material.dart';

// BottomNavigationBar 안보이게 하기
class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 0); // Make the BottomNavigationBar invisible
  }
}
