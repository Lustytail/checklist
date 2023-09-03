import 'package:hive/hive.dart';

part 'checkList.g.dart';

// 수정하고 나면 터미널에서 아래 명령어 실행해야함
// flutter packages pub run build_runner build
// 그래야 XX.g.dart 파일이 빌드되면서 Adapter 반영됨

@HiveType(typeId: 100)
class CheckList {
  @HiveField(0)
  String address;

  @HiveField(1)
  int questionId;

  @HiveField(2)
  String? answer;

  @HiveField(3)
  String? description;

  CheckList(
      {required this.address,
      required this.questionId,
      this.answer,
      this.description});
}
