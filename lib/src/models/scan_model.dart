import 'dart:convert';
import 'package:latlong/latlong.dart';

class ScanModel {
    int id;
    String tipo;
    String scan;

    ScanModel({
        this.id,
        this.tipo,
        this.scan,
    }) {
      if(this.scan.contains('http')) {
        this.tipo = 'http';
      } else {
        this.tipo = 'geo';
      }
    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        scan: json["scan"],
    );


    // para retornar un mapa, convertible a json con dart.convert
    Map<String, dynamic> toJsonMap() => {  
        "id": id,
        "tipo": tipo,
        "scan": scan,
    };


    LatLng getLatLng() {
      final latlng = scan.substring(4).split(',');
      final lat = double.parse(latlng[0]);
      final lng = double.parse(latlng[1]);

      return LatLng(lat,lng);
    }
}
