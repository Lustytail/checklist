import 'package:hive/hive.dart';
import 'home.dart';
import 'dart:typed_data';

part 'homeList.g.dart';
// 수정하고 나면 터미널에서 아래 명령어 실행해야함
// flutter packages pub run build_runner build
// 그래야 XX.g.dart 파일이 빌드되면서 Adapter 반영됨

@HiveType(typeId: 202)
class HomeList {
  @HiveField(0)
  List<Home> homeList;

  HomeList({
    required this.homeList,
  });
}
