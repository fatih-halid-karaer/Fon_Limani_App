import 'dart:convert';

import 'package:arastirma/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final String _apiKey = "46837fe442f20adb0f8f74957fdba342";

  final String _baseUrl = "http://api.exchangeratesapi.io/v1/latest?access_key=";
double _sonuc = 0;
  Map<String,double> _oranlar = {};

  TextEditingController _cnt = TextEditingController();
 String _secilenkur = "USD";
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verileriCek();
    });
  }
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
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:  _cnt,
                    keyboardType:  TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)
                    ),
                  ),
                    onChanged: (String yeniDeger){
                      _hesapla();
                    },
                ),),
                SizedBox(width : 16),
                DropdownButton<String>(
                    value: _secilenkur,
                    icon: Icon(Icons.arrow_downward),
                    underline: SizedBox(),
                    items: _oranlar.keys.map((String kur) {
                      return DropdownMenuItem<String>(value: kur,
                      child: Text(kur),);

                    }).toList(),
                    onChanged: (String? yeniDeger){
                     if(yeniDeger != null){
                       setState((){
                         _secilenkur = yeniDeger;
                         _hesapla();
                          }
                           );
                    } }),
              ],
            ),
            SizedBox(height: 16,),
            Text("${_sonuc.toStringAsFixed(2)} TL",style: TextStyle(fontSize: 24),),
            Container(
              height: 2,
                color: Colors.black,
            ),
            SizedBox(height: 16,),
            Expanded(
              child: _oranlar.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  :ListView.builder(
                itemCount: _oranlar.keys.length,
                  itemBuilder: _buildListItem,),
            )
    ],

        ),
      ),
       );
  }
  Widget _buildListItem(BuildContext context,int index) {
    return ListTile(
      title: Text(_oranlar.keys.toList()[index]),
      trailing: Text(_oranlar.values.toList()[index].toStringAsFixed(2)),
    );
  }
void _hesapla(){
    double? deger = double.tryParse(_cnt.text);
    double? oran = _oranlar[_secilenkur];
    if(deger != null && oran != null){
      setState(() {
      _sonuc = deger *oran;
      });
    }
  }
  void _verileriCek() async{
    Uri uri = Uri.parse(_baseUrl + _apiKey);
    http.Response response = await http.get(uri);
    Map<String, dynamic> parsedResponse = jsonDecode(response.body);

    Map<String,dynamic> rates = parsedResponse["rates"];
    double? baseTlkuru = rates["TRY"];
    if(baseTlkuru != null){
      for(String ulkekuru in rates.keys){
        double? baseKur = double.tryParse(rates[ulkekuru].toString());
        if(baseKur != null){
          double tlKuru = baseTlkuru / baseKur;
          _oranlar[ulkekuru] = tlKuru;
        }
      }
      setState(() {

      });
    }
  }

  }



