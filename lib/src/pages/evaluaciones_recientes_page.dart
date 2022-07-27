import 'package:appedvies/src/estilos.dart';
import 'package:appedvies/src/models/curso.dart';
import 'package:appedvies/src/models/evaluacion.dart';
import 'package:appedvies/src/models/route_argument.dart';
import 'package:appedvies/src/pages/evaluacion_page.dart';
import 'package:appedvies/src/repositorios/evaluacion_repository.dart' as reva;
import 'package:appedvies/src/utils.dart' as ut;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
class EvaluacionesRecientesPage extends StatefulWidget {
  Curso? curso;
  EvaluacionesRecientesPage({Key? key,this.curso}) : super(key: key);

  @override
  State<EvaluacionesRecientesPage> createState() => _EvaluacionesRecientesPageState();
}

class _EvaluacionesRecientesPageState extends State<EvaluacionesRecientesPage> {
  late Curso cursoE;
  bool cargando = false;
  String apitoken ='';
  List<Evaluacion> lEvaluacion=[]; 
  List<Evaluacion> lEvaluacionR=[]; 
  bool expansion1 =false;
  bool expansion2 =false;
  @override
  void initState() {
    super.initState();
    //initializeDateFormatting();
    cursoE = widget.curso as Curso;
    print('curssoooooo ${cursoE.classname}');
    obtieneEvaluaciones(cursoE.id??0);
    // Evaluacion eva;
    // for (var i = 0; i < 4; i++) {
    //   lEvaluacion.add( Evaluacion(
    //     name: 'evaluacion $i',
    //     state: 0,
    //     date: "2022-12-12",
    //     date2: "2022-12-13",
    //     id: i,
    //     idl:i,
    //     courseName: 'curso $i',
    //     courseId: i+1));

    // }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body:Column(
        children: [
          SizedBox(height: 20.0,),
          Text('Curso: ${this.cursoE.name}', style: Estilos.texto_barra(Colors.black54), ),
          SingleChildScrollView(
            child: Container(
              child: 
              cargando
              ?Center(child:CircularProgressIndicator())
              :ExpansionPanelList(
                animationDuration: Duration(milliseconds: 500),
                expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      if(index==0)
                      {
                        expansion1=!isExpanded;  
                        expansion2= isExpanded;
                      }
                      if(index==1)
                      {
                        expansion2=!isExpanded;
                        expansion1= isExpanded;
                      }
                        
                    });
                },
                children: <ExpansionPanel>[
                  ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      leading: Icon(Icons.note_alt_outlined,
                       color:  expansion1? Theme.of(context).primaryColor:Colors.black87),
                      title: Text('Evaluaciones Pendientes', 
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color:expansion1? Theme.of(context).primaryColor:Colors.black87),
                                ),
                    );
                    },
                    isExpanded: this.expansion1,
                   body:Container(
                    height: 450.0,
                    child:listaPendientes(context) ,
                   ) 
                   ),
                   ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      leading: Icon(Icons.checklist_rtl,
                                    color:expansion2? Theme.of(context).primaryColor:Colors.black87),
                      title: Text('Evaluaciones Resueltas',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color:expansion2? Theme.of(context).primaryColor:Colors.black87)
                                  ),
                    );
                    },
                    isExpanded: this.expansion2,
                   body:Container(
                    height: 450.0,
                    child:listaResueltas(context) ,
                   ) 
                   
                   
                   ),
                ],   
            ),
            
          )
           //Text('la coas')
          ),
        ],
      )
    );
  }

  listaPendientes(BuildContext context){
    return Container(
      child: cargando
      ?CircularProgressIndicator()
      :ListView.builder(
          shrinkWrap: true,
          itemCount: lEvaluacion.length,
          itemBuilder: (context,index ){
            return tile(lEvaluacion.elementAt(index));
          })
      
    );
  }

    Widget tile(Evaluacion evaluacion){
     // DateTime fecha1 = DateTime.parse('Jul 07 2022 20:00:00');
     // DateTime fecha = DateTime.parse('Jul 07 2022 20:00:00');
    return Container(
      decoration: BoxDecoration(
        //  ,
        //color: Theme.of(context).primaryColor ,
        borderRadius: BorderRadius.circular(20.0)
      ),
      margin: EdgeInsets.only(right: 7,left: 7),
    
      child: ListTile(
                  onTap: (){
                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EvaluacionPage(
                                      routeArgument: RouteArgument(
                                          id: "0", param: [evaluacion]),
                                    ),
                                  ),
                                );
                   // print(evaluacion.name);
                  },
                  // leading: CircleAvatar(
                  //   backgroundColor: colorXtipo(0),
                  //   child: Text(genIniciales(evaluacion.id.toString()).toUpperCase(), ), ),
                  trailing: Icon(Icons.arrow_right,color: Theme.of(context).primaryColorDark,),
                  title:Text("Evaluacion ${evaluacion.id.toString()}",maxLines: 1, overflow: TextOverflow.ellipsis, ),
                  subtitle: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Text('desde ${ut.fechaFormat(evaluacion.start??'Tue Jul 05 2022 20:00:00 GMT-0400 (hora de Venezuela)')} ',style: TextStyle(fontStyle: FontStyle.italic),maxLines: 1, overflow: TextOverflow.ellipsis),
                     Text('hasta ${ut.fechaFormat(evaluacion.end??'Tue Jul 05 2022 20:00:00 GMT-0400 (hora de Venezuela)')}',style: TextStyle(fontStyle: FontStyle.italic),maxLines: 1, overflow: TextOverflow.ellipsis),
                     Divider(height: 1.0,color: Theme.of(context).primaryColor)
                    ],
                  ),
                ),
    );
  }

  listaResueltas(BuildContext context){
    return Container(
      child: cargando
      ?CircularProgressIndicator()
      :ListView.builder(
          shrinkWrap: true,
          itemCount: lEvaluacionR.length,
          itemBuilder: (context,index ){
            return tileR(lEvaluacionR.elementAt(index));
          })
      
    );
  }

    Widget tileR(Evaluacion evaluacion){
    return Container(
      decoration: BoxDecoration(
        //  ,
        //color: Theme.of(context).primaryColor ,
        borderRadius: BorderRadius.circular(20.0)
      ),
      margin: EdgeInsets.only(right: 7,left: 7),
    
      child: ListTile(
                  onTap: (){
                   // print(evaluacion.name);
                  },
                  // leading: CircleAvatar(
                  //   backgroundColor: colorXtipo(0),
                  //   child: Text(genIniciales(evaluacion.id.toString()).toUpperCase(), ), ),
                  trailing: Text('${evaluacion.score}', style: Estilos.titMat(Colors.black), ) ,
                  title:Text("Evaluacion ${evaluacion.id?? '0' }",maxLines: 1, overflow: TextOverflow.ellipsis, ),
                  subtitle: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Text('desde ${evaluacion.date??"0000-00-00"} hasta ${evaluacion.date2??"0000-00-00 "}',style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1, overflow: TextOverflow.ellipsis),
                     // Text('${evaluacion.courseName }',style: TextStyle(fontStyle: FontStyle.italic),maxLines: 1, overflow: TextOverflow.ellipsis)
                      Text('desde ${ut.fechaFormat(evaluacion.start??'Tue Jul 05 2022 20:00:00 GMT-0400 (hora de Venezuela)')} ',style: TextStyle(fontStyle: FontStyle.italic),maxLines: 1, overflow: TextOverflow.ellipsis),
                     Text('hasta ${ut.fechaFormat(evaluacion.end??'Tue Jul 05 2022 20:00:00 GMT-0400 (hora de Venezuela)')}',style: TextStyle(fontStyle: FontStyle.italic),maxLines: 1, overflow: TextOverflow.ellipsis),
                     Divider(height: 2.0, color: Theme.of(context).primaryColor,)
                    ],
                  ),
                ),
    );
  }

  obtieneEvaluaciones (int idCurso) async {

    this.cargando=true;
    setState(() {
      
    });
//obtiene evaluaciones pendientes por curso
  Map<String,dynamic> resp = await  reva.obtenerEvaluacionesXCurso(idCurso);
  
  this.lEvaluacion = ut.quitaRep(Evaluaciones.fromJsonList(resp['result'] ).items);
  

//obtiene evaluaciones resueltas por curso

  Map<String,dynamic> respR = await  reva.obtenerEvaluacionesResueltasXCurso(idCurso);
  this.lEvaluacionR = Evaluaciones.fromJsonList(respR['result']).items ;
 print('/****************************');
  print (respR);

  this.cargando=false;
    setState(() {
      
    });
}
}