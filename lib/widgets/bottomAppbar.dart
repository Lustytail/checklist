import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.add_box_outlined,
                color: Color.fromARGB(255, 231, 231, 231),
                size: 40,
              ),
              Icon(
                Icons.home,
                color: Color.fromARGB(255, 231, 231, 231),
                size: 40,
              ),
              Icon(
                Icons.favorite_outline,
                color: Color.fromARGB(255, 231, 231, 231),
                size: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
