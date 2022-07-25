import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'Validators.dart';
class PerfilBloc with Validators{
 

   final _nombreControllerp = BehaviorSubject<String>();
   
   final _passwordaControllerp = BehaviorSubject<String>();
   final _passwordbControllerp = BehaviorSubject<String>();
   final _passwordControllerp = BehaviorSubject<String>();

   
     //StreamTransformer<String, String> validarNombrep; 

  Stream<String> get nombreStreamp => _nombreControllerp.stream.transform(validarNombrep) ;
  Stream<String> get passwordaStreamp => _passwordaControllerp.stream.transform(validarPasswordap);
  Stream<String> get passwordbStreamp => _passwordbControllerp.stream.transform(validarPasswordbp);
  Stream<String> get passwordStreamp => _passwordControllerp.stream.transform(validarPasswordp);


  Stream<bool> get formValidStream => 
       CombineLatestStream([nombreStreamp,passwordaStreamp,passwordbStreamp], (ls)=>true); 

  Function (String) get changeNombrep => _nombreControllerp.sink.add;
  Function(String) get changePasswordap => _passwordaControllerp.sink.add;
  Function(String) get changePasswordbp => _passwordbControllerp.sink.add;
  Function(String) get changePasswordp => _passwordControllerp.sink.add;

  String nombrep ()=>_nombreControllerp.value;
  String passwordap ()=>_passwordaControllerp.value;
  String passwordbp ()=>_passwordbControllerp.value;
  String passwordp ()=>_passwordControllerp.value;

  dispose(){
    _nombreControllerp.close();
    _passwordaControllerp.close();
    _passwordbControllerp.close();
    _passwordControllerp.close();
  }
}