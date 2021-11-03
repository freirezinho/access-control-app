import 'package:access_control/src/data/models/smart_lock_device/smart_lock_device.dart';
import 'package:access_control/src/usecases/sl_device/repository/sl_device.repository.dart';

class SLDeviceUseCaseImpl {
  late final SLDeviceRepository repository;

  Future<List<SLDevice>> getDevices() {
    return this.repository.getDevices();
  }

  Future<void> setNewDevice({required SLDevice device}) async{
    await this.repository.setNewDevice(device);
  }

  SLDeviceUseCaseImpl({
    required this.repository,
  });
}