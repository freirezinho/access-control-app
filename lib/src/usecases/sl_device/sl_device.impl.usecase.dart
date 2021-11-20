import 'dart:convert';

import 'package:access_control/src/data/models/smart_lock_device/qr_code_data.dart';
import 'package:access_control/src/data/models/smart_lock_device/smart_lock_device.dart';
import 'package:access_control/src/usecases/message_retriever/repository/message_client.dart';
import 'package:access_control/src/usecases/sl_device/repository/sl_device.repository.dart';

class SLDeviceUseCaseImpl {
  late final SLDeviceRepository repository;

  Future<List<SLDevice>> getDevices() async {
    try {
      return this.repository.getDevices();
    } catch(e) {
      print(e);
      return [] as List<SLDevice>;
    }
  }

  Future<void> setNewDevice({required String jsonString}) async{
      // Map<String, dynamic> json = jsonDecode(jsonString);
      // QRCodeData data = QRCodeData.fromMap(json);
      // if (data.url != MessageClient.shared.mqttUrl || data.port != MessageClient.shared.mqttPort) {
      //   print("New client");
      // }
      return await this.repository.setNewDevice(jsonString: jsonString);
  }

  Future<void> deleteDevice(SLDevice device) async {
    return await this.repository.deleteDevice(device);
  }

  SLDeviceUseCaseImpl({
    required this.repository,
  });
}