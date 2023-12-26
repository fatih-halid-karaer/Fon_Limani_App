
import 'dart:math';

import 'package:arastirma/api2.dart';
import 'package:arastirma/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final String api_key = "s67fd6sg67asd67g4sdd3gahfgsdl26875768dfasfsf78sdg78s8g89l568";
  final String apiUrl = 'http://192.168.1.108:8000/';

  TextEditingController _textFieldController = TextEditingController();

  Map<String, dynamic> _fon = {};
  List<Map<String,dynamic>> _list3 = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllFundsInfo(_list3);
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
              // Burada butona tıklandığında yapılacak işlemleri ekleyebilirsiniz.
              // Örneğin, belirli bir web sitesine yönlendirme yapabilirsiniz.
              // Navigator.push yerine belirli bir URL'ye yönlendirme yapabilirsiniz.
              // Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));
              launchUrl("https://0.0.0.0/fon/{${_textFieldController.text}}?date=1" as Uri);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                hintText: 'Fon Arayın...',
                hintStyle: TextStyle(color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  color: Colors.blue,
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    _getFund(_textFieldController.text);
                    print(_list3.length);
                  },
                ),
              ),
            ),

            SizedBox(height: 16.0),
            // Display the fund details using ListView.builder
            Expanded(
              child:_textFieldController.text.isEmpty
                  ?  ListView.builder(
                     itemCount: _list3.length,
                     itemBuilder: (context, index) {
                       return Card(
                         color: Colors.blue,
                         elevation: 3.0,
                         margin: EdgeInsets.symmetric(vertical: 8.0),
                         child: ListTile(
                           title: Text(_list3[index]["fund_code"],style: TextStyle(color: Colors.white),),
                           subtitle: Text(
                               "${_list3[index]["fund_name"]}",style: TextStyle(color: Colors.white),),

                           trailing: IconButton(
                             icon: Icon(Icons.arrow_forward),
                             color: Colors.white,
                             onPressed: () {
                               // Handle the URL navigation or any other action
                               launchURL(_list3[index]["fund_url"]);
                             },
                           ),),
                       );
                     },
                   )


                  : ListView.builder(
                itemCount: _fon.keys.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blue,
                    elevation: 3.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text("${_fon.keys.elementAt(index + 1)}",style: TextStyle(color: Colors.white),),
                      subtitle: Text("${_fon.values.elementAt(index + 1)}",style: TextStyle(color: Colors.white),),
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

  Future<void> _getFund(String code ) async {
    final String query_add = 'funds/get_fund_information?value=$code&by=fund_code';
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
          String responseBody = utf8.decode(response.bodyBytes);
          _fon = jsonDecode(responseBody);
        });
      } else {
        setState(() {
          String responseBody = utf8.decode(response.bodyBytes);
          _fon = jsonDecode(responseBody);
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  Future<void> _getAllFundsInfo(List<Map<String,dynamic>> list) async {
    final String query_add = 'funds/get_all_funds_detailed';
    try {
      http.Response response = await http.get(
        Uri.parse(apiUrl + query_add),
        headers: {
          'api_key': api_key,
        },
      );

      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        list.addAll(jsonDecode(responseBody).cast<Map<String,dynamic>>());
        print("All funds added");
        // Handle the data as needed
      } else {
        String responseBody = utf8.decode(response.bodyBytes);
        list.addAll(jsonDecode(responseBody).cast<Map<String,dynamic>>());
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error, e.g., show an error message to the user
    }
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
}