import 'package:hive/hive.dart';

import 'house.dart';

part 'schedule.g.dart';

// 수정하고 나면 터미널에서 아래 명령어 실행해야함
// flutter packages pub run build_runner build
// 그래야 XX.g.dart 파일이 빌드되면서 Adapter 반영됨

@HiveType(typeId: 1)
class Schedule extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  List<House>? list;

  Schedule({required this.date, this.list});
}
