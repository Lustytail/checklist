import 'package:flutter/material.dart';

import 'location.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(222, 187, 187, 255),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 50,
          ),
          child: const Text(
            'What\'s your ETA???',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Row(
          children: [
            Text(
              'Test World',
              style: TextStyle(
                color: Color.fromARGB(255, 219, 102, 240),
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Image.asset(
          'assets/home.jpg',
          width: 600,
        ),
        const GPSWidget(),
      ],
    );
  }
}
