
import 'package:access_control/src/data/models/smart_lock_device/smart_lock_device.dart';
import 'package:access_control/src/usecases/sl_device/repository/sl_device.impl.repository.dart';
import 'package:access_control/src/usecases/sl_device/sl_device.impl.usecase.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Smart Locks";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool reRender = false;
  bool toggledRoute = false;
  int _selectedTabIndex = 0;
  static const List<Widget> _subpages = <Widget>[

  ];
  List<SLDevice>? devices = [];

  @override
  Future<bool> didPopRoute() {
    setState(() {
      toggledRoute = !toggledRoute;
    });
    return super.didPopRoute();
  }

  @override
  Future<bool> didPushRoute(String route) {
    setState(() {
      toggledRoute = !toggledRoute;
    });
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    setState(() {
      toggledRoute = !toggledRoute;
    });
    return super.didPushRouteInformation(routeInformation);
  }

  void _onTabChange(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  Widget getSubpageForIndex(int index, BuildContext context) {
    switch (index) {
      case 1: {
        return settingsSubPage(context);
      }
      default: {
        return deviceListSubPage(context);
      }
      break;
    }
  }

  Widget deviceListSubPage(BuildContext context) {
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: FutureBuilder<List<SLDevice>>(
            future: getDevices(),
            initialData: [],
            builder: (context, snapshot) {
              List<SLDevice>? devices = snapshot.data;
              if (devices != null && devices.length > 0) {
                return buildList(context, snapshot);
              } else {
                return Container(
                  child: Text("N??o h?? dispositivos cadastrados."),
                );
              }
            },
          ),
        )
    );
  }

  Widget settingsSubPage(BuildContext context) {
    return Center(
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
                  "Configura????es",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -2,
                  color: Colors.black87
                ),
                textAlign: TextAlign.left,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/about');
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60,
                          child: Center(
                            child: Text("Sobre o App", style: TextStyle(color: Colors.black54)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60,
                          child: Center(
                            child: Text("Logout", style: TextStyle(color: Colors.black54)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: getSubpageForIndex(_selectedTabIndex, context),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.playlist_add), label: 'Dispositivos'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config')
        ],
        currentIndex: _selectedTabIndex,
        selectedItemColor: Colors.cyan,
        onTap: _onTabChange,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register-device');
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void showAlert(BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
            barrierDismissible: true,
            opaque: false,
            pageBuilder: (_, anim1, anim2) => AlertDialog(
                content: Text('Alert!'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                )
            )
        )
    );
  }

  void showDeleteAlert(BuildContext context, SLDevice device) {
    Navigator.push(
        context,
        PageRouteBuilder(
            barrierDismissible: true,
            opaque: false,
            pageBuilder: (_, anim1, anim2) => AlertDialog(
              title: Text("Esta a????o ?? irevers??vel"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      SLDeviceUseCaseImpl(repository: SLDeviceRepositoryImpl()).deleteDevice(device);
                      Navigator.pop(context);
                      setState(() {
                        reRender = !reRender;
                      });
                    },
                    child: Text("Deletar"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white)
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancelar")
                  )
                ],
                content: Text('Caso prossiga com a remo????o do dispositivo, ele ser?? removido da lista e ser?? necess??rio cadastr??-lo novamente mais tarde.'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0),
                ),
            )
          )
        )
    );
  }

  Future<List<SLDevice>> getDevices() async {
    var usecase = SLDeviceUseCaseImpl(repository: SLDeviceRepositoryImpl());
    var devices = await usecase.getDevices();
    print("Retrieved devices $devices");
    return devices;
  }

  Widget buildList(BuildContext context, AsyncSnapshot snapshot) {
    print("Snapshot data ${snapshot.data}");
    List<SLDevice> values = snapshot.data as List<SLDevice>;
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: () {
          print(values[index]);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.lock),
                  Padding(padding: EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(values[index].name)
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {
                    showDeleteAlert(context, values[index]);
                  }, icon: Icon(Icons.delete, color: Colors.redAccent,))
                ],
              ),
            ),
            Divider(),
          ],
        ),
      );
    });
  }
}