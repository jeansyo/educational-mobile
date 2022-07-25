import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
  // AUTENTICACION AL SISTEMA
  Future<Map<String, dynamic>> autenticacion(String user, String password) async {
    Map<String,dynamic> jsonlogin ={      
    "email": user,
    "password": password,
    "role": 1
    };
    //String apiToken = await RepositorioLogin().getApiToken();
    try {
      final String url =
            '${GlobalConfiguration().get('base_url').toString()}login';
      var uri = Uri.parse(url);
      final client = new http.Client();
      final response = await client.post(
        uri,
        body: json.encode(jsonlogin),
        headers: {
          HttpHeaders.contentTypeHeader:'application/json',
          HttpHeaders.acceptHeader:'*/*'
        }
        );
        
          String respuestaStr = const Utf8Decoder().convert(response.bodyBytes);
        final Map<String, dynamic> respfinal = json.decode(respuestaStr);
          return respfinal;  
        
    } catch (e) {
        return {
            "user":{},
            "api":{
            "codeError" : "Internal", 
            "msgError" : "Error en la conexion" 
          }};
    }
    //
    
  }

    // REGISTRO DE NUEVO USUARIO

  Future<Map<String, dynamic>> registro(String name, String email, String password) async {
    Map<String,dynamic> jsonRegister ={      
    "name" : name,
    "email": email,
    "password": password,
    "role": 1
    };
    //String apiToken = await RepositorioLogin().getApiToken();
    try {
      final String url =
            '${GlobalConfiguration().get('base_url').toString()}register';
      var uri = Uri.parse(url);
      final client = http.Client();
      final response = await client.post(
        uri,
        body: json.encode(jsonRegister),
        headers: {
          HttpHeaders.contentTypeHeader:'application/json',
          HttpHeaders.acceptHeader:'*/*'
        }
        );
        if(response.statusCode == 201){
          String respuestaStr = const Utf8Decoder().convert(response.bodyBytes);
        final Map<String, dynamic> respfinal = json.decode(respuestaStr);
          return respfinal;  
        }else{
          return {
            "user":{},
            "api":{
            "codeError" : response.statusCode.toString(), 
            "msgError" : "Sin datos" 
          }};
        }
    } catch (e) {
        return {
            "user":{},
            "api":{
            "codeError" : "Internal", 
            "msgError" : "Error en la conexion" 
          }};
    }
    //
    
  }


   // ACTUALIZACION DE DATOS  DE USUARIO

  Future<Map<String, dynamic>> actualizaDatos(String name, String password, String apiToken) async {
    Map<String,dynamic> jsonRegister ={      
    "name" : name,
    "password": password,
    };
    //String apiToken = await RepositorioLogin().getApiToken();
    try {
      final String url =
            '${GlobalConfiguration().get('base_url').toString()}profile';
           
      var uri = Uri.parse(url);
      final client = http.Client();
      final response = await client.put(
        uri,
        body: json.encode(jsonRegister),
        headers: {
          HttpHeaders.contentTypeHeader:'application/json',
          HttpHeaders.acceptHeader:'*/*',
          'X-token':apiToken
        }
        );
        String respuestaStr = const Utf8Decoder().convert(response.bodyBytes);
        final Map<String, dynamic> respfinal = json.decode(respuestaStr);
        print(respfinal);
        if(respfinal['api']['codeError'] == '200'){
          return respfinal;  
        }else{
          return {
           
            "api":{
            "codeError" : '400', 
            "msgError" : "Sin datos" 
          }};
        }
    } catch (e) {
        
        return {
           
            "api":{
            "codeError" : "500", 
            "msgError" : "Error en la conexion" 
          }};
    }
    //
    
  }



  //#Region recuperación de recursos almacenados en el mismo celular
  Future<String> getApiToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('apiToken')??"";
  }

  Future<void> setApiToken(String apiToken) async {
    if (apiToken != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('apiToken', apiToken);
    }
  }
  Future<String> getNombreUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nombreUsuario')!;
  }

  Future<void> setNombreUsuario(String nombreUsuario) async {
    if (nombreUsuario != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('nombreUsuario', nombreUsuario);
    }
  }
Future<String> getCodUsr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('codUsr')!;
  }

  Future<void> setCodUsr(String codUsuario) async {
    if (codUsuario != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('codUsr', codUsuario);
    }
  }

Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email')!;
  }

  Future<void> setEmail(String email) async {
    if (email != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
    }
  }  
Future<int> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id')!;
  }

  Future<void> setId(int id) async {
    if (id != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('id',id);
    }
  }