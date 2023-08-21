import 'package:flutter/material.dart';
import 'location/testPage.dart';
import 'location/topAppbar.dart';
import 'setting/settingPage.dart';
import 'setting/topMenu.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final _topWidget = [
    const TopBarWidget(),
    const SettingMenu(),
  ];

  final _bodyWidget = [
    const TestPage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 101, 101, 101),
        title: _topWidget[_currentIndex],
      ),
      body: _bodyWidget[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 101, 101, 101),
        selectedItemColor: const Color.fromARGB(222, 187, 187, 255),
        showUnselectedLabels: false,
        elevation: 5,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_pin),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
