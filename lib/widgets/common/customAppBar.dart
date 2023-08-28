import 'package:flutter/material.dart';

// appBar 안보이게 하기
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize =>
      const Size.fromHeight(0); // Make the AppBar invisible

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
}
