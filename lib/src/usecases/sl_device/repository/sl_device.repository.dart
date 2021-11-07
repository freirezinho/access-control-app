import 'package:access_control/src/data/models/smart_lock_device/smart_lock_device.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

abstract class SLDeviceRepository {
  Future<List<SLDevice>> getDevices();
  Future<SLDevice?> getDeviceByID(int id);
  Future<void> setNewDevice({required String jsonString});
  Future<void> updateDevice(SLDevice device);
  Future<void> deleteDevice(SLDevice model);
}