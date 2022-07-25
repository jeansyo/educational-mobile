import 'dart:async';


class Validators {
    String _passworda='';
    String passwordb='';

  final validarPassword = StreamTransformer<String,String>.fromHandlers(
    handleData: (password,sink ){
      if(password.length>=6){
        sink.add(password);
      }else{
        sink.addError('mas de 6 letras por favor ');
      }
    }
  ); 

   final validarEmail = StreamTransformer<String,String>.fromHandlers(
    handleData: (email,sink ){
        String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regexp = RegExp(pattern);

        if(regexp.hasMatch(email)){
          sink.add(email);
        }else{
          sink.addError('ingrese un email valido');
        }
    }
  ); 

  //para registro:

    final validarPasswordr = StreamTransformer<String,String>.fromHandlers(
    handleData: (password,sink ){
      if(password.length>=6){
        sink.add(password);
      }else{
        sink.addError('mas de 6 letras por favor ');
      }
    }
  ); 

   final validarEmailr = StreamTransformer<String,String>.fromHandlers(
    handleData: (email,sink ){
        String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regexp = RegExp(pattern);

        if(regexp.hasMatch(email)){
          sink.add(email);
        }else{
          sink.addError('ingrese un email valido');
        }
    }
  ); 
  final validarNombrer = StreamTransformer<String,String>.fromHandlers(
    handleData: (password,sink ){
      if(password.length>=2){
        sink.add(password);
      }else{
        sink.addError('mas de 2 letras por favor ');
      }
    }
  ); 
    final validarFechaNacr = StreamTransformer<String,String>.fromHandlers(
    handleData: (email,sink ){
       // String pattern = r'^([0-2][0-9]|3[0-1])(\/|-)(0[1-9]|1[0-2])\2(\d{4})$';
       // RegExp regexp = RegExp(pattern);

        if(email.length >= 8 && email.length <= 10){
          sink.add(email);
        }else{
          sink.addError('ingrese una fecha valida');
        }
    }
  );

  final validarNombrep= StreamTransformer<String,String>.fromHandlers(
    handleData: (nombre,sink ){
      
      if(nombre.length>=2){
        sink.add(nombre);
      }else{
        sink.addError('mas de 2 letras por favor ');
      }
    }
  );

  final validarPasswordap = StreamTransformer<String,String>.fromHandlers(
    handleData: (nombre,sink ){
      
      if(nombre.length>=6){
        sink.add(nombre);
      }else{
        sink.addError('mas de 6 letras por favor ');
      }
    }
  );

  final validarPasswordbp = StreamTransformer<String,String>.fromHandlers(
    handleData: (nombre,sink ){
      if(nombre.length>=6){
        sink.add(nombre);
      }else{
        sink.addError('mas de 6 letras por favor ');
      }
    }
  );

      final validarPasswordp = StreamTransformer<String,String>.fromHandlers(
    handleData: (password,sink ){
      if(password.length>=6){
        sink.add(password);
      }else{
        sink.addError('mas de 6 letras por favor ');
      }
    }
  ); 

}