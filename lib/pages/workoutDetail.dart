import 'package:flutter/material.dart';
import 'package:workout_app/components/CarouselSlide.dart';
import 'package:workout_app/components/centerButton.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WorkoutDetail extends StatefulWidget {
  final List exerciseList;

  const WorkoutDetail({Key? key, required this.exerciseList}) : super(key: key);



  @override
  State<WorkoutDetail> createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends State<WorkoutDetail> {

  CarouselController buttonCarouselController = CarouselController();
  String currentReps = "";

  @override
  void initState() {
    currentReps = widget.exerciseList[0]["reps"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CarouselSlider.builder(
                itemCount: widget.exerciseList.length,
                itemBuilder: (context, index, pageChanged){
                    return CarouselSlide(exList: widget.exerciseList[index]);
                },
              // carouselController: buttonCarouselController,
              options: CarouselOptions(
                height: double.infinity,
                enableInfiniteScroll: false,
                initialPage: 0,
                viewportFraction: 1,
                onPageChanged: (index, context){
                  currentReps = index.toString();
                  print(index);
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
                        onPressed: () {
                          buttonCarouselController.previousPage();
                        },
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
                          buttonCarouselController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
                        },
                      )
                    ],
                  ),
                  reuseableCenterButton(text: "Next", onPress: () {})
                ],
              )
          )
        ],
      ),
    );
  }
}
