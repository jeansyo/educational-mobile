import 'package:flutter/material.dart';

class Estilos {

  static ButtonStyle estiloBoton1(BuildContext context){
    return ElevatedButton.styleFrom(
      primary: Theme.of(context).primaryColor,
      onPrimary: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(30.0) )
      );
  }
//estilo para botones de descarga o visualizacion
  static ButtonStyle estiloBotoMaterial(BuildContext context){
    return ElevatedButton.styleFrom(
      primary: Color.fromRGBO(33, 150, 243, 0.7),
      onPrimary: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(30.0) )
      );
  }

  static TextStyle subtitMat(Color colortxt){
    return TextStyle(
      color: colortxt,
      fontSize: 12.0
    );
  }
  static TextStyle titMat(Color colortxt){
    return TextStyle(
      color: colortxt,
      fontSize: 17.0
    );
  }
  
   static TextStyle titScaf(Color colortxt){
    return TextStyle(
      color: colortxt,
      fontSize: 25.0
    );
  }
  

  static TextStyle subtitscaf(Color colortxt){
    return TextStyle(
      color: colortxt,
      fontSize: 15.0
    );
  }

  static TextStyle titulo_page(Color colortxt){
    return TextStyle(
      color: colortxt,
      fontSize: 20.0,
      fontWeight: FontWeight.bold
    );
  }

    static TextStyle texto_barra(Color colortxt){
    return TextStyle(
      color: colortxt,
      fontSize: 20.0,
      fontWeight: FontWeight.bold
    );
  }
}