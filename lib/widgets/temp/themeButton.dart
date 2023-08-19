// ignore: file_names
import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/material.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({super.key});

  @override
  State<StatefulWidget> createState() => ThemeModeState();
}

class ThemeModeState extends State<ThemeButton>
    with SingleTickerProviderStateMixin {
  bool val = false;
  late AnimationController _controller;
  late Size size;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(
          height: 80,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: DayNightSwitch(
                value: val,
                onChanged: (value) {
                  setState(() {
                    val = value;
                  });
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
