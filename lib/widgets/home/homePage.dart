import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage> {
  String text = "";
  List<Widget> folderRows = [];
  final TextEditingController _textFieldController = TextEditingController();
  Future<void> _pickImage() async {
    try {
      // If user picks an image, update the state with the new image file
      setState(() {
        Navigator.pop(
          context,
        );
      });
    } catch (e) {
      // If there is an error, show a snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

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

  void openEditModal() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
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
                      onPressed: createFolderModal,
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
                        folderRows[index],
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
      },
    );

    print("Modal is Close");
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
    _textFieldController.clear();
    print("Modal is Close");
  }

  void newFolder() {
    setState(() {
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
      }
    });
    Navigator.pop(context);
  }

  void clickActionButton() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); //뒤로가기
          },
          color: Colors.black,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: InkWell(
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
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 5),
            // ),
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
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 32, 134, 235),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "전체",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 32, 134, 235),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "내 리스트",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: openEditModal,
                            icon: const Icon(
                              Icons.settings,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //body 데이터 들어가는부분
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 16.0, right: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formattedDate,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                                const Text("[예시]재건축 앞둔 우성아파트"),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                                const Text("전세 7억"),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      '\u{1F60D}',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '\u{1F60A}',
                                      style: TextStyle(
                                        color: Colors.amber,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '\u{1F614}',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 24, 15, 15),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.grey.withOpacity(0.5),
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            strutStyle: const StrutStyle(fontSize: 8.0),
                            text: const TextSpan(
                                text:
                                    '세계문자 가운데 한글,즉 훈민정음은 흔히들 신비로운 문자라 부르곤 합니다. 그것은 세계 문자 가운데 유일하게 한글만이 그것을 만든 사람과 반포일을 알며, 글자를 만든 원리까지 알기 때문입니다. 세계에 이런 문자는 없습니다. 그래서 한글은, 정확히 말해 [훈민정음 해례본](국보 70호)은 진즉에 유네스코 세계기록유산으로 등재되었습니다. ‘한글’이라는 이름은 1910년대 초에 주시경 선생을 비롯한 한글학자들이 쓰기 시작한 것입니다. 여기서 ‘한’이란 크다는 것을 뜻하니, 한글은 ‘큰 글’을 말한다고 하겠습니다.[네이버 지식백과] 한글 - 세상에서 가장 신비한 문자 (위대한 문화유산, 최준식)',
                                style: TextStyle(
                                    color: Colors.black,
                                    height: 1.4,
                                    fontSize: 16.0,
                                    fontFamily: 'NanumSquareRegular')),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5.0), // Adjust the radius for rounded corners
                              side: const BorderSide(
                                  color: Colors.black), // Border color to black
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 40),
                          ),
                        ),
                        onPressed: deleteList,
                        child: const Text("예시 삭제하기"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 16.0, right: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formattedDate,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                                const Text("[예시]재건축 앞둔 우성아파트"),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                                const Text("전세 7억"),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      '\u{1F60D}',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '\u{1F60A}',
                                      style: TextStyle(
                                        color: Colors.amber,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '\u{1F614}',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 24, 15, 15),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.grey.withOpacity(0.5),
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            strutStyle: const StrutStyle(fontSize: 8.0),
                            text: const TextSpan(
                                text:
                                    '세계문자 가운데 한글,즉 훈민정음은 흔히들 신비로운 문자라 부르곤 합니다. 그것은 세계 문자 가운데 유일하게 한글만이 그것을 만든 사람과 반포일을 알며, 글자를 만든 원리까지 알기 때문입니다. 세계에 이런 문자는 없습니다. 그래서 한글은, 정확히 말해 [훈민정음 해례본](국보 70호)은 진즉에 유네스코 세계기록유산으로 등재되었습니다. ‘한글’이라는 이름은 1910년대 초에 주시경 선생을 비롯한 한글학자들이 쓰기 시작한 것입니다. 여기서 ‘한’이란 크다는 것을 뜻하니, 한글은 ‘큰 글’을 말한다고 하겠습니다.[네이버 지식백과] 한글 - 세상에서 가장 신비한 문자 (위대한 문화유산, 최준식)',
                                style: TextStyle(
                                    color: Colors.black,
                                    height: 1.4,
                                    fontSize: 16.0,
                                    fontFamily: 'NanumSquareRegular')),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5.0), // Adjust the radius for rounded corners
                              side: const BorderSide(
                                  color: Colors.black), // Border color to black
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 40),
                          ),
                        ),
                        onPressed: deleteList,
                        child: const Text("예시 삭제하기"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 16.0, right: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formattedDate,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                                const Text("[예시]재건축 앞둔 우성아파트"),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                                const Text("전세 7억"),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      '\u{1F60D}',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '\u{1F60A}',
                                      style: TextStyle(
                                        color: Colors.amber,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '\u{1F614}',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 24, 15, 15),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.grey.withOpacity(0.5),
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            strutStyle: const StrutStyle(fontSize: 8.0),
                            text: const TextSpan(
                                text:
                                    '세계문자 가운데 한글,즉 훈민정음은 흔히들 신비로운 문자라 부르곤 합니다. 그것은 세계 문자 가운데 유일하게 한글만이 그것을 만든 사람과 반포일을 알며, 글자를 만든 원리까지 알기 때문입니다. 세계에 이런 문자는 없습니다. 그래서 한글은, 정확히 말해 [훈민정음 해례본](국보 70호)은 진즉에 유네스코 세계기록유산으로 등재되었습니다. ‘한글’이라는 이름은 1910년대 초에 주시경 선생을 비롯한 한글학자들이 쓰기 시작한 것입니다. 여기서 ‘한’이란 크다는 것을 뜻하니, 한글은 ‘큰 글’을 말한다고 하겠습니다.[네이버 지식백과] 한글 - 세상에서 가장 신비한 문자 (위대한 문화유산, 최준식)',
                                style: TextStyle(
                                    color: Colors.black,
                                    height: 1.4,
                                    fontSize: 16.0,
                                    fontFamily: 'NanumSquareRegular')),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5.0), // Adjust the radius for rounded corners
                              side: const BorderSide(
                                  color: Colors.black), // Border color to black
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 40),
                          ),
                        ),
                        onPressed: deleteList,
                        child: const Text("예시 삭제하기"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 16.0, right: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formattedDate,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                                const Text("[예시]재건축 앞둔 우성아파트"),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                                const Text("전세 7억"),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      '\u{1F60D}',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '\u{1F60A}',
                                      style: TextStyle(
                                        color: Colors.amber,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '\u{1F614}',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 24, 15, 15),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.grey.withOpacity(0.5),
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            strutStyle: const StrutStyle(fontSize: 8.0),
                            text: const TextSpan(
                                text:
                                    '세계문자 가운데 한글,즉 훈민정음은 흔히들 신비로운 문자라 부르곤 합니다. 그것은 세계 문자 가운데 유일하게 한글만이 그것을 만든 사람과 반포일을 알며, 글자를 만든 원리까지 알기 때문입니다. 세계에 이런 문자는 없습니다. 그래서 한글은, 정확히 말해 [훈민정음 해례본](국보 70호)은 진즉에 유네스코 세계기록유산으로 등재되었습니다. ‘한글’이라는 이름은 1910년대 초에 주시경 선생을 비롯한 한글학자들이 쓰기 시작한 것입니다. 여기서 ‘한’이란 크다는 것을 뜻하니, 한글은 ‘큰 글’을 말한다고 하겠습니다.[네이버 지식백과] 한글 - 세상에서 가장 신비한 문자 (위대한 문화유산, 최준식)',
                                style: TextStyle(
                                    color: Colors.black,
                                    height: 1.4,
                                    fontSize: 16.0,
                                    fontFamily: 'NanumSquareRegular')),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5.0), // Adjust the radius for rounded corners
                              side: const BorderSide(
                                  color: Colors.black), // Border color to black
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 40),
                          ),
                        ),
                        onPressed: deleteList,
                        child: const Text("예시 삭제하기"),
                      ),
                    ),
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
      ),
    );
  }
}
