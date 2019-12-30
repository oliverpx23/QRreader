import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreader/src/models/scan_model.dart';




class MapaPage extends StatefulWidget {
  

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  final mapctrl = new MapController();
  String tipoMapa = 'streets';

  @override
  Widget build(BuildContext context) {

    final ScanModel scanData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              mapctrl.move(scanData.getLatLng(), 15);
            },
          )
        ],
      ),
      body: _crearFlutterMap(scanData),
      floatingActionButton: _crearFloatingB(context),
    );
  }

  Widget _crearFlutterMap(ScanModel scanData) {

    return FlutterMap(
      mapController: mapctrl,
      options: MapOptions(
        center: scanData.getLatLng(),
        zoom: 15
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scanData)
      ],
    );

  }

  TileLayerOptions _crearMapa() {

    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1Ijoib2xpdmVycHgiLCJhIjoiY2s0cnE3b3hkMWpzazNlczcyMnIzZWIzaCJ9.DfO5SSdTIyHV5ZFQpjyK7g',
        'id': 'mapbox.$tipoMapa' //streets, dark, light, outdoors, satelite
      }
    );

  }

  _crearMarcadores(ScanModel scanData) {
    return MarkerLayerOptions(
      markers: <Marker> [
        Marker(
          width: 100.0,
          height: 100.0,
          point: scanData.getLatLng(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on, 
              size: 70.0,
              color: Theme.of(context).primaryColor
            ),
          )
        )
      ]
    );
  }

  Widget _crearFloatingB(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).buttonColor,
      onPressed: () {

        setState(() {
          if(tipoMapa == 'streets') {
            tipoMapa = 'dark';
          } else if (tipoMapa == 'dark') {
            tipoMapa = 'light';
          } else if (tipoMapa == 'light') {
            tipoMapa = 'outdoors';
          } else if (tipoMapa == 'outdoors') {
            tipoMapa = 'satellite';
          } else {
            tipoMapa = 'streets';
          }
        });

      },
    );
  }
}