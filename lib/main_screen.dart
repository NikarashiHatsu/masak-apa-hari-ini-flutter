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
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1.0,
                    blurRadius: 1.0,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(),
                  IconButton(
                    icon: Icon(Icons.close),
                    tooltip: 'Tutup Drawer',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
            ListTile(
              title: Text('Beranda'),
              leading: Icon(Icons.home),
              onTap: () {
                print('Ke Beranda');
              },
            ),
            ListTile(
              title: Text('Resep'),
              leading: Icon(Icons.receipt_long),
              onTap: () {
                print('Ke Resep');
              },
            ),
            ListTile(
              title: Text('Kategori'),
              leading: Icon(Icons.category),
              onTap: () {
                print('Ke Kategori');
              },
            ),
            ListTile(
              title: Text('Artikel'),
              leading: Icon(Icons.feed),
              onTap: () {
                print('Ke Artikel');
              },
            ),
            ListTile(
              title: Text('Favorit Saya'),
              leading: Icon(Icons.bookmarks),
              onTap: () {
                print('Ke Favorit Saya');
              },
            ),
          ],
        ),
      ),
    );
  }
}
