import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wyeta/hive/schedule.dart';

import '../../hive/house.dart';
import '../../provider/provider.dart';
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

  final List<DateTime> _hoildays = [DateTime.utc(2023, 8, 15)];

  @override
  void initState() {
    selectedDay = context.read<GlobalValue>().date;
    focusedDay = context.read<GlobalValue>().date;

    super.initState();
  }

  List<House> _getSchedules(DateTime day) {
    var temp = box.get(day.toString());
    return temp?.list ?? [];
  }

  void showModal() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter bottomState) {
            return ScheduleList(
                selectedDay: selectedDay, bottomState: bottomState);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
