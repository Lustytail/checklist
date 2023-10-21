import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wyeta/hive/home.dart';
import 'package:wyeta/hive/homeList.dart';
import 'package:provider/provider.dart';
import 'package:wyeta/hive/checkList.dart';
import 'package:wyeta/hive/house.dart';
import 'package:wyeta/hive/question.dart';
import 'package:wyeta/hive/schedule.dart';
import 'package:wyeta/widgets/home/homState.dart';
import '../../provider/provider.dart';
import 'widgets/mainPage.dart';

void main() async {
  await Hive.initFlutter();
  // Hive 모델 어댑터 등록
  Hive.registerAdapter(HouseAdapter());
  Hive.registerAdapter(ScheduleAdapter());
  Hive.registerAdapter(QuestionAdapter());
  Hive.registerAdapter(CheckListAdapter());
  Hive.registerAdapter(HomeAdapter());
  Hive.registerAdapter(HomeListAdapter());
  final houseBox = await Hive.openBox<House>('house');
  final scheduleBox = await Hive.openBox<Schedule>('schedule');
  final homeBox = await Hive.openBox<Home>('home');
  final homeListBox = await Hive.openBox<HomeList>('homelist');
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

  int number = 1;
  List<Home> homeList = [];

  Future<Uint8List> readImageFile(String file) async {
    try {
      print("이미지 파일 가져오기");

      //앱 내부의 assets 폴더에 있는 파일을 경로로 참조하기 위해서는 package:flutter/services.dart 패키지의 rootBundle 객체를 사용하여 파일을 읽어야 합니다. Flutter에서는 assets 폴더의 파일은 빌드된 앱의 번들에 포함되므로 일반적인 파일 경로로 접근할 수 없습니다.
      final ByteData data = await rootBundle.load('assets/$file');
      Uint8List imageBytes = data.buffer.asUint8List();
      return imageBytes;
    } catch (e) {
      print('이미지 파일을 읽는 중 오류 발생: $e');
      // 오류 처리를 위해 null을 반환하거나 예외를 다시 던질 수 있습니다.
      rethrow;
    }
  }

  Future<void> savehome(String name, String address, String desc, String price,
      String file) async {
    print("처음 home hive 호출");
    Uint8List imageBytes = await readImageFile(file);

    Home home = Home(
      name: name,
      address: address,
      description: desc,
      price: price,
      image: imageBytes, // 이미지 데이터 설정
    );

    homeBox.put(number, home);
    homeList.add(home);
    print('number : $number');

    number = number + 1;
  }

  print("처음시작");
  await savehome(
      '이현민',
      '서울특별시 강서구',
      '세계문자 가운데 한글,즉 훈민정음은 흔히들 신비로운 문자라 부르곤 합니다. 그것은 세계 문자 가운데 유일하게 한글만이 그것을 만든 사람과 반포일을 알며, 글자를 만든 원리까지 알기 때문입니다. 세계에 이런 문자는 없습니다. 그래서 한글은, 정확히 말해 [훈민정음 해례본](국보 70호)은 진즉에 유네스코 세계기록유산으로 등재되었습니다. ‘한글’이라는 이름은 1910년대 초에 주시경 선생을 비롯한 한글학자들이 쓰기 시작한 것입니다. 여기서 ‘한’이란 크다는 것을 뜻하니, 한글은 ‘큰 글’을 말한다고 하겠습니다.[네이버 지식백과] 한글 - 세상에서 가장 신비한 문자 (위대한 문화유산, 최준식)',
      '10억',
      'background.jpg');
  await savehome(
      '이수민',
      '서울특별시 강남구',
      '세계문자 가운데 한글,즉 훈민정음은 흔히들 신비로운 문자라 부르곤 합니다. 그것은 세계 문자 가운데 유일하게 한글만이 그것을 만든 사람과 반포일을 알며, 글자를 만든 원리까지 알기 때문입니다. 세계에 이런 문자는 없습니다. 그래서 한글은, 정확히 말해 [훈민정음 해례본](국보 70호)은 진즉에 유네스코 세계기록유산으로 등재되었습니다. ‘한글’이라는 이름은 1910년대 초에 주시경 선생을 비롯한 한글학자들이 쓰기 시작한 것입니다. 여기서 ‘한’이란 크다는 것을 뜻하니, 한글은 ‘큰 글’을 말한다고 하겠습니다.[네이버 지식백과] 한글 - 세상에서 가장 신비한 문자 (위대한 문화유산, 최준식)',
      '5억',
      'background1.jpg');
  await savehome(
      '이민수',
      '서울특별시 강북구',
      '세계문자 가운데 한글,즉 훈민정음은 흔히들 신비로운 문자라 부르곤 합니다. 그것은 세계 문자 가운데 유일하게 한글만이 그것을 만든 사람과 반포일을 알며, 글자를 만든 원리까지 알기 때문입니다. 세계에 이런 문자는 없습니다. 그래서 한글은, 정확히 말해 [훈민정음 해례본](국보 70호)은 진즉에 유네스코 세계기록유산으로 등재되었습니다. ‘한글’이라는 이름은 1910년대 초에 주시경 선생을 비롯한 한글학자들이 쓰기 시작한 것입니다. 여기서 ‘한’이란 크다는 것을 뜻하니, 한글은 ‘큰 글’을 말한다고 하겠습니다.[네이버 지식백과] 한글 - 세상에서 가장 신비한 문자 (위대한 문화유산, 최준식)',
      '6억',
      'background2.jpg');
  await savehome(
      '이새봄',
      '서울특별시 강동구',
      '세계문자 가운데 한글,즉 훈민정음은 흔히들 신비로운 문자라 부르곤 합니다. 그것은 세계 문자 가운데 유일하게 한글만이 그것을 만든 사람과 반포일을 알며, 글자를 만든 원리까지 알기 때문입니다. 세계에 이런 문자는 없습니다. 그래서 한글은, 정확히 말해 [훈민정음 해례본](국보 70호)은 진즉에 유네스코 세계기록유산으로 등재되었습니다. ‘한글’이라는 이름은 1910년대 초에 주시경 선생을 비롯한 한글학자들이 쓰기 시작한 것입니다. 여기서 ‘한’이란 크다는 것을 뜻하니, 한글은 ‘큰 글’을 말한다고 하겠습니다.[네이버 지식백과] 한글 - 세상에서 가장 신비한 문자 (위대한 문화유산, 최준식)',
      '7억',
      'background3.jpg');

  print("처음시작");
  if (homeList.isNotEmpty) {
    homeListBox.put("1", HomeList(homeList: homeList));
  }

  print("종료");

  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<GlobalValue>(
            create: (_) => GlobalValue(),
          ),
          ChangeNotifierProvider<HomeState>(
            create: (_) => HomeState(),
          ),
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
