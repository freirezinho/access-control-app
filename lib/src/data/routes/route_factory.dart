
import 'package:access_control/src/features/views/home/home.view.dart';
import 'package:access_control/src/features/views/login/login.view.dart';
import 'package:access_control/src/features/views/register/register.view.dart';
import 'package:access_control/src/features/views/register_device/register_device.view.dart';
import 'package:flutter/cupertino.dart';

class ACRouteFactory {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/login': (BuildContext context) => LoginView(),
    '/home': (BuildContext context) => MyHomePage(),
    '/register-account': (BuildContext context) => RegisterView(),
    '/register-device': (BuildContext context) => RegisterDeviceView()
  };
}