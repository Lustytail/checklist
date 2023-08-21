import 'package:flutter/material.dart';

import 'calendar/calendarMenu.dart';
import 'calendar/calendarPage.dart';
import 'checklist/ChecklistPage.dart';
import 'checklist/checklistMenu.dart';
import 'home/homeMenu.dart';
import 'home/homePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1;
  final PageController _pageController = PageController(
    initialPage: 1,
  );

  final _topWidget = [
    const CalendarMenu(),
    const HomeMenu(),
    const ChecklistMenu(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 101, 101, 101),
        title: _topWidget[_currentIndex],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
        children: const <Widget>[
          CalendarPage(),
          HomePage(),
          ChecklistPage(),
          // Add other pages
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 101, 101, 101),
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
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
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
