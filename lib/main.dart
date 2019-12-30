import 'package:flutter/material.dart';
import 'package:qrreader/src/pages/home_page.dart';
import 'package:qrreader/src/pages/mapa_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QRReader',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home'      : (BuildContext context) => HomePage(),
        'mapa'      : (BuildContext context) => MapaPage(),
      },
      theme: ThemeData(
        primaryColor: Color(0xff34A74D),
        buttonColor: Color(0xffffd001)
      ),
    );
  }
}