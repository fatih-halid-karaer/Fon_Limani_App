import 'dart:async';

import 'package:arastirma/news_page.dart';
import 'package:arastirma/personal_page.dart';
import 'package:arastirma/portfolio_page.dart';
import 'package:arastirma/search_page.dart';
import 'package:arastirma/simulate_portfolio.dart';
import 'package:arastirma/trend_analysis.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:arastirma/funds.dart';
import 'package:url_launcher/url_launcher.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  int _currentIndex1 = 0;

  final List<String> _texts = [
    'Bu metin 1',
    'Bu metin 2',
    'Bu metin 3',
  ];
  List<String> resimler = [
    'assets/eski_liman.png',
    'assets/liman_1.jpg',
    'assets/liman_2.jpg',
  ];

  String _currentText = '';
  late PageController _pageController;
  final List<Widget> _pages = [
    NewsPage(),
    SearchPage(),
    PortfolioPage(),
    TrendAnalysisPage(),
    SimulatePortfolioPage(),
    PersonalPage(),
  ];

  void _changePage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _pages[index]),
    );

  }
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex1);
    // Timer ile metin değişimi sağla
    Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        // _currentIndex'i güncelle ve dönen metni ayarla
        _currentIndex1 = (_currentIndex1 + 1) % _texts.length;
        _pageController.animateToPage(
          _currentIndex1,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Scaffold(
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
                  IconButton(
                    icon: Icon(Icons.help_outline, size: 24, color: Colors.blue),
                    onPressed: () {
                     // launchURL("https://0.0.0.0/fon/{${_textFieldController.text}}?date=1" as Uri);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.person_2, size: 24, color: Colors.blue),
                    onPressed: () {
                     _changePage(5);
                      // Add the functionality to navigate to the profile page or perform any profile-related action.
                      // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                    },
                  ),
                ],

              ),
              body: PageView.builder(
                controller: _pageController,
                itemCount: _texts.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          resimler[index],// Resimlerin isimleri örneğin 'resim_0.png', 'resim_1.png', ...
                          fit: BoxFit.cover, // Resmin sayfanın tamamını kaplamasını sağlar
                        ),
                      ),
                      /*
                      Text(
                        _texts[index],
                        style: TextStyle(fontSize: 24),
                      ), */
                    ],
                  );
                },
              ),
            ),
          ),
          Container(
            color: Colors.white, // Yan bölüm rengi
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                IconButton(
                  onPressed: () => _changePage(0),
                  icon: Icon(Icons.article, size: 24, color: Colors.blue),
                ),
                IconButton(
                  onPressed: () => _changePage(1),
                  icon: Icon(Icons.search, size: 24, color: Colors.blue),
                ),
                IconButton(
                  onPressed: () => _changePage(2),
                  icon: Icon(Icons.arrow_circle_down, size: 24, color: Colors.blue),
                ),
                IconButton(
                  onPressed: () => _changePage(3),
                  icon: Icon(Icons.trending_up, size: 24, color: Colors.blue),
                ),
                IconButton(
                  onPressed: () => _changePage(4),
                  icon: Icon(Icons.pie_chart_outline, size: 24, color: Colors.blue),
                ),


              ],
            ),
          ),



        ],
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
}