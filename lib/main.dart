import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:wyeta/hive/checkList.dart';
import 'package:wyeta/hive/house.dart';
import 'package:wyeta/hive/question.dart';
import 'package:wyeta/hive/schedule.dart';

import '../../provider/provider.dart';
import 'widgets/mainPage.dart';

void main() async {
  await Hive.initFlutter();
  // Hive 모델 어댑터 등록
  Hive.registerAdapter(HouseAdapter());
  Hive.registerAdapter(ScheduleAdapter());
  Hive.registerAdapter(QuestionAdapter());
  Hive.registerAdapter(CheckListAdapter());
  final houseBox = await Hive.openBox<House>('house');
  final scheduleBox = await Hive.openBox<Schedule>('schedule');
  // Hive 박스 열기만 함!
  await Hive.openBox<Question>('question');
  await Hive.openBox<CheckList>('checkList');

// assets 폴더에서 JSON 파일을 읽어옴
  final String data = await rootBundle.loadString('assets/questionData.json');
  final List<dynamic> parsedData = json.decode(data);

  //처음에 insertBox 가 비어있으면 데이터를 넣어줌
  final insertBox = await Hive.openBox<Question>('question');
  if (insertBox.isEmpty) {
    insertBox.addAll(
      parsedData.map(
        (json) => Question(
          id: json['id'],
          type: json['type'],
          name: json['name'],
          description: json['description'],
        ),
      ),
    );
  }

  // DB 쿼리하고 싶은 위젯에서
  // 아래 명령어처럼 열어둔 box를 가져온 후 box변수를 가지고 쿼리 수행
  // final box = Hive.box<House>('house');

  houseBox.put('xi',
      House(name: 'xi', address: 'seoul mapogu', description: 'expensive'));
  houseBox.put('xi1',
      House(name: 'xi', address: 'seoul mapogu', description: 'expensive'));
  houseBox.put('xi2',
      House(name: 'xi', address: 'seoul mapogu', description: 'expensive'));
  houseBox.put('xi3',
      House(name: 'xi', address: 'seoul mapogu', description: 'expensive'));
  houseBox.put('xi4',
      House(name: 'xi', address: 'seoul mapogu', description: 'expensive'));
  houseBox.put('xi5',
      House(name: 'xi', address: 'seoul mapogu', description: 'expensive'));

  scheduleBox.put(
    DateTime.utc(2023, 8, 15).toString(),
    Schedule(
      date: DateTime.utc(2023, 8, 15),
      list: [
        House(
            name: 'xi', address: 'seoul mapogu', description: '내가 정말 가고 싶은 동네'),
        House(
            name: 'xi2',
            address: 'seoul mapogu2',
            description: '현실적으로 갈 수 있는 곳'),
        House(name: 'xi3', address: 'seoul mapogu3', description: '한번 구경해볼 집'),
      ],
    ),
  );
  scheduleBox.put(
    DateTime.utc(2023, 8, 24).toString(),
    Schedule(
      date: DateTime.utc(2023, 8, 24),
      list: [
        House(
          name: '궁궐',
          address: '서울시 강남구 1로',
          description: '여기 너무 살고 싶다 ㅠ',
        ),
        House(
            name: 'NineOne',
            address: '서울시 한남동',
            description: '지나가는길에 눈에 들어온 집'),
        House(
          name: '경복궁',
          address: '서울시 광화문로',
          description: '부동산에서 추천해 준 곳',
        ),
        House(
          name: 'ABc',
          address: '서울시 123로',
          description: '예비리스트',
        ),
        House(
          name: '123123',
          address: '서울시 B대로',
          description: '부예비리스트',
        ),
        House(
          name: '5555555555',
          address: '서울시 A대로',
          description: '예비리스트',
        ),
      ],
    ),
  );

  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GlobalValue>(create: (_) => GlobalValue())
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Page',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
