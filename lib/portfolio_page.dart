import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class PortfolioPage extends StatefulWidget {
  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final String api_key = "s67fd6sg67asd67g4sdd3gahfgsdl26875768dfasfsf78sdg78s8g89l568";
  final String apiUrl = 'http://192.168.1.102:8000/';

 List<Map<String,dynamic>> _list1 = [];
 List<Map<String,dynamic>> _list2 = [];
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLast_n_Reports(10, _list1);
    getLast_n_News(10, _list2);
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Raporlar listesi
            SizedBox(height: 10,),

            Text("Yayınlanan Son Raporlar", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10,),

            Container(
              height: 300,
              child: _list1.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ElevatedButton.icon(
                    onPressed: () {
                      // İlgili butona tıklandığında yapılacak işlemler
                      print("Rapor butonuna tıklandı: $index");
                      // Örnek olarak bir URL'yi açma
                      launchURL(_list1[index].values.elementAt(6));
                    },
                    icon: Icon(Icons.file_copy),
                    label: ListTile(
                      title: Text("${_list1[index].values.elementAt(2)} Aylık Raporu"),
                      subtitle: Text(_list1[index].values.elementAt(3)),
                    ),
                  );
                },
              ),
            ),
            // Haberler listesi
            SizedBox(height: 10,),

            Text("Haberler", style: TextStyle(fontSize: 20)),

            SizedBox(height: 10,),
            Container(
              height: 350,
              child: _list2.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ElevatedButton.icon(
                    onPressed: () {
                      // İlgili butona tıklandığında yapılacak işlemler
                      print("Haber butonuna tıklandı: $index");
                      // Örnek olarak bir URL'yi açma
                      launchURL(_list2[index].values.elementAt(3));
                    },
                    icon: Icon(Icons.article),
                    label: ListTile(
                      title: Text(_list2[index].values.elementAt(2),maxLines: 2,
                          ),
                      subtitle: Text(_list2[index].values.elementAt(1)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> launchURL(String url) async {
    try {
      // URL launching code here
      await launch(url);
    } catch (e) {
      print('Error launching URL: $e');
      // Handle the error as needed
    }
  }
  Future<void> getLast_n_Reports(int n,List<Map<String,dynamic>> list) async {
    final String query_add = "funds/get_last_n_reports?n=$n";
  try{
    final response = await http.get(
      Uri.parse(apiUrl + query_add),
      headers: {
        'Content-Type': 'application/json',
        'api_key': '$api_key',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        list.addAll(jsonDecode(response.body).cast<Map<String,dynamic>>());
        print("Fon list signed");
      });
    } else {
      setState(() {
        list.addAll(jsonDecode(response.body).cast<Map<String,dynamic>>());
      });
    }
  } catch (e) {
  print("Error: $e");
  }
  }
  Future<void> getLast_n_News(int n,List<Map<String,dynamic>> list) async {
    final String query_add = "news/get_last_n_news?n=$n";
    try{
      final response = await http.get(
        Uri.parse(apiUrl + query_add),
        headers: {
          'Content-Type': 'application/json',
          'api_key': '$api_key',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          String responseBody = utf8.decode(response.bodyBytes);
          list.addAll(jsonDecode(responseBody).cast<Map<String,dynamic>>());
          print("Fon list signed");
        });
      } else {
        setState(() {
          list.addAll(jsonDecode(response.body).cast<Map<String,dynamic>>());
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

}



