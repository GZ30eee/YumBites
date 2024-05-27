
import 'package:flutter/material.dart';
import 'mydatabase.dart';

class UpdateUser extends StatefulWidget {
  final Map<String,dynamic> user;
  const UpdateUser({Key? key,required this.user}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  late TextEditingController _nameController;

  @override
  void initState(){
    super.initState();
    _nameController=TextEditingController(
      text: widget.user['userName'].toString()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Mydb().editUser(widget.user['userId'],_nameController.text);
                  Navigator.pop(context,true);
                },
                child: Text('Edit')
            )
          ],
        ),
      ),
    );
  }
}
