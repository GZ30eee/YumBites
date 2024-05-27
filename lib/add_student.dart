import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'db.dart';

class AddStudent extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddStudent();
  }
}

class _AddStudent extends State<AddStudent>{

  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController address = TextEditingController();
  //test editing controllers for form

  MyDb mydb = new MyDb(); //mydb new object from db.dart

  @override
  void initState() {
    mydb.open(); //initilization database
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Student"),
        ),
        body:Container(
          padding: EdgeInsets.all(30),
          child: Column(children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                hintText: "Stuent Name",
              ),
            ),

            TextField(
              controller: rollno,
              decoration: InputDecoration(
                hintText: "Roll No.",
              ),
            ),

            TextField(
              controller: address,
              decoration: InputDecoration(
                hintText: "Address:",
              ),
            ),

            ElevatedButton(onPressed: (){

              mydb.db.rawInsert("INSERT INTO students (name, roll_no, address) VALUES (?, ?, ?);",
                  [name.text, rollno.text, address.text]); //add student from form to database

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New Student Added")));
              //show snackbar message after adding student

              name.text = "";
              rollno.text = "";
              address.text = "";
              //clear form to empty after adding data

            }, child: Text("Save Student Data")),
          ],),
        )
    );
  }
}