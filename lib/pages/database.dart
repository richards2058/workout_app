import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/db/database_provider.dart';
import 'package:workout_app/db/models/dog.dart';

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
      body: FutureBuilder<List<Dog>>(
        future: dbHelper.instance.getList(),
        builder: (BuildContext context, AsyncSnapshot<List<Dog>> snapshot){
          if(!snapshot.hasData){
            return Center(child: Text("Loading..."));
          }
          return snapshot.data!.isEmpty?
              Center(child: Text('No Dogs'),)
              : ListView(
                children: snapshot.data!.map((dog){
                  return Center(
                    child: ListTile(
                      title: Text(dog.name),
                      onLongPress: (){
                        setState(() {
                          dbHelper.instance.remove(dog.id!);
                        });
                      },
                    ),
                  );
                }).toList(),
          );
        },
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
                onPressed: () async {
                  if (_eventController.text.isEmpty) {
                  } else {
                    await dbHelper.instance.add(
                      Dog(name: _eventController.text, age: 120)
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
    );
  }
}
