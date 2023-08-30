import 'package:flutter/material.dart';

class CreateFolderModal extends StatefulWidget {
  const CreateFolderModal({super.key});

  @override
  State<CreateFolderModal> createState() => _CreateFolderModalState();
}

class _CreateFolderModalState extends State<CreateFolderModal> {
  @override
  final TextEditingController _textFieldController = TextEditingController();
  List<String> folderList = [];

  void newFolder() {
    setState(() {
      folderList.add(_textFieldController.text);
      _textFieldController.clear();
    });
  }

  void createNewFolder() {
    setState(() {
      createFolderModal();
    });
  }

  void createFolderModal() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 700,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context); //뒤로가기
                    },
                    color: Colors.black,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "새로운 폴더 추가하기",
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                autofocus: true,
                controller: _textFieldController,
                decoration: const InputDecoration(
                  hintText: "폴더 이름을 입력해 주세요.",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          5.0), // Adjust the radius for rounded corners
                      // Border color to black
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.blue[400],
                  ),
                  minimumSize: MaterialStateProperty.all(
                    const Size(double.infinity, 40),
                  ),
                ),
                onPressed: newFolder,
                child: const Text("저장"),
              ),
            ],
          ),
        );
      },
    );
    _textFieldController.clear();
    print("Modal is Close");
  }

  void confirm() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          const Center(
            child: Text(
              "편집",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
          SizedBox(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int index = 0; index < folderList.length; index++)
                  IconButton(
                    onPressed: createNewFolder,
                    icon: const Icon(
                      size: 36,
                      Icons.add_box_sharp,
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    top: 6.0,
                  ),
                  child: Text(
                    "새로운 폴더 추가하기",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      5.0), // Adjust the radius for rounded corners
                  // Border color to black
                ),
              ),
              backgroundColor: MaterialStateProperty.all(
                Colors.blue[400],
              ),
              minimumSize: MaterialStateProperty.all(
                const Size(double.infinity, 40),
              ),
            ),
            onPressed: confirm,
            child: const Text("확인"),
          ),
        ],
      ),
    );
  }
}
