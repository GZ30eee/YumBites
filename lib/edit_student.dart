import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'db.dart';

class EditStudent extends StatefulWidget{

  int rollno;
  EditStudent({required this.rollno}); //constructor for class

  @override
  State<StatefulWidget> createState() {
    return _EditStudent();
  }
}

class _EditStudent extends State<EditStudent>{

  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController address = TextEditingController();

  MyDb mydb = new MyDb();

  @override
  void initState() {
    mydb.open();

    Future.delayed(Duration(milliseconds: 500), () async {
      var data = await mydb.getStudent(widget.rollno); //widget.rollno is passed paramater to this class
      if(data != null){
        name.text = data["name"];
        rollno.text = data["roll_no"].toString();
        address.text = data["address"];
        setState(() {});
      }else{
        print("No any data with roll no: " + widget.rollno.toString());
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Student"),
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
              mydb.db.rawInsert("UPDATE students SET name = ?, roll_no = ?, address = ? WHERE roll_no = ?",
                  [name.text, rollno.text, address.text, widget.rollno]);
              //update table with roll no.
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student Data Updated")));

            }, child: Text("Update Student Data")),
          ],),
        )
    );
  }

}
