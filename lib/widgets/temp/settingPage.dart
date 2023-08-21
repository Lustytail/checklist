import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SettingContainer(),
          SettingContainer(),
          SettingContainer(),
          SettingContainer(),
          SettingContainer(),
          SettingContainer(),
          SettingContainer(),
          SettingContainer(),
          SettingContainer(),
          SettingContainer(),
          SettingContainer(),
          SettingContainer(),
          SettingContainer(),
        ],
      ),
    );
  }
}

class SettingContainer extends StatelessWidget {
  const SettingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 229, 229, 229),
        border: Border.all(
          style: BorderStyle.solid,
          color: Colors.black,
          width: 0.1,
        ),
        // boxShadow: const [   // 컨테이너 그림자 설정
        //   BoxShadow(
        //     color: Colors.grey,
        //     blurRadius: 2.0,
        //     spreadRadius: 1.0,
        //     offset: Offset(
        //       1,
        //       1,
        //     ),
        //   )
        // ],
      ),
      height: 70,
    );
  }
}
