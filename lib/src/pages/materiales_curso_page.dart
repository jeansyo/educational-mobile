import 'package:appedvies/src/estilos.dart';
import 'package:appedvies/src/models/curso.dart';
import 'package:appedvies/src/models/materiale.dart';
import 'package:appedvies/src/models/route_argument.dart';
import 'package:appedvies/src/providers/db_provider.dart';
import 'package:appedvies/src/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';



class MaterialesCursoPage extends StatefulWidget {
  RouteArgument? routeArgument;
  String? _heroTag;
  MaterialesCursoPage({Key? key,this.routeArgument}) : super(key: key){
     _heroTag = '1';
  }

  @override
  State<MaterialesCursoPage> createState() => _MaterialesCursoPageState();
}

class _MaterialesCursoPageState extends State<MaterialesCursoPage> {
  Curso? curso; 
  bool cargando=false;
  bool downloading =false;
  String progress = '0';
  bool isDownloaded = false;
  List <Materiale> lMateriales =[];
  @override
  void initState() {
    super.initState();
    curso = widget.routeArgument!.param[0] as Curso;
    cargaMateriales(curso!.id??0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            //Text(curso!.name?? ""),
            
           
          ],
        ),

     ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top:10.0),
            child: Text(
              curso!.name??'',
              style: Estilos.titulo_page(Colors.black),)
              ),
          Container(
            margin: EdgeInsets.all(5.0),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(30.0),
            //   border: Border.all(color: Theme.of(context).primaryColorDark,width: 2.0 )
            // ),
            height: MediaQuery.of(context).size.height*0.11,
            child: ListTile(
              title: Text(curso!.classname??"", maxLines: 3,  style: Estilos.titMat(Theme.of(context).primaryColorDark)),
              subtitle:  Text('Recomendaciones:   ${curso!.recommended??""}' , maxLines: 3, style: Estilos.subtitMat(Colors.black)),
            ),
            ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.70 ,
            width: double.infinity,
            child: Stack(
            children: [
              Container(child: 
              cargando
              ? Center(child: CircularProgressIndicator())
              :ListView.builder( 
                itemCount: lMateriales.length,
                itemBuilder:(BuildContext context,index){
                  return _material(lMateriales.elementAt(index));
                } 
                )
              ),
              downloading
              ?Container(height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              color: Color.fromRGBO(255, 255, 255, 0.5),
              child: Text('$progress %'),
              )
              :Container(height: 0,width:0)
            ],
    ),
          ),
        ],
      )
      
    );
  }

_showPopupMenu(Offset offset,Materiale materiald) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(left, top, 0, 0),
    items: <PopupMenuItem<String>>[
            new PopupMenuItem<String>(
                child: TextButton(
                      child: Icon(Icons.file_download),
                      onPressed: materiald.descargado == 1 
                      ?null
                      :(){
                        Navigator.pop(context);
                        descargarArchivo(materiald);
                        },
                      //style: Estilos.estiloBotoMaterial(context),
                    ), value: 'Doge'),
            new PopupMenuItem<String>(
                child:TextButton(
                    child: Icon(Icons.remove_red_eye),
                      onPressed: () async{
                      Navigator.pop(context);
                      if(materiald.descargado!=1){
                           if(materiald.type==1)
                          {
                            descargarArchivo(materiald);
                          }else
                          {
                            visualizarMaterialWeb(context,materiald);
                          } 
                          
                      }else{
                        abrirArchivoLocal(materiald.filename!);
                        //mostrarSnackbar(context, 'opcion offline', Colors.red, Colors.white, 1000);
                      }
                      

                    },),
                value: 'Lion'),
    ],
    elevation: 8.0,
  );
}
  Widget _material(Materiale materiale){

    return Container(
      
      margin: EdgeInsets.only(top: 10,right: 3,left: 3,),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor,width: 1.0),
        //color: Theme.of(context).primaryColor ,
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorXtipo(materiale.type?? 0),
          radius:40,
          child: Icon(iconoXtipo(materiale.type?? 0),size: 40.0,color: Colors.white,) ,),
        trailing: Column(
            children: [
              
              GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          _showPopupMenu(details.globalPosition,materiale);
                        },
                        child: Container(child: Icon(Icons.more_vert,color: Theme.of(context).primaryColorDark),),
                      ),
              SizedBox(height: 5.0,),
              materiale.descargado == 1
                    ?Icon(Icons.check ,size:20.0, color: Theme.of(context).primaryColor , )
                    :Icon (Icons.check, size:20.0, ),
            ],

        ),
        title: Text(materiale.name??'Sin dato' , overflow: TextOverflow.ellipsis, maxLines: 1,),
        subtitle: 
                Text(materiale.courseName??'Sin dato'),
                //Icon(icono, color: Colors.white, size: 50.0,),
                
             
      ),
    );
}

  Future<void> descargarArchivo(Materiale materi) async {
    
    setState(() {
      downloading = true;
    });

    String savePath = await ObtenerDireccionLocalArchivo(materi.filename);

    Dio dio = Dio();

    dio.download(
      materi.link!,
      savePath,
      onReceiveProgress: (rcv, total) {
        print(
            'received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');

        setState(() {
          progress = ((rcv / total) * 100).toStringAsFixed(0);
        });
        if (progress == '100') {
          downloading= false;
          setState(() {
            isDownloaded = true;       
          });
        } else if (double.parse(progress) < 100) {}
      },
      deleteOnError: true,
    ).then((_) {
      downloading = false;
      setState(() async {
        if (progress == '100') {
          progress='0';
          await DBProvider.db.updateDescargado(1, materi.id??0);
          await this.cargaMateriales(curso!.id??0) ;
          isDownloaded = true;
           if (materi.type == 1) {
            OpenFile.open(savePath);
          }
          mostrarSnackbar(context, '¡El recurso se descargo!', Theme.of(context).primaryColor, Colors.white, 1500);
        }
        
      });
      
      
    }).onError((error, stackTrace){
      downloading=false;
      progress='0';
      mostrarSnackbar(context, '', Colors.red, Colors.white, 500);
      setState(() {});
     });;
  }


  cargaMateriales(int idcurso)async{
    cargando =true;
    setState(() {});

    this.lMateriales = await DBProvider.db.getMaterialesByIdCurso(idcurso);

    cargando =false;
    setState(() {});
    

  }
}