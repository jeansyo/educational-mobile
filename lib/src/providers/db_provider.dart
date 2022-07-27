
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/curso.dart';
import '../models/materiale.dart';

class DBProvider{

  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }
  initDB () async {
    Directory documentsDirectory= await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,'EducationDB.db');
    return await openDatabase(
      path,
      version: 4,
      onOpen: (db){},
      onCreate: (Database db,int version) async{
        await db.execute(
          'CREATE TABLE Curso('
           'idl INTEGER PRIMARY KEY AUTOINCREMENT, '
           'id INTEGER NOT NULL UNIQUE, '
           'name TEXT, '
           'students INTEGER,'
           'classname TEXT, '
           'recommended TEXT'
          ')'
        );
        await db.execute(
          'CREATE TABLE Materiale('
           'idl INTEGER PRIMARY KEY AUTOINCREMENT, '
            'name TEXT, '
            'filename TEXT, '
            'link TEXT, '
            'type INTEGER, '
            'date TEXT, '
            'id INTEGER NOT NULL UNIQUE, '
            'courseName TEXT, '
            'courseID INTEGER, '
            'descargado INTEGER DEFAULT 0, '
            'esReciente INTEGER DEFAULT 0'
          ')'
        );
   
      }

    ); 
  }

  //CREAR REGISTROS PARA CURSOS
  
  Future<int> nuevoCurso(Curso nuevoCurso) async{
    final db = await database;
    final res = await db.insert('Curso', nuevoCurso.toJson(),conflictAlgorithm: ConflictAlgorithm.ignore);
    return res;
  }

  //select -obtener iinformacion
  Future<Curso?>getCursoId(int id) async {
    final db =await database;
    final res = await db.query('Curso',where: 'id=?',whereArgs: [id]);
    return res.isNotEmpty? Curso.fromJson(res.first):null ;
  }

Future<List<Curso>>getTodosCursos() async {
    final db =await database;
    final res = await db.query('Curso');
    List <Curso> list = res.isNotEmpty
              ? res.map((e) => Curso.fromJson(e)).toList()
              :[] ;
    return list;
  }


  //actualizar 
  Future<int> updateCurso(Curso nuevoCurso)async{
    final db = await database;
    final res = await db.update('Curso', nuevoCurso.toJson(),where: 'id =?',whereArgs: [nuevoCurso.id]);
    return res;
  }
  //eliminarregistros
  Future<int>deleteCurso(int id) async{
    final db = await database;
    final res = await db.delete('Curso',where: 'id=?',whereArgs: [id]);
    return res;
  }

  //eliminarregistros
  Future<int>deleteCursoAll () async{
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Curso');
    return res;
  }

  //CREAR REGISTROS PARA MATERIALES*/*///******************* */
  
  Future<int> nuevoMateriale(Materiale nuevoMateriale) async{
    final db = await database;
    final res = await db.insert('Materiale', nuevoMateriale.toJson(),conflictAlgorithm: ConflictAlgorithm.ignore);
    return res;
  }

  //select -obtener iinformacion
  Future<Materiale?>getMaterialeId(int id) async {
    final db =await database;
    final res = await db.query('Materiale',where: 'id=?',whereArgs: [id]);
    return res.isNotEmpty? Materiale.fromJson(res.first):null ;
  }
//select -obtener iinformacion
  Future<Materiale?>getMaterialeIdCurso(int idc) async {
    final db =await database;
    final res = await db.query('Materiale',where: 'courseId=?',whereArgs: [idc]);
    return res.isNotEmpty? Materiale.fromJson(res.first):null ;
  }

Future<List<Materiale>>getTodosMateriales() async {
    final db =await database;
    final res = await db.query('Materiale');
    List <Materiale> list = res.isNotEmpty
              ? res.map((e) => Materiale.fromJson(e)).toList()
              :[] ;
    return list;
  }

Future<List<Materiale>>getMaterialesRecientes() async {
    final db =await database;
    final res = await db.query('Materiale',where: 'esReciente = 1');
    List <Materiale> list = res.isNotEmpty
              ? res.map((e) => Materiale.fromJson(e)).toList()
              :[] ;
    return list;
  }
Future<List<Materiale>>getMaterialesByIdCurso(int idCurso) async {
    final db =await database;
    final res = await db.query('Materiale',where: 'courseID = ?',whereArgs: [idCurso]);
    List <Materiale> list = res.isNotEmpty
              ? res.map((e) => Materiale.fromJson(e)).toList()
              :[] ;
    return list;
  }

   //contar materiales por estado de descarga y curso al que pertenece
  Future<int>contarMaterialesXestadoYCurso(int id_curso,int estado) async{
    final db = await database;
    final res = await db.rawQuery('SELECT COUNT (*) as cant from Materiale where descargado = $estado and courseID =$id_curso');
    print ("materiales estado");
    print (res[0]["cant"]);
    return  int.parse(res[0]["cant"].toString()) ;
  }

   //contar materiales por estado de descarga
  Future<int>contarMaterialesXCurso(int id_curso) async{
    final db = await database;
    final res = await db.rawQuery('SELECT COUNT (*) as cant from Materiale where courseID =$id_curso');
    print ("total por curso");
    print (res[0]["cant"]);
    return  int.parse(res[0]["cant"].toString()) ;
  }

  //actualizar 
  Future<int> updateMateriale(Materiale nuevoMateriale)async{
    final db = await database;
    final res = await db.update('Materiale', nuevoMateriale.toJson(),where: 'id =?',whereArgs: [nuevoMateriale.id]);
    return res;
  }
  ////cerear 
  Future<int> cerearReciente()async{
    final db = await database;
    final res = await db.rawUpdate('UPDATE Materiale set esReciente = 0');
    return res;
  }
  ////cambiar estado de reciente 
  Future<int> updateReciente(int estado, int id)async{
    final db = await database;
    final res = await db.rawUpdate('UPDATE Materiale set esReciente = $estado where id=$id');
    return res;
  }

  ////cambiar estado de descargado
  Future<int> updateDescargado(int estado, int id)async{
    final db = await database;
    final res = await db.rawUpdate('UPDATE Materiale set descargado = $estado where id=$id');
    return res;
  }


  //eliminarregistros
  Future<int>deleteMateriale(int id) async{
    final db = await database;
    final res = await db.delete('Materiale',where: 'id=?',whereArgs: [id]);
    return res;
  }

  //eliminarregistros
  Future<int>deleteMaterialeAll () async{
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Materiale');
    return res;
  }
}