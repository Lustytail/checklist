import 'package:flutter/material.dart';

import 'calendar/calendarMenu.dart';
import 'calendar/calendarPage.dart';
import 'checklist/checklistMenu.dart';
import 'checklist/checklistPage.dart';
import 'home/homeMenu.dart';
import 'home/homePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1;

  final _topWidget = [
    const CalendarMenu(),
    const HomeMenu(),
    const ChecklistMenu(),
  ];

  final _bodyWidget = [
    const CalendarPage(),
    const HomePage(),
    const ChecklistPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(254, 254, 254, 254),
        title: _topWidget[_currentIndex],
      ),
      body: _bodyWidget[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(254, 254, 254, 254),
        selectedItemColor: const Color.fromARGB(222, 187, 187, 255),
        showUnselectedLabels: false,
        elevation: 5,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Checklist',
          ),
        ],
      ),
    );
  }
}
