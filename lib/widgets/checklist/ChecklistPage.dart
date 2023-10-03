import 'package:flutter/material.dart';
import 'package:wyeta/widgets/checklist/checklistLoad.dart';
import 'package:wyeta/widgets/checklist/checklistWrite.dart';

class ChecklistPage extends StatelessWidget {
  const ChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChecklistWrite()),
            );
          },
          child: const Text(
            'Go Write Checklist',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const ChecklistLoad(houseName: '트리마제 306동 3901호')),
            );
          },
          child: const Text(
            '트리마제 305동 3901호',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
