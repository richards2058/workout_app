import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:workout_app/calendar/event.dart';
import 'package:workout_app/db/database_provider.dart';
import 'package:workout_app/db/models/calendarEvent.dart';
import 'package:workout_app/pages/CalendarDetail.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class Calendar extends StatefulWidget {



  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  String eventDate = "";
  dynamic events;
  Map<DateTime, List<Event>> _selectedEvents = {};
  final TextEditingController _eventController = TextEditingController();
  Map<DateTime, List<Event>> _eventFalseMemory = {};

  Future<void> readJson() async {
    _selectedEvents = {};
    Future<List<calendarEvent>> calenderEventList = dbHelper.instance.getList();

    calenderEventList.then((data) => {
          data.forEach((e) {
            DateTime date = DateTime.parse(e.dateTime);
            List<dynamic> packets = json.decode(e.workoutPacket);
            // List<dynamic> packets = (e.workoutPacket
            //     .substring(1, e.workoutPacket.length - 1)
            //     .split(', '));
            // print(packets);
            packets.forEach((p) {
              Event packet = Event(title: p);
              if (_selectedEvents[date] != null) {
                _selectedEvents[date]?.add(packet);
              } else {
                _selectedEvents[date] = [packet];
              }
            });
          })
        });
    setState(() {});
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return _selectedEvents[date] ?? [];
  }

  @override
  void initState() {
    _selectedEvents = {};
    super.initState();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(child: Text("Move It")),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: readJson(),
              builder: (context, snapshot){
                return TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  calendarFormat: format,
                  focusedDay: _focusedDay,
                  onFormatChanged: (CalendarFormat _format) {
                    setState(() {
                      format = _format;
                    });
                  },
                  daysOfWeekVisible: true,
                  onDaySelected: (DateTime selectedDay, DateTime focusDay) async {
                    // setState(() {
                      _selectedDate = selectedDay;
                      _focusedDay = focusDay;
                    // });
                    await Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new CalendarDetail(
                              calendarEvent: _getEventsfromDay(_selectedDate),
                              selectedDate: _selectedDate,
                            )));
                    setState(() {});
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDate, day);
                  },
                  eventLoader: _getEventsfromDay,
                  weekendDays: const [DateTime.sunday],
                  calendarStyle: CalendarStyle(
                    weekendTextStyle: TextStyle(color: Colors.red),
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.8),
                          spreadRadius: 3,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle:
                  HeaderStyle(formatButtonVisible: false, titleCentered: true),
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
                      return null;
                    },
                    markerBuilder: (context, date, event) {
                      if (event.isNotEmpty) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            shape: BoxShape.circle,
                          ),
                          width: 52,
                          height: 52,
                        );
                      }
                      return Container();
                    },
                  ),
                );
              }),
          // Container(
          //   child: TableCalendar(
          //     firstDay: DateTime.utc(2010, 10, 16),
          //     lastDay: DateTime.utc(2030, 3, 14),
          //     calendarFormat: format,
          //     focusedDay: _focusedDay,
          //     onFormatChanged: (CalendarFormat _format) {
          //       setState(() {
          //         format = _format;
          //       });
          //     },
          //     daysOfWeekVisible: true,
          //     onDaySelected: (DateTime selectedDay, DateTime focusDay) {
          //       setState(() {
          //         _selectedDate = selectedDay;
          //         _focusedDay = focusDay;
          //       });
          //       Navigator.push(
          //           context,
          //           new MaterialPageRoute(
          //               builder: (BuildContext context) => new CalendarDetail(
          //                     calendarEvent: _getEventsfromDay(_selectedDate),
          //                     selectedDate: _selectedDate,
          //                   )));
          //     },
          //     selectedDayPredicate: (day) {
          //       return isSameDay(_selectedDate, day);
          //     },
          //     eventLoader: _getEventsfromDay,
          //     weekendDays: const [DateTime.sunday],
          //     calendarStyle: CalendarStyle(
          //       weekendTextStyle: TextStyle(color: Colors.red),
          //       isTodayHighlighted: true,
          //       selectedDecoration: BoxDecoration(
          //         color: Colors.blue,
          //         shape: BoxShape.circle,
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.blue.withOpacity(0.8),
          //             spreadRadius: 3,
          //             blurRadius: 5,
          //           )
          //         ],
          //       ),
          //       todayDecoration: BoxDecoration(
          //         color: Colors.blue,
          //         shape: BoxShape.circle,
          //       ),
          //     ),
          //     headerStyle:
          //         HeaderStyle(formatButtonVisible: false, titleCentered: true),
          //     calendarBuilders: CalendarBuilders(
          //       dowBuilder: (context, day) {
          //         if (day.weekday == DateTime.sunday) {
          //           return Center(
          //             child: Text(
          //               "Sun",
          //               style: TextStyle(color: Colors.red),
          //             ),
          //           );
          //         }
          //       },
          //       markerBuilder: (context, date, event) {
          //         if (event.isNotEmpty) {
          //           return Container(
          //             decoration: BoxDecoration(
          //               border: Border.all(color: Colors.blue, width: 2),
          //               shape: BoxShape.circle,
          //             ),
          //             width: 52,
          //             height: 52,
          //           );
          //         }
          //         return Container();
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () => showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: Text("Add Event"),
      //       content: TextFormField(
      //         controller: _eventController,
      //       ),
      //       actions: [
      //         TextButton(
      //           child: Text("Cancel"),
      //           onPressed: () => Navigator.pop(context),
      //         ),
      //         TextButton(
      //           child: Text("Ok"),
      //           onPressed: () async {
      //             eventDate = _selectedDate.toString();
      //
      //             if (_eventController.text.isEmpty) {
      //             } else {
      //               _eventFalseMemory = _selectedEvents;
      //
      //               if (_selectedEvents[_selectedDate] != null) {
      //                 //update
      //                 _eventFalseMemory[_selectedDate]!.add(
      //                   Event(title: _eventController.text),
      //                 );
      //                 events = _eventFalseMemory[_selectedDate];
      //                 await dbHelper.instance.updateData(calendarEvent(
      //                     dateTime: eventDate,
      //                     workoutPacket: events.toString()));
      //               } else {
      //                 //buat baru
      //                 _eventFalseMemory[_selectedDate] = [
      //                   Event(title: _eventController.text)
      //                 ];
      //                 events = _selectedEvents[_selectedDate];
      //                 await dbHelper.instance.add(calendarEvent(
      //                     dateTime: eventDate,
      //                     workoutPacket: events.toString()));
      //               }
      //             }
      //
      //             Navigator.pop(context);
      //             _eventController.clear();
      //             setState(() {});
      //             return;
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      //   label: Text("Add Event"),
      //   icon: Icon(Icons.add),
      // ),
    );
  }
}
