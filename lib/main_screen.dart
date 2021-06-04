import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Main Screen
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title:
            Text('Masak Apa Hari Ini?', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () => print('Search'),
          )
        ],
      ),
      drawer: Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('This is the Drawer'),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close Drawer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
