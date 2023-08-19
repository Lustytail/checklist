import 'package:flutter/material.dart';
import 'package:wyeta/widgets/bottomAppbar.dart';
import 'widgets/testpage.dart';
import 'widgets/temp/themeButton.dart';
import 'widgets/topAppbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Page',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 101, 101, 101),
        title: const TopBarWidget(),
      ),
      body: const TestPage(),
      bottomNavigationBar: const BottomAppBar(
        height: 50,
        color: Color.fromARGB(255, 101, 101, 101),
        child: BottomBarWidget(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Add my ETA',
      //   backgroundColor: const Color.fromARGB(222, 144, 144, 202),
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
