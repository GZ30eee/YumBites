import 'package:flutter/material.dart';
import 'adduserpage.dart';
import 'mydatabase.dart';
import 'updateuserpage.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List Page"),
          backgroundColor: Colors.grey.shade300,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddUser(),
                  ),
                ).then((value) {
                  if (value != null && value) {
                    setState(() {});
                  }
                });
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: FutureBuilder(
          future: Mydb().copyPasteAssetFileToRoot(),
          builder: (context, snapshot_copy) {
            if (snapshot_copy.hasData) {
              return FutureBuilder(
                future: Mydb().getDetail(),
                builder: (context, snapshot_getAll) {
                  if (snapshot_getAll.hasData) {
                    return ListView.builder(
                      itemCount: snapshot_getAll.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Card(
                            child: ListTile(
                              title: Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 12, right: 7),
                                    child: Text(
                                      snapshot_getAll.data![index]['userId']
                                          .toString(),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 7),
                                      child: Text(
                                        snapshot_getAll.data![index]['userName']
                                            .toString(),
                                      )
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: (){
                                        Navigator.push(
                                            context,
                                          MaterialPageRoute(
                                              builder: (context)=>UpdateUser(user: snapshot_getAll.data![index]),
                                          )
                                        ).then((value){
                                          if(value!=null && value){
                                            setState(() {

                                            });
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.edit)
                                  ),
                                  IconButton(
                                      onPressed: (){
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context){
                                              return AlertDialog(
                                                title: Text('Delete'),
                                                content: Text('Are you sure you want to delete this user?'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: (){
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('no'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async{
                                                      await Mydb().deleteUser(snapshot_getAll.data![index]['userId']);
                                                      Navigator.pop(context);
                                                      setState(() {

                                                      });
                                                    },
                                                    child: Text('yes'),
                                                  ),
                                                ],
                                              );
                                            }
                                        );
                                      },
                                      icon: Icon(Icons.delete)
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            }
            if (snapshot_copy.data == null) {
              return Text("null data received");
            } else {
              return Text("Copying");
            }
            // return Text("null");
          },
        ));
  }
}
