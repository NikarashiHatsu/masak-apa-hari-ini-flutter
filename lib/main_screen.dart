import 'package:flutter/material.dart';
import 'package:masak_apa_hari_ini/pages/artikel.dart';
import 'package:masak_apa_hari_ini/pages/beranda.dart';
import 'package:masak_apa_hari_ini/pages/favorit.dart';
import 'package:masak_apa_hari_ini/pages/kategori.dart';
import 'package:masak_apa_hari_ini/pages/resep.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget _halaman = Beranda();

  /// Ganti halaman baru dengan mengatur [_halaman], lalu menutup drawer.
  void gantiHalaman(Widget halamanBaru) {
    setState(() {
      this._halaman = halamanBaru;

      if (_scaffoldKey.currentState!.isDrawerOpen) {
        Navigator.pop(context);
      }
    });
  }

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
                gantiHalaman(Beranda());
              },
            ),
            ListTile(
              title: Text('Resep'),
              leading: Icon(Icons.receipt_long),
              onTap: () {
                gantiHalaman(Resep());
              },
            ),
            ListTile(
              title: Text('Kategori'),
              leading: Icon(Icons.category),
              onTap: () {
                gantiHalaman(Kategori());
              },
            ),
            ListTile(
              title: Text('Artikel'),
              leading: Icon(Icons.feed),
              onTap: () {
                gantiHalaman(Artikel());
              },
            ),
            ListTile(
              title: Text('Favorit'),
              leading: Icon(Icons.bookmarks),
              onTap: () {
                gantiHalaman(Favorit());
              },
            ),
          ],
        ),
      ),
      body: _halaman,
    );
  }
}
