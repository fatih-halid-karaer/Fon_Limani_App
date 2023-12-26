import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class TrendAnalysisPage extends StatefulWidget {
  TrendAnalysisPage({Key? key}) : super(key: key);

  @override
  _TrendAnalysisPageState createState() => _TrendAnalysisPageState();
}

class _TrendAnalysisPageState extends State<TrendAnalysisPage> {
  final String api_key = "s67fd6sg67asd67g4sdd3gahfgsdl26875768dfasfsf78sdg78s8g89l568";
  final String apiUrl = 'http://192.168.1.108:8000/';


List<Map<String,dynamic>> _fonlist1 = [];
  List<Map<String,dynamic>> _fonlist2 = [];
  List<Map<String,dynamic>> _fonlist3 = [];
  List<Map<String,dynamic>> _fonlist4 = [];
  List<Map<String,dynamic>> _fonlist5 = [];
  List<Map<String,dynamic>> _fonlist6 = [];
  List<Map<String,dynamic>> _fonlist7 = [];
  List<Map<String,dynamic>> _fonlist8 = [];
  List<Map<String,dynamic>> _fonlist9 = [];




//Veritabanından çekememesi durumunda yedek olarak tutulmaktadır.
  List<_Change> data1 = [
    _Change( 'ABG', 	37.851024504640584),
    _Change('TAU', 	20.472755401248442),
    _Change('YZH', 20.46562560234134),
    _Change('RYF',  20.303107752939443),
    _Change('ZBP',  	20.16006933232327),
    _Change( 'ADP',  20.111882045279792),
    _Change( 'BLH',  20.08335698238614),
    _Change( 'YCP',  	19.736759291112467),
    _Change( 'BDI',  18.736695182452305),

  ];

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLastMonthFund("ABG",_fonlist1);
    getLastMonthFund("TAU",_fonlist2);
    getLastMonthFund("YZH",_fonlist3);
    getLastMonthFund("RYF",_fonlist4);
    getLastMonthFund("ZBP",_fonlist5);
    getLastMonthFund("ADP",_fonlist6);
    getLastMonthFund("BLH",_fonlist7);
    getLastMonthFund("YCP",_fonlist8);
    getLastMonthFund("BDI",_fonlist9);

  }

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
        actions: [
          // Sağ üst köşede soru işareti butonu ekleyin
          IconButton(
            icon: Icon(Icons.help_outline, size: 24, color: Colors.blue),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Column(
        children: [
          // The chart occupies the available space

          // The column chart occupies a fixed height
          Container(
             // Adjust the height as needed
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Limanda Bu Ay En Çok Kazandıranlar'),
              series: <CartesianSeries<_Change, String>>[
                ColumnSeries<_Change, String>(
                  dataSource: data1,
                  xValueMapper: (_Change change, _) => change.code,
                  yValueMapper: (_Change change, _) => change.change,
                  name: '',
                  dataLabelSettings: DataLabelSettings(isVisible: false),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          Text("Liman 9",style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[100],
                  child:  createChart1('ABG', _fonlist1),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[100],
                  child: createChart1('TAU', _fonlist2),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[100],
                  child: createChart1('YZH', _fonlist3),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[100],
                  child: createChart1('RYF', _fonlist4),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[100],
                  child: createChart1('ZBP', _fonlist5),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[100],
                  child: createChart1('ADP', _fonlist6),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[100],
                  child: createChart1('BLH', _fonlist7),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[100],
                  child: createChart1('YCP', _fonlist8),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[100],
                  child: createChart1('BDI', _fonlist9),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget createChart1(String title, List<Map<String,dynamic>> data) {
    return Container(
      child: data.isEmpty
          ? Center(child: CircularProgressIndicator())
          :SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: title), // Set chart title

        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<Map<String,dynamic>, String>>[
          LineSeries<Map<String,dynamic>, String>(

            dataSource: data,
            xValueMapper: (Map<String, dynamic> map1, _) => map1.values.elementAtOrNull(2),
            yValueMapper: (Map<String, dynamic> map1, _) => map1.values.elementAtOrNull(5),
            // name: 'AAK', // Customize name for each chart if needed
            dataLabelSettings: DataLabelSettings(isVisible: false),
          ),
        ],
      ),
    );
  }
Future<void> getLastMonthFund(String fund,List<Map<String,dynamic>> fonlist) async {
  final String query_add = 'funds/get_last_month_data?value=$fund&by=fund_code';
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
        fonlist.addAll(jsonDecode(response.body).cast<Map<String,dynamic>>());
        print("Fon list signed");
      });
    } else {
      setState(() {
        fonlist = jsonDecode(response.body);
      });
    }
  } catch (e) {
    print("Error: $e");
  }
}
}

class _Change {
  _Change( this.code,  this.change);
  final String code;
  final double change;


}
