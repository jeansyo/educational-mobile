
import 'package:appedvies/src/models/materiale.dart';
import 'package:appedvies/src/providers/db_provider.dart';
import 'package:appedvies/src/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
class UltimoMaterialPage extends StatefulWidget {
  const UltimoMaterialPage({Key? key}) : super(key: key);

  @override
  State<UltimoMaterialPage> createState() => _UltimoMaterialPageState();
}

class _UltimoMaterialPageState extends State<UltimoMaterialPage> {
  bool downloading =false;
  String progress = '0';
  bool isDownloaded = false;
  
  bool cargando =false;

  List<Materiale> lmaterialesRecientes=[];

  List<Materiale> lmaterialesLocal=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.obtieneUltimosMateriales();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(child: 
        cargando
        ? Center(child: CircularProgressIndicator())
        :ListView.builder( 
          itemCount: lmaterialesRecientes.length,
          itemBuilder:(BuildContext context,index){
            return _material(lmaterialesRecientes.elementAt(index));
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
                        child: Container(child: Icon(Icons.more_vert)),
                      ),
                      SizedBox(height: 5.0,),
              materiale.descargado == 1
                    ?Icon(Icons.check,size:20.0, color: Theme.of(context).primaryColor , )
                    :Icon (Icons.check,size:20.0, ),
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
          await obtieneUltimosMateriales();
          isDownloaded = true;
          if (materi.type == 1) {
            OpenFile.open(savePath);
          }
           mostrarSnackbar(context, '¡El recurso se descargo!', Theme.of(context).primaryColor, Colors.white, 1500);
        }
        
      });
     
      
    })
    .onError((error, stackTrace){
      downloading=false;
      progress='0';
      mostrarSnackbar(context, '', Colors.red, Colors.white, 500);
      setState(() {});
     });
  }



  obtieneUltimosMateriales()async{
    cargando=true;
    setState(() {});
    lmaterialesRecientes = await DBProvider.db.getMaterialesRecientes();
    
    for (var imat in lmaterialesRecientes ) {
        print( '*--***-${materialeToJson(imat)}' );
        // if(existeEnLocal(imat)){
        //    lmaterialesRecientes.add(imat);
        // }
    }

    cargando=false;
    setState(() {});

  } 
  

  
}