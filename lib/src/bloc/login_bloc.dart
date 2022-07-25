import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'Validators.dart';
//import 'package:prueba_ventas/src/bloc/validators.dart';

//import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{
  //  final _emailController = StreamController<String>.broadcast();
  // final _passwordController = StreamController<String>.broadcast();

   final _emailController = BehaviorSubject<String>();
   final _passwordController = BehaviorSubject<String>();


  Stream<String> get emailStream => _emailController.stream.transform(validarEmail) ;
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream => 
       CombineLatestStream([emailStream,passwordStream], (ls)=>true); 

  Function (String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String email ()=>_emailController.value;
  String password ()=>_passwordController.value;


  dispose(){
    _emailController.close();
    _passwordController.close();
  }
}