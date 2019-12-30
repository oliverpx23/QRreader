


import 'package:flutter/material.dart';
import 'package:qrreader/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

abrirScan(BuildContext context, ScanModel scanData) async {

  if(scanData.tipo == 'http') {
    if (await canLaunch(scanData.scan)) {
      await launch(scanData.scan);
    } else {
      throw 'Could not launch ${scanData.scan}';
    }
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scanData);
  }

}