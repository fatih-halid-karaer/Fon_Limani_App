import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Bar_Chart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            ImageIcon(
              AssetImage('assets/fon_limani_blue_logo_group.png'),
              size: 140.0,
              color: Colors.blue,
            ),

          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.center,
              maxY: 100,
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: const Color(0xff37434d),
                  width: 1,
                ),
              ),

              barGroups: _generateRandomData(),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateRandomData() {
    Random random = Random();
    List<BarChartGroupData> barGroups = [];

    for (int i = 0; i < 5; i++) {
      double goldValue = random.nextDouble() * 100;
      double silverValue = random.nextDouble() * 100;

      BarChartGroupData barGroup = BarChartGroupData(
        x: i,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: goldValue,
            color: Colors.yellow,
          ),
          BarChartRodData(
            toY: silverValue,
            color: Colors.grey,
          ),
        ],
      );

      barGroups.add(barGroup);
    }

    return barGroups;
  }



}
