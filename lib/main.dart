import 'package:access_control/src/data/db/database.helper.data.dart';
import 'package:access_control/src/data/routes/route_factory.dart';
import 'package:access_control/src/features/views/loading/loading.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SLDBHelper.connectDB();
  runApp(ACApp());
}

class ACApp extends StatefulWidget {
  _ACAppState createState() => _ACAppState();
}

class _ACAppState extends State<ACApp> {
  final Future<FirebaseApp> _initFirebaseSdk = Firebase.initializeApp();
  final _navigatorKey = new GlobalKey<NavigatorState>();

  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    // initializeFlutterFire();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (_error) {
      print("ERROR");
    }
    if (!_initialized) {
      print("Loading");
    }
    return MaterialApp(
      title: 'Access Control',
      routes: ACRouteFactory.routes,
      navigatorKey: _navigatorKey,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightGreen,
      ),
      home: FutureBuilder(
          future: _initFirebaseSdk,
          builder: (_, snapshot) {
            // if (snapshot.hasError) return ErrorScreen();
            if (snapshot.hasError) print (snapshot.error);

            if (snapshot.connectionState == ConnectionState.done) {
              // Assign listener after the SDK is initialized successfully
              FirebaseAuth.instance.authStateChanges().listen((User? user) {
                if (user == null)
                  _navigatorKey.currentState!
                      .pushReplacementNamed('/login');
                else
                  _navigatorKey.currentState!
                      .pushReplacementNamed('/home');
              });
            }

            return LoadingView();
          }),
      // home: LoginView(),
    );
  }
}

