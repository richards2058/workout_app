import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:workout_app/calendar/event.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime,List<Event>> _selectedEvents = {};
  TextEditingController _eventController = TextEditingController();
  @override

  void initState(){
    _selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay (DateTime date){
    return _selectedEvents[date] ?? [];
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Center(child: Text("Move It")),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            calendarFormat: format,
            focusedDay: _focusedDay,
            onFormatChanged: (CalendarFormat _format){
              setState(() {
                format = _format;
              });
            },

            daysOfWeekVisible: true,
            onDaySelected: (DateTime selectedDay, DateTime focusDay){
              setState(() {
                _selectedDate = selectedDay;
                _focusedDay = focusDay;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },

            eventLoader: _getEventsfromDay,
            weekendDays: [DateTime.sunday],
            calendarStyle: CalendarStyle(
              weekendTextStyle: TextStyle(color: Colors.red),
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(
                  color: Colors.blue.withOpacity(0.8),
                  spreadRadius: 3,
                  blurRadius: 5,
                )],
              ),
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true
            ),

            calendarBuilders: CalendarBuilders(
              dowBuilder: (context, day) {
                if (day.weekday == DateTime.sunday) {
                  return Center(
                    child: Text(
                      "Sun",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
              },

              markerBuilder: (context, date, event) {
                if (event.isNotEmpty){
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      shape: BoxShape.circle,
                      // color: Colors.blue,
                    ),
                    // color: Colors.blue,

                    width: 52,
                    height: 52,
                    // child: Center(
                    //   child: Text(
                    //     "wew",
                    //     style: TextStyle().copyWith(
                    //       color: Colors.white,
                    //       fontSize: 10.0,
                    //     ),
                    //   ),
                    // ),
                  );
                }
                return Container();
              },
            ),
          ),
          Container(
            child: Column(
              children: [..._getEventsfromDay(_selectedDate).map(
                    (Event event) => ListTile(
                  tileColor: Colors.red,
                  title: Text(event.title,),
                ),
              ),],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Add Event"),
            content: TextFormField(
              controller: _eventController,
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  if (_eventController.text.isEmpty) {

                  } else {
                    if (_selectedEvents[_selectedDate] != null) {
                      _selectedEvents[_selectedDate]!.add(
                        Event(title: _eventController.text),
                      );
                    } else {
                      _selectedEvents[_selectedDate] = [
                        Event(title: _eventController.text)
                      ];
                    }

                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState((){});
                  return;
                },
              ),
            ],
          ),
        ),
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
