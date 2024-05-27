import 'package:flutter/material.dart';
import 'mydatabase.dart';

class AddUser extends StatelessWidget {
  final TextEditingController _nameController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'UserName'
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: (){
                  Mydb().insertUser(_nameController.text);
                  Navigator.pop(context,true);
                },
                child: Text('Add User')
            )
          ],
        ),
      ),
    );
  }
}
