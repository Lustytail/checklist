import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wyeta/hive/home.dart';
import 'package:wyeta/hive/homeList.dart';

//20231021
class HomeState extends ChangeNotifier {
  List<Home> homeList = [];

  void addHome(Home home) {
    homeList.add(home);
    notifyListeners(); // Notify listeners when the state changes
  }

  void removeHome(Home home) {
    homeList.remove(home);

    notifyListeners();
  }

  void helloTest() {
    print("hello test");

    notifyListeners();
  }

  void deleteHome(Home home) {
    print("HomeState 호출");
    var homeListBox = Hive.box<HomeList>('homeList');
    var homeBox = Hive.box<Home>('home');
    // 홈 데이터 삭제
    int index = homeBox.keys.cast<int>().firstWhere(
          (key) => homeBox.get(key) == home,
          orElse: () => -1,
        );
    print(index);

    if (index != -1) {
      homeBox.delete(index);
    }

    // 업데이트된 홈 데이터 목록을 가져옴
    List<Home> updatedHomeList = homeBox.values.toList();

    // homeListBox의 homeList 업데이트
    homeListBox.put(
      "1",
      HomeList(homeList: updatedHomeList),
    );

    // 상태 업데이트
    notifyListeners();
  }
}
