import 'package:flutter/material.dart';
import 'package:workout_app/calendar/event.dart';
import 'package:workout_app/db/models/calendarEvent.dart';
class CalendarDetail extends StatefulWidget {
  
  DateTime selectedDate;
  List<Event> calendarEvent;

  CalendarDetail({Key? key,required this.selectedDate, required this.calendarEvent}) : super(key: key);

  @override
  State<CalendarDetail> createState() => _CalendarDetailState();
}

class _CalendarDetailState extends State<CalendarDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Center(child: Text(widget.selectedDate.toString())),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: widget.calendarEvent.length,
            itemBuilder: (context, index){
              return Text(widget.calendarEvent[index].title);
        }),
      ),
    );
  }
}
