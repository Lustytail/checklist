import 'package:hive/hive.dart';

part 'house.g.dart';

// 수정하고 나면 터미널에서 아래 명령어 실행해야함
// flutter packages pub run build_runner build
// 그래야 XX.g.dart 파일이 빌드되면서 Adapter 반영됨

@HiveType(typeId: 0)
class House {
  @HiveField(0)
  String name;

  @HiveField(1)
  String address;

  @HiveField(2)
  String description;

  House(this.name, this.address, this.description);
}
