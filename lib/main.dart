import 'package:flutter/material.dart';
import 'package:masak_apa_hari_ini/main_screen.dart';

void main(List<String> args) {
  runApp(MasakApaHariIniApp());
}

class MasakApaHariIniApp extends StatelessWidget {
  const MasakApaHariIniApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
      title: 'Masak Apa Hari Ini?',
    );
  }
}
