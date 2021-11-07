import 'package:access_control/src/data/db/database.helper.data.dart';
import 'package:access_control/src/data/db/meta.data.dart';
import 'package:access_control/src/data/models/smart_lock_device/smart_lock_device.dart';
import 'package:access_control/src/usecases/sl_device/repository/sl_device.repository.dart';
import 'dart:convert';

class SLDeviceRepositoryImpl implements SLDeviceRepository {

  @override
  Future<SLDevice?> getDeviceByID(int id) async {
    try {
      var deviceMap = await SLDBHelper.selectOne(DBMeta.tb_devices, where: 'id = ?', whereArgs: [id]);
      return SLDevice.fromMap(deviceMap);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<SLDevice>> getDevices() async {
    final List<Map<String, dynamic>> devices = await SLDBHelper.selectList(DBMeta.tb_devices);
    if (devices.length > 0) {
      return List.generate(devices.length, (i) {
        return SLDevice.fromMap(devices[i]);
      });
    }
    throw 'Could not retrieve devices from the base';
  }

  @override
  Future<void> setNewDevice({required String jsonString}) async {
    try {
      Map<String, dynamic> json = jsonDecode(jsonString);
      var slDevice = SLDevice.fromMap(json);
      await SLDBHelper.insert(slDevice);
    }  catch (error) {
      throw error;
    }
  }

  @override
  Future<void> updateDevice(SLDevice device) async {
    await SLDBHelper.update(device, where: 'id = ?', whereArgs: [device.id]);
  }

  @override
  Future<void> deleteDevice(SLDevice model) async{
    await SLDBHelper.delete(model, where: 'id = ?', whereArgs: [model.id]);
  }

}