import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wyeta/hive/schedule.dart';

import '../../hive/house.dart';
import 'scheduleModal.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<StatefulWidget> createState() => _CalenarState();
}

class _CalenarState extends State<CalendarPage> {
  final box = Hive.box<Schedule>('schedule');
  late DateTime selectedDay;
  late DateTime focusedDay;
  List<House> todaySchedules = [];

  final List<DateTime> _hoildays = [DateTime.utc(2023, 8, 15)];

  @override
  void initState() {
    DateTime date = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    selectedDay = date;
    focusedDay = date;

    super.initState();
  }

  List<House> _getSchedules(DateTime day) {
    var temp = box.get(day.toString());
    return temp?.list ?? [];
  }

// 미사용중인 메서드
  void popUp() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // contentPadding: const EdgeInsets.symmetric(
          //   vertical: 5,
          //   horizontal: 5,
          // ),
          title: Container(
            alignment: Alignment.center,
            child: const Text('임장 계획 리스트'),
          ),
          content: Container(
            width: 400,
            height: 450,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
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
                          margin: const EdgeInsets.symmetric(
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color.fromARGB(255, 175, 240, 178),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 90,
                                height: 90,
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
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        // 임장 계획 - 주소
                                        house.address,
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 132, 132, 132),
                                          fontSize: 12,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          // 임장 계획 - 설명
                                          house.description ?? '',
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
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
        );
      },
    );
  }

  void showModal() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return ScheduleList(todaySchedules: todaySchedules);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!box.get(selectedDay.toString()).isNull) {
      todaySchedules = box.get(selectedDay.toString())!.list!;
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: TableCalendar(
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                headerPadding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
              ),
              calendarStyle: CalendarStyle(
                defaultTextStyle: const TextStyle(
                  color: Colors.grey,
                ),
                weekendTextStyle: const TextStyle(
                  color: Colors.red,
                ),
                holidayTextStyle: const TextStyle(
                  color: Colors.red,
                ),
                holidayDecoration: const BoxDecoration(),
                todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 2),
                ),
                todayTextStyle: const TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.w800,
                ),
                selectedDecoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.indigo,
                ),
                selectedTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                markersMaxCount: 1,
                markerDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              locale: 'ko-KR',
              firstDay: DateTime.utc(2021, 1, 1),
              lastDay: DateTime.utc(2060, 12, 31),
              daysOfWeekHeight: 25,
              rowHeight: 50,
              focusedDay: selectedDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(
                  () {
                    if (this.selectedDay == selectedDay) {
                      //popUp();
                      showModal();
                    } else {
                      this.selectedDay = selectedDay;
                      this.focusedDay = focusedDay;

                      if (!box.get(selectedDay.toString()).isNull) {
                        todaySchedules = box.get(selectedDay.toString())!.list!;
                      } else {
                        todaySchedules = [];
                      }
                    }
                  },
                );
              },
              selectedDayPredicate: (day) {
                return isSameDay(selectedDay, day);
              },
              eventLoader: _getSchedules,
              holidayPredicate: (day) {
                return _hoildays.contains(day) ? true : false;
              },
            ),
          ),
        ],
      ),
    );
  }
}
