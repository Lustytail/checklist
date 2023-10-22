import 'package:flutter/material.dart';

class CustomizeWidget extends StatefulWidget {
  String text;
  Color color;

  CustomizeWidget({super.key, required this.text, required this.color});

  @override
  State<CustomizeWidget> createState() => _CustomizeWidgetState();
}

class _CustomizeWidgetState extends State<CustomizeWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.text,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
