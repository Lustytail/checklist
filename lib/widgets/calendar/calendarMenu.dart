import 'package:flutter/material.dart';

class CalendarMenu extends StatelessWidget {
  const CalendarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: const Color.fromARGB(255, 101, 101, 101),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Text(
              '임장 캘린더',
              style: TextStyle(
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
