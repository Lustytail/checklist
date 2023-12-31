import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../hive/house.dart';
import '../../hive/schedule.dart';
import '../../provider/provider.dart';
import '../checklist/checklistWrite.dart';

class ScheduleList extends StatefulWidget {
  final StateSetter bottomState;
  final DateTime selectedDay;

  const ScheduleList(
      {super.key, required this.selectedDay, required this.bottomState});

  @override
  State<StatefulWidget> createState() => _ScheduleState();
}

class _ScheduleState extends State<ScheduleList> {
  final box = Hive.box<Schedule>('schedule');
  List<House> todaySchedules = [];

  @override
  void initState() {
    if (box.get(widget.selectedDay.toString())?.list == null) {
      todaySchedules = [];
    } else {
      todaySchedules = box.get(widget.selectedDay.toString())!.list!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450, // 모달 높이 크기
      child: Container(
        // width: 400,
        // height: 450,
        margin: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'tests',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Flexible(fit: FlexFit.tight, child: SizedBox()),
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChecklistWrite(
                                  date: context.read<GlobalValue>().date),
                            ),
                          );

                          widget.bottomState(() {
                            todaySchedules =
                                box.get(widget.selectedDay.toString())!.list!;
                          });
                        },
                        child: const Icon(Icons.add, size: 40),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: todaySchedules
                      .map(
                        (house) => GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CreateSchedule(),
                            ),
                          ),
                          child: Container(
                            color: Colors.transparent,
                            margin: const EdgeInsets.symmetric(
                              vertical: 3,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 5,
                            ),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                  // 이미지 블록
                                  alignment: Alignment.center,
                                  width: 70,
                                  height: 70,
                                  color: Colors.blueGrey,
                                  child: const Text('IMAGE???'),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          // 임장 계획 - 이름
                                          house.name,
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 51, 51, 51),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          // 임장 계획 - 주소
                                          house.address,
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 132, 132, 132),
                                            fontSize: 10,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: Text(
                                            // 임장 계획 - 설명
                                            house.description ?? '',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 102, 102, 102),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateSchedule extends StatelessWidget {
  const CreateSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('testset'),
    );
  }
}
