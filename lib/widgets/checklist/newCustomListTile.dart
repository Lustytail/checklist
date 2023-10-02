import 'package:flutter/material.dart';
import 'package:wyeta/widgets/common/filedButton.dart';

class NewCustomListTile extends StatefulWidget {
  final String question;
  final int index;
  final Map? returnData;
  final VoidCallback onPressed;

  const NewCustomListTile({
    super.key,
    required this.question,
    required this.index,
    this.returnData,
    required this.onPressed,
  });

  @override
  State<NewCustomListTile> createState() => _NewCustomListTileState();
}

class _NewCustomListTileState extends State<NewCustomListTile> {
  TextEditingController descriptionController = TextEditingController();
  int selectedButtonIndex = -1; // 선택된 버튼의 인덱스를 저장하는 변수

// 선택한 값을 저장
  void saveSelectedValue({required String value, required int index}) {
    setState(() {
      widget.returnData!['${widget.index}'] = [value, ""];
      selectedButtonIndex = index; // 선택된 버튼의 인덱스 업데이트
      widget.onPressed();
    });
  }

// 메모저장
  void saveDescription() {
    setState(() {
      widget.returnData!['${widget.index}'][1] = descriptionController.text;
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
              saveDescription();
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
