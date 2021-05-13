import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(name: 'Course', percent: 40, color: const Color(0xff0293ee)),
    Data(name: 'Velo', percent: 45, color: const Color(0xfff8b250)),
    Data(name: 'Marche', percent: 15, color: Colors.green),
  ];
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({this.name, this.percent, this.color});
}
