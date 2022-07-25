import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'Validators.dart';
//import 'package:prueba_ventas/src/bloc/validators.dart';

//import 'package:rxdart/rxdart.dart';

class RegistroBloc with Validators{
  //  final _emailController = StreamController<String>.broadcast();
  // final _passwordController = StreamController<String>.broadcast();

   final _emailrController = BehaviorSubject<String>();
   final _passwordrController = BehaviorSubject<String>();
   final _nombrerController =  BehaviorSubject<String>();
   final _fechaNacrController =  BehaviorSubject<String>();

  Stream<String> get emailrStream => _emailrController.stream.transform(validarEmailr) ;
  Stream<String> get passwordrStream => _passwordrController.stream.transform(validarPasswordr);
  Stream<String> get nombrerStream => _nombrerController.stream.transform(validarNombrer) ;
  Stream<String> get fechaNacrStream => _fechaNacrController.stream.transform(validarFechaNacr);
  

  Stream<bool> get formValidStream => 
       CombineLatestStream([emailrStream,passwordrStream,nombrerStream], (ls)=>true); 

  Function (String) get changeEmailr => _emailrController.sink.add;
  Function(String) get changePasswordr => _passwordrController.sink.add;
  Function (String) get changeNombrer => _nombrerController.sink.add;
  Function(String) get changeFechaNacr => _fechaNacrController.sink.add;
  

  String email ()=>_emailrController.value;
  String password ()=>_passwordrController.value;
  String nombre ()=>_nombrerController.value;
  String fechaNac ()=>_fechaNacrController.value;
  


  dispose(){
    _emailrController.close();
    _passwordrController.close();
    _nombrerController.close();
    _fechaNacrController.close();
  }
}