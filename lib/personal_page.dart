import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class PersonalPage extends StatefulWidget {
  @override
  _ProfilSayfasiState createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<PersonalPage> {
  final String api_key = "s67fd6sg67asd67g4sdd3gahfgsdl26875768dfasfsf78sdg78s8g89l568";
  final String apiUrl = 'http://192.168.1.102:8000/';
  Map<String,dynamic> _m = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser(1);
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
      body: Center(
        child: SingleChildScrollView(
          child: _m.isEmpty ? Center(child: CircularProgressIndicator())
           : Column(
            children: [
              // Profil resmi
              Image.asset('assets/11.png',
                width: 200, // Set the desired width, height adjusts automatically
                fit: BoxFit.contain, ),


            // Hesap detayları
              Card(
                child: Column(
                  children: [
                    // Kullanıcı adı
                    ListTile(
                      title: Text('Kullanıcı Adı'),
                      subtitle: Text(_m.values.elementAt(3)),
                    ),

                    // Ad soyad
                    ListTile(
                      title: Text('Ad Soyad'),
                      subtitle: Text(_m.values.elementAt(2)),
                    ),

                    // Organizasyon
                    ListTile(
                      title: Text('Password'),
                      subtitle: Text(_m.values.elementAt(4)),
                    ),

                    // Lokasyon
                    ListTile(
                      title: Text('TimeStamp'),
                      subtitle: Text(_m.values.elementAt(1)),
                    ),

                    // E-posta adresi
                    ListTile(
                      title: Text('E-posta Adresi'),
                      subtitle: Text(_m.values.elementAt(5)),
                    ),

                    // Telefon numarası


                    // Değişiklikleri kaydet
                    ElevatedButton(
                      child: Text('Değişiklikleri Kaydet'),
                      onPressed: () {

                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _getUser(int value, {String by = "_id"}) async {
    final String query_add = 'users/get_user?value=$value&by=_id';
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
        setState(() {
          String responseBody = utf8.decode(response.bodyBytes);
          _m = jsonDecode(responseBody);
        });
      } else {
        setState(() {
          String responseBody = utf8.decode(response.bodyBytes);
          _m = jsonDecode(responseBody);
        });
      }
    } catch (e) {
      print("Error : $e");
    }
  }
}
