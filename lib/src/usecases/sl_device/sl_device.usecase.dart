import 'package:access_control/src/data/models/smart_lock_device/smart_lock_device.dart';
import 'package:access_control/src/usecases/sl_device/repository/sl_device.repository.dart';

abstract class SLDeviceUseCase {
  late final SLDeviceRepository repository;
  Future<List<SLDevice>> getDevices();
  Future<void> setNewDevice({required SLDevice device});
}