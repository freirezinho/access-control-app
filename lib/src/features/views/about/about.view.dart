
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Smart Locks"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Sobre o App",
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2,
                    color: Colors.black87
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 24
                ),
                Text(
                    "Smart Locks foi idealizado por Ronaldo Mendes e Saulo Freire como um aplicativo companheiro para um dispositivo de fechadura eletrônica.\n\nPor meio deste app, você poderá controlar remotamente quaisquer fechaduras Smart Locks.",
                  style: TextStyle(
                    color: Colors.black45
                  )
                )
              ],
            ),
          )
      ),
    );
  }

}