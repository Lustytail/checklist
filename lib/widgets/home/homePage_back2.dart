import 'package:flutter/material.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  late String formattedDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime now = DateTime.now();
    formattedDate = '${now.year}.${now.month}.${now.day}';

    int dayOfWeek = now.weekday;
    String weekdayString = '';

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

  @override
  Widget build(BuildContext context) {
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(color: Colors.deepPurple),
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
                backgroundColor: MaterialStateProperty.all(
                  Colors.greenAccent.withOpacity(0.5),
                ),
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
    );
  }
}
