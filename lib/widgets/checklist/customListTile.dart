import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  final String question;
  final int index;
  const CustomListTile({
    super.key,
    required this.question,
    required this.index,
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  late int questionId;
  String answer = '';
// Function to save the selected value
  void saveSelectedValue(int index, String value) {
    setState(() {
      questionId = index;
      answer = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${widget.index}. ${widget.question}'),
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
                  onPressed: () {
                    saveSelectedValue(widget.index, '3');
                    print(questionId);
                    print(answer);
                  },
                  child: const Text('좋아요')),
              FilledButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.green),
                  ),
                  onPressed: () {
                    saveSelectedValue(widget.index, '2');
                    print(questionId);
                    print(answer);
                  },
                  child: const Text('보통이에요')),
              FilledButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.red),
                  ),
                  onPressed: () {
                    saveSelectedValue(widget.index, '1');
                    print(questionId);
                    print(answer);
                  },
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
