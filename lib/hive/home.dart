import 'package:hive/hive.dart';
import 'dart:typed_data';

part 'home.g.dart';
// 수정하고 나면 터미널에서 아래 명령어 실행해야함
// flutter packages pub run build_runner build
// 그래야 XX.g.dart 파일이 빌드되면서 Adapter 반영됨

@HiveType(typeId: 201)
class Home {
  @HiveField(0)
  String name;

  @HiveField(1)
  String address;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? price;

  @HiveField(4)
  String? date;

  @HiveField(5)
  Uint8List? image;

  Home({
    required this.name,
    required this.address,
    this.description,
    this.price,
    this.date,
    this.image,
  });
}
