import 'package:flutter/material.dart';
import 'package:masak_apa_hari_ini/pages/beranda.dart';
import 'package:masak_apa_hari_ini/pages/kategori.dart';
import 'package:masak_apa_hari_ini/pages/pencarian.dart';
import 'package:masak_apa_hari_ini/pages/resep.dart';
// import 'package:masak_apa_hari_ini/pages/artikel.dart';
// import 'package:masak_apa_hari_ini/pages/favorit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _pencarianController = TextEditingController();
  Widget _halaman = Beranda();

  /// Ganti halaman baru dengan mengatur [_halaman], lalu menutup [Drawer] dari
  /// [Scaffold].
  void _gantiHalaman(Widget halamanBaru) {
    setState(() {
      this._halaman = halamanBaru;

      if (_scaffoldKey.currentState!.isDrawerOpen) {
        Navigator.pop(context);
      }
    });
  }

  /// Menampilkan [BottomSheet] yang berisi form pencarian resep
  void _tampilkanPencarian(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        double _keyboardPadding =
            MediaQuery.of(_scaffoldKey.currentContext!).viewInsets.bottom;

        return Padding(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, _keyboardPadding),
          child: Container(
            child: TextFormField(
              controller: _pencarianController,
              autofocus: true,
              maxLength: 60,
              onEditingComplete: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return Pencarian(keyword: _pencarianController.text);
                }));
              },
              decoration: InputDecoration(
                labelText: 'Cari resep',
                hintText: 'Contoh: Kue Kering',
              ),
            ),
          ),
        );
      },
    );
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
            onPressed: () => _tampilkanPencarian(context),
          )
        ],
        elevation: 0,
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
                _gantiHalaman(Beranda());
              },
            ),
            ListTile(
              title: Text('Resep'),
              leading: Icon(Icons.receipt_long),
              onTap: () {
                _gantiHalaman(Resep());
              },
            ),
            ListTile(
              title: Text('Kategori'),
              leading: Icon(Icons.category),
              onTap: () {
                _gantiHalaman(Kategori());
              },
            ),
            // TODO: Tambah menu Artikel
            // ListTile(
            //   title: Text('Artikel'),
            //   leading: Icon(Icons.feed),
            //   onTap: () {
            //     _gantiHalaman(Artikel());
            //   },
            // ),
            // TODO: Implementasi local storage untuk favorit
            // ListTile(
            //   title: Text('Favorit'),
            //   leading: Icon(Icons.bookmarks),
            //   onTap: () {
            //     _gantiHalaman(Favorit());
            //   },
            // ),
          ],
        ),
      ),
      body: _halaman,
    );
  }
}
