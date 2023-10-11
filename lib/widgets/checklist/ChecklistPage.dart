import 'package:flutter/material.dart';
import 'package:wyeta/widgets/checklist/checklistLoad.dart';
import 'package:wyeta/widgets/checklist/checklistWrite.dart';
import 'package:wyeta/widgets/common/searchAddressState.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  @override
  late Map<String, dynamic> address = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChecklistWrite()),
            );
          },
          child: const Text(
            'Go Write Checklist',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const ChecklistLoad(houseName: 'sungwon')),
            );
          },
          child: const Text(
            '트리마제 305동 3901호',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final value = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SearchAddressState()),
            );

            if (value != null) {
              setState(() {
                address =
                    value; // Update the selectedValue with the returned value
              });
            }
            print(address);
          },
          child: Text(
            address['roadAddr'] ?? "주소 검색",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
