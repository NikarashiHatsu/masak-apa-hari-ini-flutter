import 'package:flutter/material.dart';

class Pencarian extends StatelessWidget {
  final String keyword;
  const Pencarian({Key? key, required this.keyword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Pencarian: $keyword'),
    );
  }
}
