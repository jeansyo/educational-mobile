import 'dart:convert';
import 'dart:io';
import '../repositorios/login_repository.dart' as repol;
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

Future<Map<String,dynamic>> obtenerEvaluacionesXCurso(int idCurso) async {
    // Uri uri = Helper.getUriLfr('api/producto');
    String apiToken = await repol.getApiToken();
    try {
      if (apiToken != null && apiToken.isNotEmpty) {
        final String url =
                '${GlobalConfiguration().get('base_url').toString()}course/$idCurso/evaluations/available';
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
          final List<dynamic> lcursos = json.decode(respuestaStr);

          Map<String, dynamic> citaprov = {
            "result":lcursos,
            "api":{
            "codeError": response.statusCode.toString(),
            "date": "",
            "msgError": "Evaluaciones encontradas"
            }
          };
         // Cursos lcursos = Cursos.fromJsonList(lcitas);
          return  citaprov;
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
      print('error en repository al llenar '+e.toString());
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

  Future<Map<String,dynamic>> obtenerEvaluacionesResueltasXCurso(int idCurso) async {
    // Uri uri = Helper.getUriLfr('api/producto');
    String apiToken = await repol.getApiToken();
    try {
      if (apiToken != null && apiToken.isNotEmpty) {
        final String url =
                '${GlobalConfiguration().get('base_url').toString()}course/$idCurso/evaluations/resolved';
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
          final List<dynamic> lcursos = json.decode(respuestaStr);

          Map<String, dynamic> citaprov = {
            "result":lcursos,
            "api":{
            "codeError": response.statusCode.toString(),
            "date": "",
            "msgError": "Evaluaciones encontradas"
            }
          };
         // Cursos lcursos = Cursos.fromJsonList(lcitas);
          return  citaprov;
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
      print('error en repository al llenar '+e.toString());
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

  Future<Map<String,dynamic>> obtenerPreguntasXEvaluacion(int ideva) async {
    // Uri uri = Helper.getUriLfr('api/producto');
    String apiToken = await repol.getApiToken();
    try {
      if (apiToken != null && apiToken.isNotEmpty) {
        final String url =
                '${GlobalConfiguration().get('base_url').toString()}course/evaluation/$ideva/questions';
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
          final List<dynamic> lcursos = json.decode(respuestaStr);

          Map<String, dynamic> citaprov = {
            "result":lcursos,
            "api":{
            "codeError": response.statusCode.toString(),
            "date": "",
            "msgError": "Evaluaciones encontradas"
            }
          };
         // Cursos lcursos = Cursos.fromJsonList(lcitas);
          return  citaprov;
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
      print('error en repository al llenar '+e.toString());
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

  
    // REGISTRO DE EVALUACION

  Future<Map<String, dynamic>> registroEvaluacion(List<Map<String,dynamic>> respuestas,int idev) async {
    // Map<String,dynamic> jsonRegister ={      
    // "name" : name,
    // "email": email,
    // "password": password,
    // "role": 1
    // };
    String apiToken = await repol.getApiToken();
    try {
      final String url =
            '${GlobalConfiguration().get('base_url').toString()}course/evaluation/test/$idev';
      print(url);
      String jsonenviar= jsonEncode(respuestas);
      print(jsonenviar);
      var uri = Uri.parse(url);
      final client = http.Client();
      final response = await client.post(
        uri,
        body: jsonenviar,
        headers: {
          HttpHeaders.contentTypeHeader:'application/json',
          HttpHeaders.acceptHeader:'*/*',
          'X-token':apiToken
        }
        );
        if(response.statusCode == 200){
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
