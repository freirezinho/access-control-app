
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  final String title = "Login";

  @override
  State<StatefulWidget> createState() => _LoginViewState();

}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(padding: EdgeInsets.only(left: 16, right: 16),
            child:Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Loguinho',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  'Username',
                  textAlign: TextAlign.left,
                ),
                TextField(),
                Text(
                  'Password',
                  textAlign: TextAlign.left,
                ),
                TextField(),
                ElevatedButton(onPressed: () {
                  Navigator.pushNamed(context, '/home');
                }, child:
                  Text("Login")
                )

              ],
            )
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}