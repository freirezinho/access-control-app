import 'package:access_control/src/data/models/smart_lock_device/smart_lock_device.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

abstract class SLDeviceRepository {
  late final Database dbConnection;
  Future<List<SLDevice>> getDevices();
  Future<SLDevice> getDeviceByID(int id);
  Future<void> setNewDevice(SLDevice device);
  Future<void> updateDevice(SLDevice device);
  Future<void> deleteDevice({required int id});
}