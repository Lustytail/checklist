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
  ExpansionTileController controller = ExpansionTileController();

  void _toggleExpanded() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
              ),
              Text('매매금 '),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 80,
                child: TextField(
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: '전세금 입력',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextButton(
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Expanded(
                  child: ExpansionTile(
                    title: const Text('0. 임장전 체크리스트'),
                    onExpansionChanged: (value) {
                      _toggleExpanded();
                      if (controller.isExpanded) {
                        controller.collapse();
                      } else {
                        controller.expand();
                      }
                    },
                    initiallyExpanded: !expanded,
                    children: <Widget>[
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
                ),
                Expanded(
                  child: ExpansionTile(
                    controller: controller,
                    onExpansionChanged: (value) {
                      _toggleExpanded();
                    },
                    initiallyExpanded: expanded,
                    title: Text('1. 임장가서 체크리스트 $expanded'),
                    children: const <Widget>[
                      ListTile(title: Text('This is tile number 1')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
