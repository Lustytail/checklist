import 'package:flutter/material.dart';
import 'package:wyeta/widgets/common/filedButton.dart';

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
  int selectedButtonIndex = -1; // 선택된 버튼의 인덱스를 저장하는 변수

// Function to save the selected value
  void saveSelectedValue(String value) {
    setState(() {
      widget.returnData!['${widget.index}'] = [
        value,
        descriptionController.text
      ];
    });
  }

  void _onButtonPressed(int index) {
    setState(() {
      selectedButtonIndex = index; // 선택된 버튼의 인덱스 업데이트
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
              FilledButtons(
                onPressed: () {
                  _onButtonPressed(0);
                  saveSelectedValue('3');
                },
                backgroundColor: Colors.blue,
                isSelected: selectedButtonIndex == 0,
                child: const Text('좋아요'),
              ),
              FilledButtons(
                onPressed: () {
                  _onButtonPressed(1);
                  saveSelectedValue('2');
                },
                backgroundColor: Colors.green,
                isSelected: selectedButtonIndex == 1,
                child: const Text('보통이에요'),
              ),
              FilledButtons(
                onPressed: () {
                  _onButtonPressed(2);
                  saveSelectedValue('1');
                },
                backgroundColor: Colors.red,
                isSelected: selectedButtonIndex == 2,
                child: const Text('나빠요'),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: descriptionController,
            onChanged: (value) {
              saveSelectedValue('');
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
