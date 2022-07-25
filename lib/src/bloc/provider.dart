
import 'package:flutter/material.dart';

import 'login_bloc.dart';
export 'login_bloc.dart';
import 'package:appedvies/src/bloc/registro_bloc.dart';
export 'package:appedvies/src/bloc/registro_bloc.dart';

import 'package:appedvies/src/bloc/perfil_bloc.dart';
export 'package:appedvies/src/bloc/perfil_bloc.dart';
class Provider extends InheritedWidget {

  final loginBloc = LoginBloc();
  final registroBloc = RegistroBloc();
  final perfilBloc = PerfilBloc();

  static Provider? _instancia;

  factory Provider ({ Key? key,required Widget child}){
    if(_instancia == null){
      _instancia = new Provider._internal(key:key,child: child,);
    }
    return _instancia!;
  }

  Provider._internal({ Key? key,required Widget child}) 
  : super(key:key,child: child);
  
    @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider).loginBloc;
  }

  static RegistroBloc ofr ( BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider).registroBloc;
  }
  
  static PerfilBloc ofp ( BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider).perfilBloc;
  }
}