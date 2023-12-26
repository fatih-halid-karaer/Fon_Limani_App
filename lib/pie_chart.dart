import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';




class Pie_Chart extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Pie_Chart> {
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
          child: PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: [
                PieChartSectionData(
                  color: Colors.blue,
                  value: 40,
                  title: 'A',
                  radius: 60,
                  titleStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffffffff),
                  ),
                ),
                PieChartSectionData(
                  color: Colors.green,
                  value: 30,
                  title: 'B',
                  radius: 60,
                  titleStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffffffff),
                  ),
                ),
                PieChartSectionData(
                  color: Colors.red,
                  value: 30,
                  title: 'C',
                  radius: 60,
                  titleStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffffffff),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
