import 'crud.dart';
import 'database_helper.dart';

class Employee {
  String name, profession;
  int ? id;

  Employee(this.name, this.profession);

  void setEmployeeId(int id) {
    this.id = id;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["profession"] = profession;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}
