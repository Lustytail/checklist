import 'package:flutter/material.dart';

class FilledButtons extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final bool isSelected;

  const FilledButtons({
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  _FilledButtonsState createState() => _FilledButtonsState();
}

class _FilledButtonsState extends State<FilledButtons> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onPressed(); // 원래의 onPressed 콜백 호출

        // 버튼 상태에 따라 배경 색상 변경
        final Color backgroundColor =
            widget.isSelected ? widget.backgroundColor : Colors.blueGrey;

        ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // 배경 색상 변경
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.isSelected
            ? widget.backgroundColor
            : Colors.blueGrey, // 초기 배경 색상 설정
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              30), // Adjust the radius for rounded corners
        ),
      ),
      child: widget.child,
    );
  }
}
