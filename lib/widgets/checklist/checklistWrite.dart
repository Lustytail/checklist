import 'package:flutter/material.dart';

import 'customListTile.dart';

class ChecklistWrite extends StatefulWidget {
  const ChecklistWrite({super.key});

  @override
  State<ChecklistWrite> createState() => _ChecklistWriteState();
}

class _ChecklistWriteState extends State<ChecklistWrite> {
  String postCode = '-';
  String address = '-';
  String latitude = '-';
  String longitude = '-';
  String kakaoLatitude = '-';
  String kakaoLongitude = '-';
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    // Calculate the number of columns based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final columnCount =
        (screenWidth / 150).floor(); // Adjust the item width (150) as needed
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          const Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                '은마아파트(앞에서 전달)',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: Column(
                  children: [
                    /* TODO 국가 주소 검색 연동
                        Container(
                          alignment: Alignment.center,
                          child: Container(
                child: TextButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => KpostalView(
                          useLocalServer: true,
                          localPort: 1024,
                          // kakaoKey: '{Add your KAKAO DEVELOPERS JS KEY}',
                          callback: (Kpostal result) {
                            setState(() {
                              postCode = result.postCode;
                              address = result.address;
                              latitude = result.latitude.toString();
                              longitude = result.longitude.toString();
                              kakaoLatitude = result.kakaoLatitude.toString();
                              kakaoLongitude = result.kakaoLongitude.toString();
                            });
                          },
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue)),
                  child: const Text(
                    'Search Address',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                          ),
                        ),*/
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text('매매금'),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
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
                        SizedBox(
                          width: 20,
                        ),
                        Text('평형'),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
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
                        SizedBox(
                          width: 20,
                        ),
                        Text('방/화장실 갯수'),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
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
          const Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.sentiment_satisfied_alt_outlined,
                color: Colors.blue,
              ),
              Text("11"),
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.sentiment_neutral_outlined,
                color: Colors.green,
              ),
              Text("12"),
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.sentiment_dissatisfied_outlined,
                color: Colors.red,
              ),
              Text("1"),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                ExpansionTile(
                  title: const Text('0. 임장전 체크리스트'),
                  initiallyExpanded: !expanded,
                  children: <Widget>[
                    const CustomListTile(),
                    const CustomListTile(),
                    const CustomListTile(),
                    const CustomListTile(),
                    const CustomListTile(),
                    const CustomListTile(),
                    const CustomListTile(),
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('2. 주택의 규모는?'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FilledButton(
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Colors.blue),
                                  ),
                                  onPressed: () {},
                                  child: const Text('좋아요')),
                              FilledButton(
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Colors.green),
                                  ),
                                  onPressed: () {},
                                  child: const Text('보통이에요')),
                              FilledButton(
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Colors.red),
                                  ),
                                  onPressed: () {
                                    print('나빠요');
                                  },
                                  child: const Text('나빠요')),
                            ],
                          ),
                          const TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '간단한 메모',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  initiallyExpanded: expanded,
                  title: const Text('1. 임장가서 체크리스트'),
                  children: const <Widget>[
                    CustomListTile(),
                  ],
                ),
                GridView.builder(
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columnCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.teal,
                      child: Center(
                        child: Text(
                          'Item $index',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // 사진찍기 기능을 넣을 것!
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your button action here
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.camera_alt_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
