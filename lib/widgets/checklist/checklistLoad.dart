import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wyeta/hive/checkList.dart';
import 'package:wyeta/hive/house.dart';
import 'package:wyeta/hive/question.dart';
import 'package:wyeta/widgets/checklist/LoadCustomListTile.dart';

class ChecklistLoad extends StatefulWidget {
  final DateTime? date;
  final String houseName;
  const ChecklistLoad({super.key, this.date, required this.houseName});

  @override
  State<ChecklistLoad> createState() => _ChecklistLoadState();
}

class _ChecklistLoadState extends State<ChecklistLoad> {
  String postCode = '-';
  String address = '-';
  String latitude = '-';
  String longitude = '-';
  String kakaoLatitude = '-';
  String kakaoLongitude = '-';
  bool expanded = false;
  Map firstchecklist = {};
  Map secondchecklist = {};
  // 0번째 값이 1, 2, 3일 때 각 값이 몇 번 나왔는지 저장할 Map
  Map<int, int> countMap = {1: 0, 2: 0, 3: 0};
  TextEditingController priceFieldController = TextEditingController();
  TextEditingController sizeFieldController = TextEditingController();
  TextEditingController structureFieldController = TextEditingController();
  final questionData = Hive.box<Question>('question');
  final checklistData = Hive.box<CheckList>('checklist');
  final houseData = Hive.box<House>('house');

  @override
  void initState() {
    super.initState();
    // hive 에서 데이터 가져오기
    priceFieldController.text = houseData.values
            .where((element) => element.name == '은마아파트 301동 1503호')
            .first
            .price ??
        "";
    sizeFieldController.text = houseData.values
            .where((element) => element.name == '은마아파트 301동 1503호')
            .first
            .size ??
        "";
    structureFieldController.text = houseData.values
            .where((element) => element.name == '은마아파트 301동 1503호')
            .first
            .structure ??
        "";
    final checkList = checklistData.values
        .where((element) => element.address == '은마아파트 301동 1503호')
        .toList();

    final firstChecklistData =
        checkList.where((checkList) => checkList.type == 0).toList();
    final secondChecklistData =
        checkList.where((checkList) => checkList.type == 1).toList();
    for (var a in firstChecklistData) {
      firstchecklist[a.questionId.toString()] = [a.answer, a.description];
    }

    for (var a in secondChecklistData) {
      secondchecklist[a.questionId.toString()] = [a.answer, a.description];
    }
    handleGrade();
  }

  @override
  void dispose() {
    priceFieldController.dispose();
    sizeFieldController.dispose();
    structureFieldController.dispose();
    super.dispose();
  }

  // 평점이 1, 2, 3일 때 각 값이 몇 번 나왔는지 저장하는 함수
  void handleGrade() {
    setState(() {
      countMap = {1: 0, 2: 0, 3: 0};
      for (var value in firstchecklist.values) {
        // value의 첫 번째 항목(0번째)을 가져와서 countMap에 증가시킵니다.
        if (value.isNotEmpty) {
          int firstValue = int.parse(value[0]);
          countMap[firstValue] = (countMap[firstValue] ?? 0) + 1;
        }
      }

      for (var value in secondchecklist.values) {
        // value의 첫 번째 항목(0번째)을 가져와서 countMap에 증가시킵니다.
        if (value.isNotEmpty) {
          int firstValue = int.parse(value[0]);
          countMap[firstValue] = (countMap[firstValue] ?? 0) + 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the number of columns based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final columnCount =
        (screenWidth / 150).floor(); // Adjust the item width (150) as needed
    // hive 에서 데이터 가져오기
    final firstQuestion =
        questionData.values.where((element) => element.type == 0).toList();
    final secondQuestion =
        questionData.values.where((element) => element.type == 1).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('임장 체크리스트 작성'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.houseName, // 앞에서 넘어온 값을 가지고 저장
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: Column(
                  children: [
                    // TODO 국가 주소 검색 연동
                    // Container(
                    //   alignment: Alignment.center,
                    //   child: Container(
                    //     child: TextButton(
                    //       onPressed: () async {
                    //         await Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (_) => KpostalView(
                    //               useLocalServer: false,
                    //               localPort: 1024,
                    //               kakaoKey: '3e4c0ecd981635225530d53ce9849ed9',
                    //               callback: (Kpostal result) {
                    //                 setState(() {
                    //                   postCode = result.postCode;
                    //                   address = result.address;
                    //                   latitude = result.latitude.toString();
                    //                   longitude = result.longitude.toString();
                    //                   kakaoLatitude =
                    //                       result.kakaoLatitude.toString();
                    //                   kakaoLongitude =
                    //                       result.kakaoLongitude.toString();
                    //                 });
                    //               },
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //       style: ButtonStyle(
                    //           backgroundColor: MaterialStateProperty.all<Color>(
                    //               Colors.blue)),
                    //       child: const Text(
                    //         'Search Address',
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const Text('매매금'),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            controller: priceFieldController,
                            textDirection: TextDirection.ltr,
                            decoration: const InputDecoration(
                              hintText: '매매금액 입력',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const Text('평형'),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            controller: sizeFieldController,
                            textDirection: TextDirection.ltr,
                            decoration: const InputDecoration(
                              hintText: '평형 입력',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const Text('방/화장실 갯수'),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            controller: structureFieldController,
                            textDirection: TextDirection.ltr,
                            decoration: const InputDecoration(
                              hintText: '방3 ',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {},
                    child: const Text(
                      '임장 날짜 등록',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Icon(
                Icons.sentiment_satisfied_alt_outlined,
                color: Colors.blue,
              ),
              Text(countMap[3].toString()),
              const SizedBox(
                width: 20,
              ),
              const Icon(
                Icons.sentiment_neutral_outlined,
                color: Colors.green,
              ),
              Text(countMap[2].toString()),
              const SizedBox(
                width: 20,
              ),
              const Icon(
                Icons.sentiment_dissatisfied_outlined,
                color: Colors.red,
              ),
              Text(countMap[1].toString()),
            ],
          ),
          Expanded(
            // 여기서 List를 gen할때 기존 데이터를 가져올때랑 아닐때를 나눠야함
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                ExpansionTile(
                  title: const Text('0. 임장전 체크리스트'),
                  initiallyExpanded: !expanded,
                  children: List.generate(
                    firstQuestion.length,
                    (index) => LoadCustomListTile(
                      index: firstQuestion[index].id + 1,
                      question: firstQuestion[index].name,
                      returnData: firstchecklist,
                      onPressed: () {
                        handleGrade();
                      },
                    ),
                  ),
                ),
                ExpansionTile(
                  initiallyExpanded: expanded,
                  title: const Text('1. 임장가서 체크리스트'),
                  children: List.generate(
                    secondQuestion.length,
                    (index) => LoadCustomListTile(
                      index: secondQuestion[index].id + 1,
                      question: secondQuestion[index].name,
                      returnData: secondchecklist,
                      onPressed: () {
                        setState(() {
                          handleGrade();
                        });
                      },
                    ),
                  ),
                ),
                // 찍은 사진들을 보여주는 widget
                // GridView.builder(
                //   itemCount: 6,
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: columnCount,
                //     crossAxisSpacing: 10,
                //     mainAxisSpacing: 10,
                //   ),
                //   shrinkWrap: true,
                //   itemBuilder: (context, index) {
                //     return Container(
                //       color: Colors.teal,
                //       child: Center(
                //         child: Text(
                //           'Item $index',
                //           style: const TextStyle(color: Colors.white),
                //         ),
                //       ),
                //     );
                //   },
                // ),

                // Save 버튼
                ElevatedButton(
                  onPressed: () {
                    houseData.put(
                        widget.houseName,
                        House(
                            name: widget.houseName,
                            address: '서울시 강남구',
                            price: priceFieldController.text,
                            size: sizeFieldController.text,
                            structure: structureFieldController.text,
                            description: '매매가능'));
                    // question과 house는 houseName이 key임
                    var firstChkList = <CheckList>[];
                    for (var key in firstchecklist.keys) {
                      firstChkList.add(CheckList(
                          address: widget.houseName,
                          type: 0,
                          questionId: int.parse(key),
                          answer: firstchecklist[key][0],
                          description: firstchecklist[key][1]));
                    }
                    var secondChkList = <CheckList>[];
                    for (var key in secondchecklist.keys) {
                      secondChkList.add(CheckList(
                          address: widget.houseName,
                          type: 1,
                          questionId: int.parse(key),
                          answer: secondchecklist[key][0],
                          description: secondchecklist[key][1]));
                    }

                    // 데이터 확인을 위한 print
                    print('save');
                    print('firstchecklist : $firstchecklist');
                    print('secondchecklist : $secondchecklist');
                    print('hive data!!!');
                    final chkList = checklistData.values.toList();
                    // CheckList 객체 출력
                    for (var checklist in chkList) {
                      print('Address: ${checklist.address}');
                      print('Type: ${checklist.type}');
                      print('Question ID: ${checklist.questionId}');
                      print('Answer: ${checklist.answer}');
                      print('Description: ${checklist.description}');
                      print('---');
                    }

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: const Text('저장하시겠습니까?'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Yes'),
                              onPressed: () {
                                // hive에 데이터 저장
                                for (var saveTobox in firstChkList) {
                                  checklistData.add(saveTobox);
                                }
                                for (var saveTobox in secondChkList) {
                                  checklistData.add(saveTobox);
                                }

                                final chkList = checklistData.values.toList();
                                print('save btn click');
                                // CheckList 객체 출력
                                for (var checklist in chkList) {
                                  print('Address: ${checklist.address}');
                                  print('Type: ${checklist.type}');
                                  print('Question ID: ${checklist.questionId}');
                                  print('Answer: ${checklist.answer}');
                                  print(
                                      'Description: ${checklist.description}');
                                  print('---');
                                }
                                Navigator.of(context).pop(); // Close the dialog
                                Navigator.of(context)
                                    .pop(); // Go back to the previous screen
                              },
                            ),
                            TextButton(
                              child: const Text('취소'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
          // 사진찍기 기능을 넣을 것!
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final picker = ImagePicker();
          final XFile? image =
              await picker.pickImage(source: ImageSource.gallery);
          print('image : $image');
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.photo_library_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
