import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../staff/staffmethod.dart';


List<LineChartBarData> lineChartBarData = [
  LineChartBarData(
    color: Colors.white,
    isCurved: true,
    spots: [
      FlSpot(1, 235),
      FlSpot(2, 236),
      FlSpot(3, 237),
      FlSpot(4, 237),
      FlSpot(5, 239),
      FlSpot(6, 238),
    ],
  ),
];

DateTime currentDate = DateTime.now();

// Generate date labels for the next 7 days
List<String> dateLabels = List.generate(7, (index) {
  DateTime date = currentDate.add(Duration(days: index));
  return "${date.day}/${date.month}";
});