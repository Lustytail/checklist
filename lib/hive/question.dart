import 'package:hive/hive.dart';

part 'question.g.dart';

// 수정하고 나면 터미널에서 아래 명령어 실행해야함
// flutter packages pub run build_runner build
// 그래야 XX.g.dart 파일이 빌드되면서 Adapter 반영됨

@HiveType(typeId: 101)
class Question {
  @HiveField(0)
  int type;

  @HiveField(1)
  int id;

  @HiveField(2)
  String name;

  @HiveField(3)
  String? description;

  Question(
      {required this.type,
      required this.id,
      required this.name,
      this.description});
}
