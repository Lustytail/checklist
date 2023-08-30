import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wyeta/image/FilePickerExample.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uint8List? selectedImageBytes;
  bool hasImage = false;
  final TextEditingController _textFieldController = TextEditingController();
  List<String> checkList = [];
  List<dynamic> selectedImageArray = [];
  int count = 0;
  String text = "";
  bool onClick = false;
  OverlayEntry? tooltipEntry;
  bool isHovering = false;
  bool isChildClick = false;
  List<bool> rowChildClickStates = [];

  int totalentry = 0;
  bool isModal = true;

  void addCheckList() {
    setState(() {
      text = _textFieldController.text;
      if (text.isNotEmpty && hasImage == true) {
        print("hasImage true");
        checkList.add(text);
        selectedImageArray.add(selectedImageBytes!);
        _textFieldController.clear();
        count = count + 1;
      } else if (text.isNotEmpty && hasImage == false) {
        print("hasImage false");
        checkList.add(text);
        selectedImageArray.add(null);
        _textFieldController.clear();
        count = count + 1;
      }
      hasImage = false;
    });
    print("checklist");
    print('$checkList');
    print(checkList.length);
    print("selectedImageArray");
    print('$selectedImageArray');
    print(selectedImageArray.length);
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

  void addCalendar() {
    print("add Calendar");
  }

  void addList() {
    setState(() {
      print("Show Modal");
      onClick = true;
      OverlayState? overlayState = Overlay.of(context);

      if (tooltipEntry != null && onClick == true) {
        tooltipEntry!.remove();
      }
      openModalAndHandleDismiss();
    });
    onClick = false;
    rowChildClickStates.add(false);
  }

  void openModalAndHandleDismiss() async {
    await showModalBottomSheet<void>(
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
                          decoration:
                              const InputDecoration(hintText: "Add Check List"),
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
                    IconButton(
                      icon: const Icon(Icons.camera_alt_sharp),
                      onPressed: () async {
                        Uint8List? receivedImageBytes = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FilePickerExample(),
                          ),
                        );

                        if (receivedImageBytes != null) {
                          setState(() {
                            selectedImageBytes = receivedImageBytes;
                            hasImage = true;
                          });
                        } else {
                          setState(() {
                            hasImage = false;
                          });
                        }

                        print(checkList.length);
                        print(selectedImageArray.length);
                        // Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    print("Modal is Close");
    tooltipEntry = null;
    isHovering = false;
  }

  void mouseHover1(bool hovering, event) {
    if (tooltipEntry != null) {
      tooltipEntry?.remove();
    }

    setState(() {
      isHovering = hovering;
    });

    if (hovering) {
      // 툴팁 오버레이를 보여줍니다.
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final localPosition = renderBox.globalToLocal(event.position);

      final tooltip = buildTooltip(context, localPosition.dx, localPosition.dy);
      tooltipEntry = OverlayEntry(
        builder: (context) {
          return Positioned(
            left: localPosition.dx - 5,
            top: localPosition.dy + 30,
            child: tooltip,
          );
        },
      );

      Overlay.of(context).insert(tooltipEntry!);
    } else {
      // 툴팁 오버레이를 제거합니다.

      // tooltipEntry?.remove();
      // tooltipEntry = null;
      tooltipEntry = null;
      if (tooltipEntry == null) {}
    }
  }

  void mouseEnter(bool hovering) {
    setState(() {
      hovering = false;
      tooltipEntry!.remove();
      tooltipEntry = null;
    });
  }

  Widget buildTooltip(BuildContext context, double x, double y) {
    return Container(
      child: const Text(
        '클릭하세요',
        style: TextStyle(
          color: Colors.amber,
          fontSize: 10,
        ),
      ),
    );
  }

  void ImageZoom(index) {
    setState(() {
      print(index);
      print("Image Zoom in ");
      openModalImage(index);
    });
  }

  void openModalImage(int index) async {
    print("modal");
    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.amber,
          width: 200,
          height: 400,
          child: Image.memory(
            selectedImageArray[index],
          ),
        );
      },
    );
  }

  void clickChild(int index) {
    setState(() {
      isModal = false;
      rowChildClickStates[index] = !rowChildClickStates[index];
      // isChildClick = !isChildClick;
      print("click Child ");
    });
    isModal = true;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.orange,
      splashColor: Colors.red,
      focusColor: Colors.yellow,
      highlightColor: Colors.purple,
      onTap: isModal ? addList : null,
      child: Container(
        color: Colors.white,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) => mouseHover1(true, event),
          onExit: (_) {},
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int index = 0; index < checkList.length; index++)
                    MouseRegion(
                      onEnter: (event) => mouseHover1(false, event),
                      child: Dismissible(
                        key: UniqueKey(),
                        onDismissed: (_) {
                          setState(() {
                            checkList.removeAt(index);
                            selectedImageArray.removeAt(index);
                            rowChildClickStates.removeAt(index);
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
                        child: InkWell(
                          onTap: () => clickChild(index),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.redAccent.withOpacity(0.8),
                                  width: 2.0,
                                ),
                              ),
                              boxShadow: rowChildClickStates[index] == true
                                  ? [
                                      BoxShadow(
                                        color: Colors.purpleAccent
                                            .withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    checkList[index],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                selectedImageArray[index] == null
                                    ? const Icon(Icons.image_not_supported)
                                    : InkWell(
                                        onTap: () => ImageZoom(index),
                                        child: Image.memory(
                                          // selectedImageArray[index] ?? Uint8List(0),
                                          selectedImageArray[index]!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
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
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
