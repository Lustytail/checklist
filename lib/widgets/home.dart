import 'package:flutter/material.dart';

import 'img.dart';
import 'location.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
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
            Img(),
            const GPSWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add my ETA',
        backgroundColor: const Color.fromARGB(222, 144, 144, 202),
        child: const Icon(Icons.add),
      ),
    );
  }
}
