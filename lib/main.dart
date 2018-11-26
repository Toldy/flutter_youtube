import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_youtube/FlutterView.dart';
import 'package:flutter_youtube/HomeView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {

    final FirebaseApp app = await FirebaseApp.configure(
        name: 'test',
        options: const FirebaseOptions(
            googleAppID: '1:884564187248:ios:0796ad7aa921b1d3',
            apiKey: 'AIzaSyBgHNcpq-mRPpD4JGuMyc9R6ZiXZKVLbg4',
            projectID: 'personal-tests',
        ),
    );
    final Firestore firestore = Firestore(app: app);
    await Firestore().settings(timestampsInSnapshotsEnabled: true);

    runApp(MyApp());
}

class MyApp extends StatelessWidget {
    // This widget is the root of your application.

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Demo',
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
                primarySwatch: Colors.pink,
                textSelectionColor: Colors.red,
            ),
            home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
    }
}

class MyHomePage extends StatefulWidget {
    MyHomePage({Key key, this.title}) : super(key: key);

    // This widget is the home page of your application. It is stateful, meaning
    // that it has a State object (defined below) that contains fields that affect
    // how it looks.

    // This class is the configuration for the state. It holds the values (in this
    // case the title) provided by the parent (in this case the App widget) and
    // used by the build method of the State. Fields in a Widget subclass are
    // always marked "final".

    final String title;

    @override
    _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    final _widgetOptions = [
        HomeView(),
        Text('Index 1: Business'),
        const Center(child: Text('Hello, world!', textDirection: TextDirection.ltr)),
        FlutterView(),
        Text('Index 4: School'),
    ];

    int _selectedIndex = 0;

    void _onItemTapped(int index) {
        setState(() {
            _selectedIndex = index;
        });
    }

    Widget _bodyForTab() {
        return _widgetOptions.elementAt(_selectedIndex);
    }


    BottomNavigationBarItem _barItem(IconData icon, String text) {
        return BottomNavigationBarItem(
                icon: Icon(icon, color: Colors.grey),
                title: Text(text),
                activeIcon: Icon(icon, color: Colors.red));
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Youtube'),
            ),
            body: Center(
                child: _bodyForTab(),
            ),
            bottomNavigationBar: CupertinoTabBar(
                items: <BottomNavigationBarItem>[
                    _barItem(Icons.home, "Home"),
                    _barItem(Icons.whatshot, "Trending"),
                    _barItem(Icons.subscriptions, "Subscriptions"),
                    _barItem(Icons.mail, "Inbox"),
                    _barItem(Icons.folder, "Library"),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                activeColor: Colors.red,
            ),
        );
    }
}
