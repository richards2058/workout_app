import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/db/database_provider.dart';
import 'package:workout_app/db/models/calendarEvent.dart';
import 'package:workout_app/db/models/dog.dart';
import 'package:workout_app/db/database_provider.dart';

class dbPage extends StatefulWidget {
  @override
  _dbPageState createState() => _dbPageState();
}

class _dbPageState extends State<dbPage> {

  final textController = TextEditingController();
  TextEditingController _eventController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<calendarEvent>>(
        future: dbHelper.instance.getList(),
        builder: (BuildContext context, AsyncSnapshot<List<calendarEvent>> snapshot){
          if(!snapshot.hasData){
            return Center(child: Text("Loading..."));
          }
          return snapshot.data!.isEmpty?
              Center(child: Text('No Event'),)
              : ListView(
                children: snapshot.data!.map((calendarEvent){
                  return Center(
                    child: ListTile(
                      title: Text("${calendarEvent.id}\n${calendarEvent.dateTime}\n${calendarEvent.workoutPacket}"),
                      onLongPress: (){
                        setState(() {
                          dbHelper.instance.remove(calendarEvent.id!);
                        });
                      },
                    ),
                  );
                }).toList(),
          );
        },
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(top:  MediaQuery.of(context).size.height * 0.6),
        child: Column(
          children: [
            FloatingActionButton.extended(
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
                      onPressed: () async {
                        if (_eventController.text.isEmpty) {
                        } else {
                          await dbHelper.instance.add(
                            calendarEvent(dateTime: DateTime.now().toString(), workoutPacket: _eventController.text)

                          );
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
            FloatingActionButton.extended(
              onPressed: () async{
                await dbHelper.instance.dropTable();
                setState(() {
                });
              },

              label: Text("Drop Table"),
              icon: Icon(Icons.add),
            ),
            FloatingActionButton.extended(
              onPressed: () async{
                await dbHelper.instance.createTable();
                setState(() {
                });
              },

              label: Text("Create Table"),
              icon: Icon(Icons.add),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                setState(() {});
              },
              label: Text("Refresh"),
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
