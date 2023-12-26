import 'dart:convert';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



enum LegendShape { circle, rectangle }

class SimulatePortfolioPage extends StatefulWidget {

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<SimulatePortfolioPage> {
  final String api_key = "s67fd6sg67asd67g4sdd3gahfgsdl26875768dfasfsf78sdg78s8g89l568";
  final String apiUrl = 'http://192.168.1.102:8000/';








 
  final dataMap = <String, double>{
    "YAY": 58.3,
    "AFT": 35.2,
    "GFB": 6.56,

  };

  final legendLabels = <String, String>{
    "Fon1": "Fon1 legend",
    "Fon2": "Fon2 legend",
    "Fon3": "Fon3 legend",

  };

  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
  ];

  final gradientList = <List<Color>>[
    [
      const Color.fromRGBO(223, 250, 92, 1),
      const Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      const Color.fromRGBO(129, 182, 205, 1),
      const Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      const Color.fromRGBO(175, 63, 62, 1.0),
      const Color.fromRGBO(254, 154, 92, 1),
    ]
  ];
  ChartType? _chartType = ChartType.disc;
  bool _showCenterText = true;
  bool _showCenterWidget = true;
  double? _ringStrokeWidth = 32;
  double? _chartLegendSpacing = 32;

  bool _showLegendsInRow = false;
  bool _showLegends = true;
  bool _showLegendLabel = false;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;

  bool _showGradientColors = false;

  LegendShape? _legendShape = LegendShape.circle;


  int key = 0;
  Map<String,dynamic> _map1 = {};
  Map<String,dynamic> _map2 = {};
  Map<String,dynamic> _map3 = {};
  Map<String,dynamic> _map4 = {};


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserPortfolio(10, _map1);
    _getFund("YAY", _map2);
    _getFund("GFB", _map3);
    _getFund("AFT", _map4);

  }
  @override
  Widget build(BuildContext context) {
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: _chartLegendSpacing!,
      chartRadius: math.min(MediaQuery.of(context).size.width / 3.2, 300),
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType!,
      centerText: _showCenterText ? "" : null,
      centerWidget: _showCenterWidget
          ? Container(color: Colors.red, child: const Text(""))
          : null,
      legendLabels: _showLegendLabel ? legendLabels : {},
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,

        showLegends: _showLegends,
        legendShape: _legendShape == LegendShape.circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        legendTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth!,
      emptyColor: Colors.grey,
      gradientList: _showGradientColors ? gradientList : null,
      emptyColorGradient: const [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
      baseChartColor: Colors.transparent,
    );
    final settings = SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(12),
        child: Column(
          children: [
            SwitchListTile(
              value: _showGradientColors,
              title: const Text("Renkleri değiştir"),
              onChanged: (val) {
                setState(() {
                  _showGradientColors = val;
                });
              },
            ),
            ListTile(
              title: Text(
                'Portföy Grafik Seçenekleri'.toUpperCase(),
                style: Theme.of(context).textTheme.overline!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text("grafik stili"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<ChartType>(
                  value: _chartType,
                  items: const [
                    DropdownMenuItem(
                      value: ChartType.disc,
                      child: Text("disk"),
                    ),
                    DropdownMenuItem(
                      value: ChartType.ring,
                      child: Text("yüzük"),
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _chartType = val;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: const Text("Yüzük Genişliği"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<double>(
                  value: _ringStrokeWidth,
                  disabledHint: const Text("Yüzük stili grafik seç"),
                  items: const [
                    DropdownMenuItem(
                      value: 16,
                      child: Text("16"),
                    ),
                    DropdownMenuItem(
                      value: 32,
                      child: Text("32"),
                    ),
                    DropdownMenuItem(
                      value: 48,
                      child: Text("48"),
                    ),
                  ],
                  onChanged: (_chartType == ChartType.ring)
                      ? (val) {
                    setState(() {
                      _ringStrokeWidth = val;
                    });
                  }
                      : null,
                ),
              ),
            ),

            ListTile(
              title: const Text("Grafik veri aralama"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<double>(
                  value: _chartLegendSpacing,
                  disabledHint: const Text("Yüzük stili grafik seç"),
                  items: const [
                    DropdownMenuItem(
                      value: 16,
                      child: Text("16"),
                    ),
                    DropdownMenuItem(
                      value: 32,
                      child: Text("32"),
                    ),
                    DropdownMenuItem(
                      value: 48,
                      child: Text("48"),
                    ),
                    DropdownMenuItem(
                      value: 64,
                      child: Text("64"),
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _chartLegendSpacing = val;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Portföy veri seçenekleri'.toUpperCase(),
                style: Theme.of(context).textTheme.overline!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SwitchListTile(
              value: _showLegends,
              title: const Text("Verileri göster"),
              onChanged: (val) {
                setState(() {
                  _showLegends = val;
                });
              },
            ),
            SwitchListTile(
              value: _showLegendsInRow,
              title: const Text("Verileri satırda göster"),
              onChanged: (val) {
                setState(() {
                  _showLegendsInRow = val;
                });
              },
            ),
            SwitchListTile(
              value: _showLegendLabel,
              title: const Text("Veri Etiketlerini göster"),
              onChanged: (val) {
                setState(() {
                  _showLegendLabel = val;
                });
              },
            ),
            ListTile(
              title: const Text("Veri şekli"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<LegendShape>(
                  value: _legendShape,
                  items: const [
                    DropdownMenuItem(
                      value: LegendShape.circle,
                      child: Text("Yuvarlak"),
                    ),
                    DropdownMenuItem(
                      value: LegendShape.rectangle,
                      child: Text("Şekilli"),
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _legendShape = val;
                    });
                  },
                ),
              ),
            ),

            ListTile(
              title: Text(
                'Portföy Grafik değer seçenekleri'.toUpperCase(),
                style: Theme.of(context).textTheme.overline!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SwitchListTile(
              value: _showChartValueBackground,
              title: const Text("Grafik değer arkaplanı göster"),
              onChanged: (val) {
                setState(() {
                  _showChartValueBackground = val;
                });
              },
            ),
            SwitchListTile(
              value: _showChartValues,
              title: const Text("Grafik değerleri göster"),
              onChanged: (val) {
                setState(() {
                  _showChartValues = val;
                });
              },
            ),
            SwitchListTile(
              value: _showChartValuesInPercentage,
              title: const Text("Yüzde göster"),
              onChanged: (val) {
                setState(() {
                  _showChartValuesInPercentage = val;
                });
              },
            ),
            SwitchListTile(
              value: _showChartValuesOutside,
              title: const Text("Grafik değerlerini dışarıda göster"),
              onChanged: (val) {
                setState(() {
                  _showChartValuesOutside = val;
                });
              },
            ),
          ],
        ),
      ),
    );
    final data1 = SfCartesianChart(
      title: ChartTitle(
        text: 'Ödeme Türlerine Göre Ödeme Miktarı',
        textStyle: TextStyle(fontSize: 18),
      ),

      series: <LineSeries>[
        LineSeries<Payment, String>(
          dataSource: _payments,
          xValueMapper: (Payment payment, _) => payment.paymentType,
          yValueMapper: (Payment payment, _) => payment.amount,
          color: Colors.blue,
          name: 'YAY',
        ),
        LineSeries<Payment, String>(
          dataSource: _payments,
          xValueMapper: (Payment payment, _) => payment.paymentType,
          yValueMapper: (Payment payment, _) => payment.amount,
          color: Colors.red,
          name: 'AFT',
        ),
        LineSeries<Payment, String>(
          dataSource: _payments,
          xValueMapper: (Payment payment, _) => payment.paymentType,
          yValueMapper: (Payment payment, _) => payment.amount,
          color: Colors.green,
          name: 'GFB',
        ),
      ],
      primaryXAxis: NumericAxis(
        majorGridLines: MajorGridLines(
          dashArray: [5, 5],
        ),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(
          dashArray: [5, 5],
        ),
      ),
    );
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

      body: LayoutBuilder(
        builder: (_, constraints) {
          if (constraints.maxWidth >= 600) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: chart,
                ),

                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: settings,
                )
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 32,
                    ),
                    child: chart,
                  ),
                  settings,
                ],
              ),
            );
          }
        },
      ),
    );
  }
   Future<void> _getUserPortfolio(int value, Map<String,dynamic> map1) async {
     final String query_add = 'user_portfolios/get_user_portfolios?value=$value&by=_id';

     try {
       final response = await http.get(
         Uri.parse(apiUrl + query_add),
         headers: {
           "Content-Type": "application/json",
           // Include your API key in the headers
           "api_key": "$api_key",
         },
       );

       if (response.statusCode == 200) {

         map1 = jsonDecode(response.body);
         print("Added to map");
       } else {
         print("Failed to get user portfolio. Status code: ${response.statusCode}");
       }
     }  catch (e) {
       // TODO
       print("Error : $e");
     }
   }
   Future<void> _getFund(String code ,Map<String,dynamic> map1) async {
     final String query_add = 'funds/get_fund?value=$code&by=fund_code';
     try {
       final response = await http.get(
         Uri.parse(apiUrl + query_add),
         headers: {
           "Content-Type": "application/json",
           "api_key": "$api_key",
         },
       );

       if (response.statusCode == 200) {
         setState(() {
           map1 = jsonDecode(response.body);
         });
       } else {
         setState(() {
           map1 = jsonDecode(response.body);
         });
       }
     } catch (e) {
       print("Error: $e");
     }
   }
}

class HomePage2 extends StatelessWidget {
  HomePage2({Key? key}) : super(key: key);

  final dataMap = <String, double>{
    "Fon1": 5,
  };

  final colorList = <Color>[
    Colors.greenAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Portföy Grafik"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: PieChart(
          dataMap: dataMap,
          chartType: ChartType.ring,
          baseChartColor: Colors.grey[50]!.withOpacity(0.15),
          colorList: colorList,
          chartValuesOptions: const ChartValuesOptions(
            showChartValuesInPercentage: true,
          ),
          totalValue: 20,
        ),
      ),
    );
  }
}
class Payment {
  final String paymentType;
  final double amount;

  Payment(this.paymentType, this.amount);
}
