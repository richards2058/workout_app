import 'package:flutter/material.dart';
import 'package:workout_app/components/CarouselSlide.dart';
import 'package:workout_app/components/centerButton.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:workout_app/pages/home.dart';
import 'package:workout_app/db/database_provider.dart';
import 'package:workout_app/db/models/calendarEvent.dart';
import 'dart:convert';
import 'package:workout_app/main.dart';

class WorkoutDetail extends StatefulWidget {
  final List exerciseList;
  final String packetName;

  const WorkoutDetail(
      {Key? key, required this.exerciseList, required this.packetName})
      : super(key: key);

  @override
  State<WorkoutDetail> createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends State<WorkoutDetail> {
  CarouselController buttonCarouselController = CarouselController();
  String currentReps = "";
  int _currentIndex = 0;

  Future<Null>? inputDB() async {
    final now = DateTime.now();
    final today = now
        .subtract(Duration(
          hours: now.hour,
          minutes: now.minute,
          seconds: now.second,
          milliseconds: now.millisecond,
          microseconds: now.microsecond,
        ))
        .toString();
    final String todayString = "${today}Z";
    String packets = "";
    Future<String> TodayPackets = dbHelper.instance.getToday(todayString);
    await TodayPackets.then((data) async {
      packets = data.toString();
      print(data);
      // List<String> packetList = (packets.substring(1, packets.length - 1)
      //     .split(', ')).toList();
      List<dynamic> packetList = json.decode(packets);
      print(packetList.length);

      if (packetList.isEmpty) {
        packetList = ["\"${widget.packetName}\""];
        // print(packetList.toString());
        await dbHelper.instance.add(calendarEvent(
            dateTime: todayString, workoutPacket: packetList.toString()));
      } else {
        // packetList = packetList["workoutPacket"];
        // packetList.forEach((element) {element = "\"${element}\""; print(element);});
        for (int i = 0; i < packetList.length; i++) {
          packetList[i] = "\"${packetList[i]}\"";
        }
        // print(packetList);
        packetList.add("\"${widget.packetName}\"");
        // print(packetList);
        await dbHelper.instance.updateData(calendarEvent(
            dateTime: todayString, workoutPacket: packetList.toString()));
      }
    });
  }

  @override
  void initState() {
    currentReps = widget.exerciseList[0]["reps"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Workout"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.exerciseList.map((itemIndicator) {
                int index = widget.exerciseList.indexOf(itemIndicator);
                return Expanded(
                  child: Container(
                    width: (double.infinity * 0.8) / widget.exerciseList.length,
                    height: 5.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2),
                    decoration: BoxDecoration(
                      color: _currentIndex == index ? Colors.blue : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: CarouselSlider.builder(
              itemCount: widget.exerciseList.length,
              itemBuilder: (context, index, pageChanged) {
                return CarouselSlide(exerciseData: widget.exerciseList[index]);
              },
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                height: double.infinity,
                enableInfiniteScroll: false,
                initialPage: 0,
                viewportFraction: 1,
                onPageChanged: (index, context) {
                  currentReps = widget.exerciseList[index]["reps"];
                  _currentIndex = index;
                  // print(index);
                  setState(() {});
                },
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(60, 0, 60, 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, -3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_left_rounded),
                        color: Colors.blue,
                        iconSize: 70,
                        onPressed: () =>
                            buttonCarouselController.previousPage(),
                      ),
                      Text(
                        currentReps,
                        style: TextStyle(fontSize: 30),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_right_rounded),
                        color: Colors.blue,
                        iconSize: 70,
                        onPressed: () {
                          buttonCarouselController.nextPage();
                        },
                      )
                    ],
                  ),
                  _currentIndex != widget.exerciseList.length - 1
                      ? reuseableCenterButton(
                          text: "Next",
                          onPress: () {
                            buttonCarouselController.nextPage();
                          })
                      : reuseableCenterButton(
                          text: "Finish",
                          onPress: () async {
                            await inputDB();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new Home()),
                                (route) => false);
                          })
                ],
              ))
        ],
      ),
    );
  }
}
