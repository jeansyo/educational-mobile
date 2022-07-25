import 'dart:async';
import 'package:appedvies/src/models/materiale.dart';
import 'package:appedvies/src/providers/db_provider.dart';
import 'package:appedvies/src/utils.dart';
import 'package:flutter/material.dart';
import 'package:appedvies/src/repositorios/curso_repository.dart' as repocu;
import 'package:appedvies/src/repositorios/login_repository.dart' as repolo;
import 'package:appedvies/src/repositorios/materiale_repository.dart' as repoma;


import '../models/curso.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);
  static final String title = 'Splash';
  @override
  _SplashPageState createState() => _SplashPageState(title);
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;
  int _start = 1;

  bool cargando=false;
  List<Curso> cursos =[];

  _SplashPageState(String title) : super() {
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: const Image(
                    image: AssetImage(
                      'assets/icon/logo.png',
                    ),
                    height: 100.0,
                    width: 100.0,
                    fit: BoxFit.fill,
                  ),
                ),
                Center(
                  child: Text(
                    'MICAP',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

                Center(
                  child: cargando
                  ?const CircularProgressIndicator()
                  :Container(color: Colors.transparent,),
                  )
             ],
              
            ),
            
          ],
        ),
      ),
    );
    // (
    //   child: Text('${_con.mensajeSplash} ${_start.toString() }'),
    // );
  }

  @override
  void initState() {
    super.initState();
    inicializacion();
  }

void inicializacion()async {
  this.cargando=true;
  setState(() {});
  String apitoken = await repolo.getApiToken(); 
  //await repolo.setApiToken('eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIxMyIsImlhdCI6MTY1NjM1MDY1NSwic3ViIjoiZGVtbzEyM0BnbWFpbC5jb20iLCJpc3MiOiJBdXRoQ29udHJvbGxlciIsImV4cCI6MTY1ODc2OTg1NX0.WpLVRSLZK3E_JhncAswdJV1k88L1rozUKY-S-_9FpuE');
  Map<String,dynamic> resp = await repocu.obtenerCursos(); 
  Color color =Colors.red;
  print(resp);

  Map<String,dynamic> resid;
  if(resp['api']['codeError']=="200"){
    List<Curso> lcursos = Cursos.fromJsonList(resp['result']).items ;
    for (var curso in lcursos) {
      
      resid = await cursoXId(curso);
      curso.classname = resid['result']['classname'];
      curso.recommended=resid['result']['recommended'];
      await DBProvider.db.nuevoCurso(curso);
          
        //print('*** ${cursoToJson(curso)}');
    }
    List <Curso> cursosLocal =await DBProvider.db.getTodosCursos();
    for (var curso in  cursosLocal) {
       //print('------ ${cursoToJson(curso)}');
       await inicializaMaterial(curso);
    } 
    color= Theme.of(context).primaryColor;
    if(apitoken.isNotEmpty)
    Navigator.pushNamedAndRemoveUntil(context, "/Principal", (route) => false);
    //Navigator.pushNamedAndRemoveUntil(context, "/Login", (route) => false);
    
    else
    Navigator.pushNamedAndRemoveUntil(context, "/Login", (route) => false);
  }else if(apitoken.isNotEmpty){
    
    Navigator.pushNamedAndRemoveUntil(context, "/Principal", (route) => false);
    //Navigator.pushNamedAndRemoveUntil(context, "/Login", (route) => false);
  }else{
    Navigator.pushNamedAndRemoveUntil(context, "/Login", (route) => false);
  }
  

  this.cargando=false;
  setState((){});
  mostrarSnackbar(context, resp['api']['msgError']??"sin datos", color, Colors.white, 1000);

}

Future<Map <String,dynamic> > cursoXId(Curso curso)async{
  Map<String,dynamic> resp = await repocu.obtenerCursoById(curso.id?? 0) ;
  return resp;
}

inicializaMaterial (Curso cur) async {

  Map<String,dynamic> resp = await  repoma.obtenerMateriales(cur.id!);
  Map<String,dynamic> respreci = await  repoma.obtenerMaterialesRecientes();

  List<Materiale> lmateriales = Materiales.fromJsonList(resp['result']).items;
  List<Materiale> lmaterialesRecientes = Materiales.fromJsonList(respreci['result']).items;

  for (var mat in lmateriales) {
    mat.courseId = cur.id;
    mat.courseName = cur.name;
    await DBProvider.db.nuevoMateriale(mat);
    
  }
//actualizando los materiales recientes 
  List<Materiale>lMatLocal = await DBProvider.db.getTodosMateriales();
  if (lmaterialesRecientes.isNotEmpty) {
    await DBProvider.db.cerearReciente();
    for (var mater in lmaterialesRecientes ) {
      //if(existeEnLocal(mater, lMatLocal)){
        mater.esReciente=1;
        await DBProvider.db.updateReciente(1, mater.id??0) ;
      //}
  } 
      // print('${mat.idl}----${mat.id}----${mat.courseId}----${mat.courseName}----${mat.name}-----${mat.filename}');
       
    }
}
  // void startTimer() {
  //   const oneSec = const Duration(milliseconds: 500);
  //   this._timer = new Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       if (_start == 0) {
  //         setState(() {
  //           timer.cancel();
  //           Navigator.pushNamedAndRemoveUntil(context, "/Login", (route) => false);
  //           });
  //       } else {
  //         setState(() {
  //           _start--;
  //         });
  //       }
  //     },
  //   );
  // }

  bool existeEnLocal(Materiale mattremote, List<Materiale> lmaterialesLocal ){
    for (var elem in lmaterialesLocal) {
      if(mattremote.id==elem.id){
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    //this._timer?.cancel();
    super.dispose();
  }
}