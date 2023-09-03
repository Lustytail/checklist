import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// 전역 변수 설정하는 곳
// 사용방법 : context.read<GlobalValue>().str
//                          클래스명     getter 함수명
class GlobalValue extends ChangeNotifier {
  final String _str = "test";
  String get str => _str;

  DateTime date = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
}
