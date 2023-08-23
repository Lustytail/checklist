import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textFieldController = TextEditingController();
  List<String> checkList = [];
  int count = 0;
  String text = "";

  void addCheckList() {
    setState(() {
      text = _textFieldController.text;
      if (text.isNotEmpty) {
        checkList.add(text);
        _textFieldController.clear();

        count = count + 1;
      }
    });
  }

  void removeCheckList() {
    _textFieldController.clear();
  }

  void changeList(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedText = ""; // Create a variable to hold the new text

        return AlertDialog(
          title: const Text("수정할 내용을 작성해주세요."),
          content: TextField(
            onChanged: (value) {
              updatedText = value; // Update the new text as user types
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Icon(
                Icons.cancel,
                size: 30,
                color: Colors.red,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (updatedText.isNotEmpty) {
                    checkList[index] =
                        updatedText; // Update the text in the list
                  }
                  Navigator.of(context).pop(); // Close the dialog
                });
              },
              child: const Icon(
                Icons.save,
                size: 30,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  void markCalendar() {
    print("Mark Calendar");
  }

  void addList() {
    setState(() {
      print("Show Modal");

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 150,
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 20,
                          child: TextField(
                            autofocus: true,
                            controller: _textFieldController,
                            decoration: const InputDecoration(
                                hintText: "Add Check List"),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: addCheckList,
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                      IconButton(
                        onPressed: removeCheckList,
                        icon: const Icon(
                          Icons.delete_outline,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.calendar_month_sharp),
                        onPressed: addCalendar,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  void addCalendar() {
    print("add Calendar");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Column(
            children: [
              for (int index = 0; index < checkList.length; index++)
                for (int index = 0; index < checkList.length; index++)
                  Dismissible(
                    key: UniqueKey(),
                    onDismissed: (_) {
                      setState(() {
                        checkList.removeAt(index);
                      });
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.red.withOpacity(0.8),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                          height: 20,
                        ),
                        Text(
                          checkList[index],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          tooltip: "수정하기",
                          onPressed: () => changeList(index),
                          icon: const Icon(Icons.edit_outlined),
                        ),
                        IconButton(
                          tooltip: "달력에 표시",
                          onPressed: markCalendar,
                          icon: const Icon(Icons.edit_calendar_rounded),
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              "body",
              style: TextStyle(
                color: Theme.of(context).cardColor,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: addList,
                  icon: const Icon(Icons.add_circle),
                  color:
                      const Color.fromARGB(255, 189, 160, 240).withOpacity(0.8),
                  iconSize: 60,
                  style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(
                      Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
