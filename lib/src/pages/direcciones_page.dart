import 'package:flutter/material.dart';
import 'package:qrreader/src/bloc/scans_bloc.dart';
import 'package:qrreader/src/models/scan_model.dart';
import 'package:qrreader/src/utils/utils.dart' as utils;


class DireccionesPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scansBloc.getScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final scans = snapshot.data;

        if(scans.length == 0) {
          return Center(child: Text('No hay informacion'));
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            onDismissed: (direction) => scansBloc.deleteScan(scans[i].id),
            direction: DismissDirection.startToEnd,
            key: UniqueKey(),
            background: Container(
              color: Colors.redAccent,
              padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
              child: Text('Desliza para eliminar', style: TextStyle(color: Colors.white),),
            ),
            child: ListTile(
              onTap: () => utils.abrirScan(context, scans[i]),
              leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor,),
              title: Text(scans[i].scan),
              subtitle: Text('ID: ${scans[i].id.toString()}'),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.greenAccent),
            ),
          ),
        );

      },
    );
  }
}
