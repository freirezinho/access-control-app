
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterDeviceView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterDeviceViewState();

}

class _RegisterDeviceViewState extends State<RegisterDeviceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registre seu Dispositivo")
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Registre")
              ],
            )
        ),
      ),
    );
  }

}