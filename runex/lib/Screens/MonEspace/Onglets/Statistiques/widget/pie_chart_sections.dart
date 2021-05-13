import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:runex/Screens/MonEspace/Onglets/Statistiques/data/pie_data.dart';

List<PieChartSectionData> getSections(int touchedIndex) => PieData.data
    .asMap()
    .map<int, PieChartSectionData>((index, data) {
      final isTouched = index == touchedIndex;
      final double fontSize = isTouched ? 15 : 10;
      final double radius = isTouched ? 90 : 80;

      final value = PieChartSectionData(
        color: data.color,
        value: data.percent,
        title: ' ${data.name} ',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );

      return MapEntry(index, value);
    })
    .values
    .toList();
