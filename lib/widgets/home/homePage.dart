import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wyeta/widgets/checklist/checklistWrite.dart';
import 'package:wyeta/widgets/home/customizeWidget.dart';
import 'package:wyeta/hive/home.dart';
import 'package:wyeta/hive/homeList.dart';
import 'package:wyeta/widgets/home/homState.dart';

import 'package:wyeta/widgets/home/homeBody.dart';

//
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = "";
  List<Widget> folderRows = [];
  List<CustomizeWidget> customizeWidget = [];
  bool customizeWidgettoggle = false;
  final TextEditingController _textFieldController = TextEditingController();

  var homeListBox = Hive.box<HomeList>('homeList');
  var homeBox = Hive.box<Home>('home');

  // Future<void> _pickImage() async {
  //   try {
  //     // If user picks an image, update the state with the new image file
  //     setState(() {
  //       Navigator.pop(
  //         context,
  //       );
  //     });
  //   } catch (e) {
  //     // If there is an error, show a snackbar with the error message
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(e.toString()),
  //       ),
  //     );
  //   }
  // }

  late String formattedDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime now = DateTime.now();
    formattedDate = '${now.year}.${now.month}.${now.day}';

    int dayOfWeek = now.weekday;
    String weekdayString = '';
    int currentIndex = 1;

    switch (dayOfWeek) {
      case 1:
        weekdayString = '월';
        break;
      case 2:
        weekdayString = '화';
        break;
      case 3:
        weekdayString = '수';
        break;
      case 4:
        weekdayString = '목';
        break;
      case 5:
        weekdayString = '금';
        break;
      case 6:
        weekdayString = '토';
        break;
      case 7:
        weekdayString = '일';
        break;
    }

    formattedDate += ' $weekdayString ${now.hour}:${now.minute}';
  }

  bool isList = true;

  void showList() {
    setState(() {
      isList = true;
    });
  }

  void showMap() {
    setState(() {
      isList = false;
    });
  }

  void deleteList() {
    setState(() {
      print("delete List");
    });
  }

  void confirm() {
    Navigator.pop(context);
  }

  void openEditModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter bottomState) {
          return SizedBox(
            height: 250,
            child: Column(
              children: [
                const Center(
                  child: Text(
                    "편집",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          print("호출 처음시작");
                          final result = await createFolderModal();
                          print(result);
                          print("호출 끝");

                          bottomState(() {
                            result;
                          });
                        },
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int index = 0; index < folderRows.length; index++)
                          Dismissible(
                            confirmDismiss: (direction) {
                              if (direction == DismissDirection.startToEnd) {
                                return showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: const Text("Are you sure?"),
                                      content: Text(
                                        "Now I Am deleteting $index st Folder",
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.grey),
                                          ),
                                          onPressed: () {
                                            return Navigator.of(context)
                                                .pop(false);
                                          },
                                          child: const Text("CANCEL"),
                                        ),
                                        ElevatedButton(
                                          style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.red),
                                          ),
                                          onPressed: () {
                                            return Navigator.of(context)
                                                .pop(true);
                                          },
                                          child: const Text("DELETE"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if (direction ==
                                  DismissDirection.endToStart) {
                                return showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: const Icon(
                                          size: 30.0,
                                          color: Colors.red,
                                          Icons.warning,
                                        ),
                                        content: const Text(
                                            'Please slide from left to right'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            onPressed: () {
                                              return Navigator.of(context)
                                                  .pop(false);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    });
                              }
                              return Future.value(null); //아무것도 아닐때 null을 반환
                            },
                            onDismissed: (_) {
                              setState(() {
                                folderRows.removeAt(index);
                                customizeWidget.removeAt(index);
                              });
                            },
                            background: Container(
                              color: Colors.red.withOpacity(
                                0.8,
                              ),
                              alignment: Alignment.centerRight,
                            ),
                            key: UniqueKey(),
                            child: Row(
                              children: [
                                folderRows[index],
                              ],
                            ),
                          ),
                      ],
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
        });
      },
    );
  }

  Future<List> createFolderModal() async {
    return await showModalBottomSheet(
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
              const SizedBox(
                height: 20,
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
              const Expanded(
                child: SizedBox(),
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
  }

  void newFolder() {
    text = _textFieldController.text;

    if (text.isNotEmpty) {
      // 폴더 이름이 비어있지 않은 경우에만 추가
      folderRows.add(
        SizedBox(
          height: 60,
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  size: 36,
                  Icons.folder,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 6.0),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      setState(() {
        addCustomizeWidget(text, const Color.fromARGB(255, 214, 213, 213));
      });
    }
    _textFieldController.clear();
    Navigator.pop(context, folderRows);
  }

  void addCustomizeWidget(String text, Color color) {
    customizeWidget.add(
      CustomizeWidget(
        text: text,
        color: const Color.fromARGB(255, 214, 213, 213),
      ),
    );
  }

  void clickActionButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChecklistWrite(),
      ),
    );
  }

  void deleteHome(Home home) {
    // 홈 데이터 삭제
    int index = homeBox.keys.cast<int>().firstWhere(
          (key) => homeBox.get(key) == home,
          orElse: () => -1,
        );

    if (index != -1) {
      homeBox.delete(index);
    }

    // 업데이트된 홈 데이터 목록을 가져옴
    List<Home> updatedHomeList = homeBox.values.toList();

    // homeListBox의 homeList 업데이트
    homeListBox.put(
      "1",
      HomeList(homeList: updatedHomeList),
    );

    // 상태 업데이트
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final homeState = Provider.of<HomeState>(context);
    print('homeState $homeState');

    HomeList? homeListData = homeListBox.get("1");
    var homeData = homeBox.get(1);
    // var homeBox = Hive.box<Home>('home');
    // var temp = homeBox.get("1");
    // var homeListBox = Hive.box<HomeList>('homeList');
    // var homeBox = Hive.box<Home>('home');
    // HomeList? homeListData = homeListBox.get("1");
    // var homeData = homeBox.get(1);
    // print(homeData!.name);

    // if (homeListData != null) {
    //   List<Home> list = homeListData.homeList;
    //   for (Home home in list) {
    //     print("Name: ${home.name}");
    //     print("Address: ${home.address}");
    //     print("Description: ${home.description}");
    //     print("Price: ${home.price}");

    //     print("-----");
    //   }
    // } else {
    //   print("No data found in homeListBox for key '1'");
    // }

    return InkWell(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: isList
                      ? const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              style: BorderStyle.solid,
                              color: Color.fromARGB(255, 32, 134, 235),
                              width: 2.0,
                            ),
                          ),
                        )
                      : null,
                  child: InkWell(
                    onTap: showList,
                    child: const Text(
                      style: TextStyle(fontSize: 15),
                      "리스트로 보기",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: !isList
                      ? const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              style: BorderStyle.solid,
                              color: Color.fromARGB(255, 32, 134, 235),
                              width: 2.0,
                            ),
                          ),
                        )
                      : null,
                  child: InkWell(
                    onTap: showMap,
                    child: const Text(
                      "지도로 보기",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 2,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (int index = 0;
                            index < customizeWidget.length;
                            index++)
                          GestureDetector(
                            onDoubleTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext) {
                                  return AlertDialog(
                                    title: const Text("Are you sure?"),
                                    content: Text(
                                      "Now I Am deleteting $index st Folder",
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.grey),
                                        ),
                                        onPressed: () {
                                          return Navigator.of(context)
                                              .pop(false);
                                        },
                                        child: const Text("CANCEL"),
                                      ),
                                      ElevatedButton(
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.red),
                                        ),
                                        onPressed: () {
                                          setState(
                                            () {
                                              customizeWidget.removeAt(index);
                                              folderRows.removeAt(index);
                                            },
                                          );
                                          return Navigator.of(context)
                                              .pop(true);
                                        },
                                        child: const Text("DELETE"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onTap: () {
                              setState(
                                () {
                                  customizeWidgettoggle
                                      ? customizeWidget[index] =
                                          CustomizeWidget(
                                          text: customizeWidget[index].text,
                                          color: const Color.fromARGB(
                                              255, 7, 118, 192),
                                        )
                                      : customizeWidget[index] =
                                          CustomizeWidget(
                                          text: customizeWidget[index].text,
                                          color: const Color.fromARGB(
                                              255, 214, 213, 213),
                                        );
                                  customizeWidgettoggle =
                                      !customizeWidgettoggle;
                                },
                              );
                            },
                            child: Tooltip(
                              message: "폴더를 삭제하실려면 두번 클릭하세요.",
                              child: customizeWidget[index],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: openEditModal,
                        icon: const Icon(
                          Icons.settings,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (Home home in homeListData!.homeList)
                    HomeBody(
                      home: home,
                      onDelete: deleteHome,
                    ),
                  //body 데이터(자식)
                ],
              ),
            ),
          ),
          SizedBox(
            width: 400,
            child: ElevatedButton(
              onPressed: clickActionButton,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                backgroundColor:
                    Colors.teal.withOpacity(0.5), // Adjust padding as needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8.0), // Adjust the radius for rounded corners
                ), // Button color
              ),
              child: const Text("새로운 매물 체크 시작하기"),
            ),
          )
        ],
      ),
    );
  }
}
