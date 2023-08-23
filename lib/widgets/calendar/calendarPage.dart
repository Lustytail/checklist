import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<StatefulWidget> createState() => _CalenarState();
}

//sdfsdfsd
class _CalenarState extends State<CalendarPage> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  Map<DateTime, List<Event>> events = {
    DateTime.utc(2023, 8, 25): [Event('title'), Event('title2')],
    DateTime.utc(2023, 8, 15): [Event('title3')],
  };

  final List<DateTime> _hoildays = [DateTime.utc(2023, 8, 15)];

  List<Event> _getEvents(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
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
              daysOfWeekHeight: 30,
              focusedDay: selectedDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(
                  () {
                    this.selectedDay = selectedDay;
                    this.focusedDay = focusedDay;
                  },
                );
              },
              selectedDayPredicate: (day) {
                return isSameDay(selectedDay, day);
              },
              eventLoader: _getEvents,
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

class Event {
  String title;
  String? description;

  Event(this.title, {this.description});
}
