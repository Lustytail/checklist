import 'package:flutter/material.dart';
import 'package:wyeta/widgets/checklist/checklistWrite.dart';

class ChecklistPage extends StatelessWidget {
  const ChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
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
    );
  }
}
