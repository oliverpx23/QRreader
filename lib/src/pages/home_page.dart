import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:qrreader/src/bloc/scans_bloc.dart';
import 'package:qrreader/src/models/scan_model.dart';
import 'package:qrreader/src/pages/direcciones_page.dart';
import 'package:qrreader/src/pages/mapas_page.dart';
import 'package:qrreader/src/utils/utils.dart' as utils;



class HomePage extends StatefulWidget {
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansbloc = ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansbloc.deleteAllScans,
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scanQR(context),
        backgroundColor: Theme.of(context).buttonColor,
      ),
    );

  }

  BottomNavigationBar _crearBottomNav() {
     return BottomNavigationBar(
       currentIndex: currentIndex,
       onTap: (index) {
         setState(() {
           currentIndex = index;
         });
       },
       items: [
         BottomNavigationBarItem(
           icon: Icon(Icons.map),
           title: Text('Mapas')
         ),
                  BottomNavigationBarItem(
           icon: Icon(Icons.brightness_5),
           title: Text('Direcciones')
         )
       ],
     );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0: return MapasPage();
      case 1: return DireccionesPage();
      default: return MapasPage();  
    }
  }

  void _scanQR(BuildContext context) async {

    String futureString = '';
    //String futureString = 'geo:-25.342824978607563,-57.55885019739992';

    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString();
    }

    //print('Future String: $futureString');

    if(futureString != null) {

      //print('Tenemos informacion');

      final scan = ScanModel(scan: futureString);

      scansbloc.addScan(scan);

      if(Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.abrirScan(context,scan);
        }); 
      }

      utils.abrirScan(context,scan);

      
    }
    


  }
}