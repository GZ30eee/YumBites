import 'package:flutter/material.dart';
import 'add_student.dart';
import 'list_student.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sqlite and Sqflite"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(20),
        child: Column(
            children:[

              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return AddStudent();
                  }));
                },
                child: Text("Add Student"),
              ),

              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return ListStudents();
                  }));
                },
                child: Text("List Student Record"),
              ),

            ]
        ),
      ),
    );
  }

}