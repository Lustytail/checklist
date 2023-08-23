import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';

class CalendarMenu extends StatelessWidget {
  const CalendarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: const Color.fromARGB(255, 101, 101, 101),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Text(
              context.read<GlobalValue>().str,
              style: const TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 231, 231, 231),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
