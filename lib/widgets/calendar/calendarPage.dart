import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wyeta/hive/schedule.dart';

import '../../hive/house.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<StatefulWidget> createState() => _CalenarState();
}

class _CalenarState extends State<CalendarPage> {
  final box = Hive.box<Schedule>('schedule');
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  List<House> todaySchedules = [];

  final List<DateTime> _hoildays = [DateTime.utc(2023, 8, 15)];

  List<House> _getSchedules(DateTime day) {
    var temp = box.get(day.toString());
    return temp?.list ?? [];
  }

  List<Widget> getScheduleList() {
    List<Widget> list = [];

    for (var house in todaySchedules) {
      list.add(Text(
        '이름 : ${house.name} / 주소 : ${house.address} / 메모 : ${house.description}',
      ));
    }
    return list;
  }

  @override
  void initState() {
    String date = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).toString();

    if (!box.get(date)!.list.isNull) {
      todaySchedules = box.get(date)!.list!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!box.get(selectedDay.toString()).isNull) {
      todaySchedules = box.get(selectedDay.toString())!.list!;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: TableCalendar(
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
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
              lastDay: DateTime.utc(2030, 12, 31),
              daysOfWeekHeight: 25,
              rowHeight: 50,
              focusedDay: selectedDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(
                  () {
                    this.selectedDay = selectedDay;
                    this.focusedDay = focusedDay;

                    if (!box.get(selectedDay.toString()).isNull) {
                      todaySchedules = box.get(selectedDay.toString())!.list!;
                    } else {
                      todaySchedules = [];
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
          Column(
            // 리스트를 wiget형태로 출력하는 방법
            children: todaySchedules
                .map(
                  (house) => Text(
                    '이름 : ${house.name} / 주소 : ${house.address} / 메모 : ${house.description}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
