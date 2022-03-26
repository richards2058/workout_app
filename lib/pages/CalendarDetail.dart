import 'package:flutter/material.dart';
import 'package:workout_app/calendar/event.dart';
import 'package:workout_app/components/centerButton.dart';
import 'package:intl/intl.dart';

class CalendarDetail extends StatefulWidget {
  DateTime selectedDate;
  List<Event> calendarEvent;

  CalendarDetail(
      {Key? key, required this.selectedDate, required this.calendarEvent})
      : super(key: key);

  @override
  State<CalendarDetail> createState() => _CalendarDetailState();
}

class _CalendarDetailState extends State<CalendarDetail> {
  final _blueTextStyle = const TextStyle(
      color: Colors.blueAccent, fontSize: 20, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Calendar"),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        reuseableCenterButton(
                            text: DateFormat("EEEE, dd MMMM yyyy")
                                .format(widget.selectedDate),
                            padding: EdgeInsets.symmetric(
                                vertical: 25, horizontal: 10),
                            onPress: () {}),
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: widget.calendarEvent.length == 0
                                ? Text("No workout completed",
                                    style: _blueTextStyle)
                                : Text(
                                    "Congrats! You’ve completed the workout!",
                                    style: _blueTextStyle)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.calendarEvent.length,
                itemBuilder: (context, index) {
                  // Text(widget.calendarEvent[index].title);
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: (reuseableCenterButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        text: widget.calendarEvent[index].title,
                        onPress: () {})),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
