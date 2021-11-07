import 'package:access_control/src/data/db/dbmodel.data.dart';
import 'package:access_control/src/data/db/meta.data.dart';

class SLDevice implements SLDBModel {
  late int id;
  late String name;
  late bool isActive;

  SLDevice({
    required this.id,
    required this.name,
    required this.isActive
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      // SQLite não trabalha com boolean true / false, trabalha com int 1 / 0
      'isActive': isActive ? 1 : 0
    };
  }

  @override
  String toString() {
    return 'SmartLockDevice { id: $id, name: $name, isActive: $isActive}';
  }

  @override
  String tbName = DBMeta.tb_devices;

  SLDevice.fromMap(Map<String, dynamic> map) {
      id = map['id']!;
      name = map['name']!;
      isActive = map['isActive']! == 1 ? true : false;
  }

}