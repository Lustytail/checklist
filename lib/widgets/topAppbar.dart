import 'package:flutter/material.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Color.fromARGB(255, 231, 231, 231),
                size: 30,
              ),
              Text(
                'My GPS',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 231, 231, 231),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(),
        ),
        SizedBox(
          child: Row(
            children: [
              Icon(
                Icons.location_pin,
                color: Color.fromARGB(255, 231, 231, 231),
                size: 30,
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.list,
                color: Color.fromARGB(255, 231, 231, 231),
                size: 30,
              ),
            ],
          ),
        )
      ],
    );
  }
}
