import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'line_chart_data.dart';

class LineChartContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 1,
        minY: 235,
        maxX: 7,
        maxY: 240,
        lineBarsData: lineChartBarData,
          borderData: FlBorderData(
              border: Border.all(
                  color: Colors.white,
                  width: 1
              )
          ),

        titlesData: FlTitlesData(
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false
            )
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: false
            )
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index > 0 && index <= dateLabels.length) {

                }
                return Text(dateLabels[index - 1], style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold
                ));
              },
            ),

          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              interval: 1,
              showTitles: true,
              getTitlesWidget: (value, meta) {
                String text = '';
                if(value.toInt() == 0) return Text(text);
                else return Expanded(
                  child: Text(value.toInt().toString(), style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold
                  ),

                  ),
                );
              },
            )
          )
        )
      ),
    );
  }

}