
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qrreader/src/models/scan_model.dart';
export 'package:qrreader/src/models/scan_model.dart';


class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._(); //constructor privado


  DBProvider._(); // Constructor privad

  Future<Database> get database async {
    if( _database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async{

    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join( documentsDirectory.path, 'ScansDB.db' );

    return await openDatabase(
      path,
      version: 1,
      onOpen:  (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans ('
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'scan TEXT'
          ')'
        );
      }
    ); 

  }


  //Crear Registros "RAW"
  nuevoScanRaw(ScanModel scan) async {

    final db = await database;
    final res = await db.rawInsert(
      "INSERT INTO Scans (id, tipo, scan) "
      "VALUES (${scan.id},'${scan.tipo}','${scan.scan}');"
    );

    return res;

  }


  nuevoScan(ScanModel scan) async {
    final db = await database;
    final res = await db.insert('Scans', scan.toJsonMap());

    return res;
  }



  // SELECTS - Obtener datos
  Future<ScanModel> getScan(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;

  }


  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty 
    ? res.map((c) => ScanModel.fromJson(c)).toList()
    : [];

    return list;
  }


    Future<List<ScanModel>> getAllScansTipo(String tipo) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);

    

    List<ScanModel> list = res.isNotEmpty 
    ? res.map((c) => ScanModel.fromJson(c)).toList()
    : [];

    return list;
  }
  


  //update
  Future<int> updateScan(ScanModel scan ) async {
    final db = await database;
    final res = await db.update('Scans', scan.toJsonMap(), where: 'id = ?', whereArgs: [scan.id]);

    return res;
  }


  Future<int> deleteScan(int id ) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }


  Future<int> deleteAll() async {

    final db = await database;
    final res = await db.delete('Scans');

    return res;

  }




}