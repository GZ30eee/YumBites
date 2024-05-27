import 'package:flutter/material.dart';
import 'employee.dart';
import 'database_helper.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DatabaseHelper db = new DatabaseHelper();
  List<Employee> employees = [];

  @override
  void initState() {
    super.initState();
    setEmployees();
  }

  void setEmployees() async {
    employees = await db.getEmployees();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Operations in Flutter'),
      ),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(employees[index].name),
            subtitle: Text(employees[index].profession),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                int result = await db.deleteEmployee(employees[index]);
                if (result > 0) {
                  setState(() {
                    employees.removeAt(index);
                  });
                }
              },
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  TextEditingController controller = TextEditingController(text: employees[index].name);
                  return AlertDialog(
                    title: Text('Edit Employee'),
                    content: TextField(
                      controller: controller,
                    ),
                    actions: [
                      ElevatedButton(
                        child: Text('Update'),
                        onPressed: () async {
                          String newName = controller.text;
                          Employee updatedEmployee = Employee(newName, employees[index].profession);
                          updatedEmployee.setEmployeeId(employees[index].id!);
                          int result = await db.update(updatedEmployee);
                          if (result > 0) {
                            setEmployees();
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              TextEditingController nameController = TextEditingController();
              TextEditingController professionController = TextEditingController();
              return AlertDialog(
                title: Text('Add Employee'),
                content: Column(
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(hintText: 'Employee Name'),
                    ),
                    TextField(
                      controller: professionController,
                      decoration: InputDecoration(hintText: 'Profession'),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    child: Text('Add'),
                    onPressed: () async {
                      String name = nameController.text;
                      String profession = professionController.text;
                      Employee employee = Employee(name, profession);
                      int result = await db.saveEmployee(employee);
                      if (result > 0) {
                        setEmployees();
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
