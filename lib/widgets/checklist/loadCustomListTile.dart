import 'package:flutter/material.dart';
import 'package:wyeta/widgets/common/filedButton.dart';

class LoadCustomListTile extends StatefulWidget {
  final String question;
  final int index;
  final Map? returnData;
  const LoadCustomListTile({
    super.key,
    required this.question,
    required this.index,
    this.returnData,
  });

  @override
  State<LoadCustomListTile> createState() => _LoadCustomListTileState();
}

class _LoadCustomListTileState extends State<LoadCustomListTile> {
  TextEditingController descriptionController = TextEditingController();
  int selectedButtonIndex = -1; // 선택된 버튼의 인덱스를 저장하는 변수

// Function to save the selected value
  void saveSelectedValue({required String value, required int index}) {
    setState(() {
      widget.returnData!['${widget.index}'] = [
        value,
        descriptionController.text
      ];
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
                  saveSelectedValue(value: '3', index: 0);
                },
                backgroundColor: Colors.blue,
                isSelected: selectedButtonIndex == 0,
                child: const Text('좋아요'),
              ),
              FilledButtons(
                onPressed: () {
                  saveSelectedValue(value: '2', index: 1);
                },
                backgroundColor: Colors.green,
                isSelected: selectedButtonIndex == 1,
                child: const Text('보통이에요'),
              ),
              FilledButtons(
                onPressed: () {
                  saveSelectedValue(value: '1', index: 2);
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
              setState(
                () {},
              );
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
