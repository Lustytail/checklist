import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  final String question;
  final int index;
  final Map? returnData;
  const CustomListTile({
    super.key,
    required this.question,
    required this.index,
    this.returnData,
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  TextEditingController descriptionController = TextEditingController();

// Function to save the selected value
  void saveSelectedValue(String value) {
    setState(() {
      widget.returnData!['${widget.index}'] = [
        value,
        descriptionController.text
      ];
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
                    saveSelectedValue('3');
                  },
                  child: const Text('좋아요')),
              FilledButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.green),
                  ),
                  onPressed: () {
                    saveSelectedValue('2');
                  },
                  child: const Text('보통이에요')),
              FilledButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.red),
                  ),
                  onPressed: () {
                    saveSelectedValue('1');
                  },
                  child: const Text('나빠요')),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: descriptionController,
            onChanged: (value) {
              saveSelectedValue('3');
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '간단한 메모',
            ),
          ),
        ],
      ),
    );
  }
}
