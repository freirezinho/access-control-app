import 'package:access_control/src/data/models/smart_lock_device/meta.dart';
import 'package:access_control/src/data/models/smart_lock_device/smart_lock_device.dart';
import 'package:access_control/src/usecases/sl_device/repository/sl_device.repository.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class SLDeviceRepositoryImpl implements SLDeviceRepository {

  late final Database dbConnection;

  SLDeviceRepositoryImpl({
    required this.dbConnection
  });

  @override
  Future<SLDevice> getDeviceByID(int id) async {
    var device = await dbConnection.query(DBMeta.tb_devices, where: 'id = ?', whereArgs: [id]);
    if (device.length > 0) {
      return SLDevice(
          id: device.first['id'] as int,
          name: device.first['name'] as String,
          isActive: device.first['isActive'] as bool
      );
    }
    throw 'Could not find device with id: $id';
  }

  @override
  Future<List<SLDevice>> getDevices() async {
    final List<Map<String, dynamic>> devices = await dbConnection.query(DBMeta.tb_devices);
    if (devices.length > 0) {
      return List.generate(devices.length, (i) {
        return SLDevice(
          id: devices[i]['id'],
          name: devices[i]['name'],
          isActive: devices[i]['isActive'],
        );
      });
    }
    throw 'Could not retrieve devices from the base';
  }

  @override
  Future<void> setNewDevice(SLDevice device) async {
    await dbConnection.insert(DBMeta.tb_devices, device.toMap(), conflictAlgorithm: ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateDevice(SLDevice device) async {
    await dbConnection.update(DBMeta.tb_devices, device.toMap(), where: 'id = ?', whereArgs: [device.id]);
  }

  @override
  Future<void> deleteDevice({required int id}) async{
    await dbConnection.delete(DBMeta.tb_devices, where: 'id = ?', whereArgs: [id]);
  }

}