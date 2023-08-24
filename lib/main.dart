import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wyeta/hive/house.dart';
import 'package:wyeta/hive/schedule.dart';
import 'widgets/mainPage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import '../../provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HouseAdapter());
  Hive.registerAdapter(ScheduleAdapter());
  final houseBox = await Hive.openBox<House>('house');
  final scheduleBox = await Hive.openBox<Schedule>('schedule');

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
        House(name: 'xi', address: 'seoul mapogu', description: 'hello test'),
        House(
            name: 'xi2', address: 'seoul mapogu2', description: 'hello test2'),
        House(
            name: 'xi3', address: 'seoul mapogu3', description: 'hello test3'),
      ],
    ),
  );
  scheduleBox.put(
    DateTime.utc(2023, 8, 24).toString(),
    Schedule(
      date: DateTime.utc(2023, 8, 24),
      list: [
        House(name: 'hey', address: 'seoul mapogu', description: 'hello test'),
        House(
            name: 'hey2', address: 'seoul mapogu2', description: 'hello test2'),
        House(
            name: 'hey3', address: 'seoul mapogu3', description: 'hello test3'),
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
