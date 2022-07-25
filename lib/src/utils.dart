import 'dart:io';

import 'package:appedvies/src/bloc/perfil_bloc.dart';
import 'package:appedvies/src/models/materiale.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

Future<String> ObtenerDireccionLocalArchivo(uniqueFileName) async {
    String path = '';
    Directory dir = await getApplicationDocumentsDirectory();
    path = '${dir.path}/$uniqueFileName';
    print(path);
    return path;
  }

  void abrirArchivoLocal(String nombrea) async{
  String patin = await ObtenerDireccionLocalArchivo(nombrea);
  await OpenFile.open(patin);
}
visualizarMaterialWeb(BuildContext context,Materiale materi)async{
    if(materi.type != 1){
      var uri = Uri.parse(materi.link??'');
                    if(await canLaunchUrl(uri)){
                      
                      await launchUrl(
                      uri,
                      mode: LaunchMode.inAppWebView);
                    }else{
                      mostrarSnackbar(context, 'no se puede visualizar',Colors.red,
                       Colors.white, 1000);
                    }  
    }else{
      mostrarSnackbar(context, 'Descargue antes de visualizar',Theme.of(context).primaryColorDark,
                       Colors.white, 1500);
    } 
  }

IconData iconoXtipo(int tipo){
  
  switch (tipo) {
    case 0:
      return Icons.ondemand_video;
      break;
    case 1:
      return Icons.article_outlined ;
      break;
    case 2:
      return Icons.image;
      break;
    case 3:
      return Icons.audio_file;
      break;
    case 4:
      return Icons.document_scanner;
      break;
    default:
      return Icons.people ;
      break;
  }
}
Color colorXtipo(int tipo){
  
  switch (tipo) {
    case 0:
      return Color.fromRGBO(25, 200, 140, 0.5);
      break;
    case 1:
      return Color.fromRGBO(140,25, 200,  0.5) ;
      break;
    case 2:
      return Color.fromRGBO(25,140, 200,  0.5) ;
      break;
    case 3:
      return Color.fromRGBO(250,14, 200,  0.5) ;
      break;
    case 4:
      return Color.fromRGBO(2,14, 20,  0.5) ;
      break;
    default:
      return Color.fromRGBO(250,10, 20,  0.5) ; ;
      break;
  }
}


bool esNumerico(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);
  return (n == null) ? false : true;
}
String genIniciales(String nombre){
  String cadena='';
  List<String>cadenas = nombre.split(' ');
  for (var element in cadenas) {
    if(element.isNotEmpty)
    cadena = cadena + element.trim().substring(0,1); 
  }
  return cadena;
}


void mostrarAlerta(BuildContext context, String mensaje, String titulo) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  print(Navigator.of(context).canPop());
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar'))
          ],
        );
      });
}

void mostrarAlertaConCallBack(
    BuildContext context, PerfilBloc bloc, String mensaje, String titulo,Future< Function> callBack) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  callBack;
                },
                child: Text('Aceptar'))
          ],
        );
      });
}

mostrarSnackbar(BuildContext context, String mensaje, Color color,
    Color colorTxt, int duracion) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        mensaje,
        //"¡Cita Confirmada extosamente!",
        style: TextStyle(color: colorTxt),
      ),
      duration: Duration(milliseconds: duracion),
      backgroundColor: color //Theme.of(context).primaryColor,
      ));
}

String diaByNumero(int dia) {
  switch (dia) {
    case 1:
      return ('lunes');
      break;
    case 2:
      return ('martes');
      break;
    case 3:
      return ('miércoles');
      break;
    case 4:
      return ('jueves');
      break;
    case 5:
      return ('viernes');
      break;
    case 6:
      return ('sábado');
      break;
    default:
      return ('domingo');
      break;
  }
}

String mesByNumero(int mes) {
  switch (mes) {
    case 1:
      return ('enero');
      break;
    case 2:
      return ('febrero');
      break;
    case 3:
      return ('marzo');
      break;
    case 4:
      return ('abril');
      break;
    case 5:
      return ('mayo');
      break;
    case 6:
      return ('junio');
      break;
    case 7:
      return ('julio');
      break;
    case 8:
      return ('agosto');
      break;
    case 9:
      return ('septiembre');
      break;
    case 10:
      return ('octubre');
      break;
    case 11:
      return ('noviembre');
      break;
    case 12:
      return ('diciembre');
      break;
    default:
      return ('');
      break;
  }
}
