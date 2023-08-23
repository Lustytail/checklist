import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wyeta/hive/house.dart';
import 'widgets/mainPage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import '../../provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HouseAdapter());
  final houseBox = await Hive.openBox<House>('house');

  // DB 쿼리하고 싶은 위젯에서
  // 아래 명령어처럼 열어둔 box를 가져온 후 box변수를 가지고 쿼리 수행
  // final box = Hive.box<House>('house');

  houseBox.put('xi', House('xi', 'seoul mapogu', 'expensive'));
  houseBox.put('xi2', House('xi2', 'seoul mapogu', 'expensive'));
  houseBox.put('xi3', House('xi3', 'seoul mapogu', 'expensive'));
  houseBox.put('xi4', House('xi4', 'seoul mapogu', 'expensive'));

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
