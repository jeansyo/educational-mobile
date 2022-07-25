// obteniendo  medicos por especialidad

import 'dart:convert';
import 'dart:io';
import '../repositorios/login_repository.dart' as repol;
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

Future<Map<String,dynamic>> obtenerCursos() async {
    // Uri uri = Helper.getUriLfr('api/producto');
    String apiToken = await repol.getApiToken();
    try {
      if (apiToken != null && apiToken.isNotEmpty) {
        final String url =
                '${GlobalConfiguration().get('base_url').toString()}my/courses';
        print(url);
        var uri = Uri.parse(url);
        final client = http.Client();
        final response = await client.get(uri,
            headers: {
              HttpHeaders.acceptHeader:'*/*',
              'X-token':apiToken
              });
        if (response.statusCode == 200) {
          //print(response.body);
          String respuestaStr = const Utf8Decoder().convert(response.bodyBytes);
          final Map<String, dynamic> lcursos = json.decode(respuestaStr);
         // Cursos lcursos = Cursos.fromJsonList(lcitas);
          return  lcursos;
        } else if (response.statusCode == 401) {
          Map<String, dynamic> citaprov = {
            "result":[],
            "api":{
            "codeError": response.statusCode.toString(),
            "date": "",
            "msgError": "Inicie sesión"
            }
          };
          return citaprov;
        } else {
         Map<String, dynamic> citaprov = {
            "result":[],
            "api":{
            
            "codeError": response.statusCode.toString(),
            "date": "",
            "msgError": "Sin datos"
            }
          };
          return citaprov;
        }
      } else {
        //mostrar mensaje de authenticación
        Map<String, dynamic> citaprov = {
          "result":[],
          "api":{
            
            "codeError": "401",
            "date": "",
            "msgError": "Sin datos"
            }
        };
        return citaprov;
      }
    } catch (e) {
      // print(CustomTrace(StackTrace.current, message: e.toString()).toString());
      //print('error en repository al llenar '+e.toString());
      return {
        "result":[],
        "api":{
            "codeError": "500",
            "date": "",
            "msgError": "Error de conexión"
            }
      };
    }
  }

  Future<Map<String,dynamic>> obtenerCursoById(int id) async {
    // Uri uri = Helper.getUriLfr('api/producto');
    String apiToken = await repol.getApiToken();
    try {
      if (apiToken != null && apiToken.isNotEmpty) {
        final String url =
                '${GlobalConfiguration().get('base_url').toString()}courses/$id';
       // print(url);
        var uri = Uri.parse(url);
        final client = http.Client();
        final response = await client.get(uri,
            headers: {
              HttpHeaders.acceptHeader:'*/*',
              'X-token':apiToken
              });
        if (response.statusCode == 200) {
          //print(response.body);
          String respuestaStr = const Utf8Decoder().convert(response.bodyBytes);
          final Map<String, dynamic> lcursos = json.decode(respuestaStr);
         // Cursos lcursos = Cursos.fromJsonList(lcitas);
          return  lcursos;
        } else if (response.statusCode == 401) {
          Map<String, dynamic> citaprov = {
            "result":{},
            "api":{
            "codeError": response.statusCode.toString(),
            "date": "",
            "msgError": "Inicie sesión"
            }
          };
          return citaprov;
        } else {
         Map<String, dynamic> citaprov = {
            "result":{},
            "api":{
            
            "codeError": response.statusCode.toString(),
            "date": "",
            "msgError": "Sin datos"
            }
          };
          return citaprov;
        }
      } else {
        //mostrar mensaje de authenticación
        Map<String, dynamic> citaprov = {
          "result":{},
          "api":{
            
            "codeError": "401",
            "date": "",
            "msgError": "Sin datos"
            }
        };
        return citaprov;
      }
    } catch (e) {
      // print(CustomTrace(StackTrace.current, message: e.toString()).toString());
      //print('error en repository al llenar '+e.toString());
      return {
        "result":{},
        "api":{
            "codeError": "500",
            "date": "",
            "msgError": "Error de conexión"
            }
      };
    }
  }