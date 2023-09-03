import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String question;
  const CustomListTile({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilledButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.blue),
                  ),
                  onPressed: () {},
                  child: const Text('좋아요')),
              FilledButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.green),
                  ),
                  onPressed: () {},
                  child: const Text('보통이에요')),
              FilledButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.red),
                  ),
                  onPressed: () {},
                  child: const Text('나빠요')),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '간단한 메모',
            ),
          ),
        ],
      ),
    );
  }
}
