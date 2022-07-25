import 'package:appedvies/src/models/curso.dart';
import 'package:appedvies/src/models/route_argument.dart';
import 'package:appedvies/src/pages/materiales_curso_page.dart';
import 'package:appedvies/src/providers/db_provider.dart';
import 'package:appedvies/src/repositorios/login_repository.dart' as repol;
import 'package:appedvies/src/utils.dart';
import 'package:flutter/material.dart';

class AsignaturasPage extends StatefulWidget {
  const AsignaturasPage({Key? key}) : super(key: key);

  @override
  State<AsignaturasPage> createState() => _AsignaturasPageState();
}

class _AsignaturasPageState extends State<AsignaturasPage> {
  List<Curso> lCursos =[];
  bool cargando = false;
  String apitoken ='';
  @override
  void initState() {
    super.initState();
    obtieneCursos();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:
      cargando
      ?CircularProgressIndicator()
      :SingleChildScrollView (
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: lCursos.length,
          itemBuilder: (context,index ){
            return tile(lCursos.elementAt(index));
          })
      ),
      ); 
  }

  Widget tile(Curso curso){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
          style: BorderStyle.solid),
        //color: Theme.of(context).primaryColor ,
        borderRadius: BorderRadius.circular(20.0)
      ),
      margin: EdgeInsets.only(top:10,right: 7,left: 7),
    
      child: ListTile(
                  onTap: (){
                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MaterialesCursoPage(
                                      routeArgument: RouteArgument(
                                          id: "0", param: [curso]),
                                    ),
                                  ),
                                );
                    print(curso.name);
                  },
                  leading: CircleAvatar(
                    backgroundColor: colorXtipo(0),
                    child: Text(genIniciales(curso.name!).toUpperCase(), ), ),
                  trailing: Icon(Icons.arrow_right,color: Theme.of(context).primaryColorDark,),
                  title:Text(curso.name??"Sin nombre",maxLines: 1, overflow: TextOverflow.ellipsis, ),
                  subtitle: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(curso.classname??"SIn datos",style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(curso.recommended??"Sin recomendaciones",style: TextStyle(fontStyle: FontStyle.italic),maxLines: 1, overflow: TextOverflow.ellipsis)
                    ],
                  ),
                ),
    );
  }

  obtieneCursos ()async{
      cargando= true;
      setState(() {});
      apitoken = await repol.getApiToken();
      lCursos = await DBProvider.db.getTodosCursos();
      cargando= false;
      setState(() {});

  } 
}