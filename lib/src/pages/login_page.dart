import 'dart:convert';

import 'package:appedvies/src/repositorios/login_repository.dart' as repo;
import 'package:flutter/material.dart';
import 'package:appedvies/src/estilos.dart';
import '../bloc/provider.dart';
import '../utils.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool cargando =false;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context)
        ],
      ),
    );
  }

   Widget _crearFondo(BuildContext context){
    final size = MediaQuery.of(context).size;
    final fondoMorado= Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor 
          ])
      ),
    );
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: const Color.fromRGBO(255, 255, 255, 0.1)
      ),
    );
    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned (top: 90.0,left: 30.0,child: circulo),
        Positioned (top: -40.0,left: 100.0,child: circulo),
        Positioned (top: 50.0,right: -10.0,child: circulo),
        Positioned (top: 200.0,right: 50.0,child: circulo),
        Positioned (bottom: -50.0,left: -20.0,child: circulo),
        Container(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            children: const <Widget>[
              Image(image: AssetImage('assets/icon/icon.png'),width: 100.0,height: 100.0,),
              SizedBox(height: 10.0,width: double.infinity),
              Text('Estudiante', style: TextStyle(color: Colors.white,fontSize:25.0),)
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context){
    
    final bloc = Provider.of(context);
    //  final bloc = new LoginBloc();
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child:Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: 180.0,)
              ),  
          Container(
              width: size.width*0.85,
              margin: const EdgeInsets.symmetric(vertical:30.0),
              padding: const EdgeInsets.symmetric(vertical: 50.0 ),
              decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0,5.0),
                    spreadRadius: 3.0
                    ),

                  
                ]
              ),
              child:  Column(
                children:   <Widget>[
                  const Text('Ingreso',style: TextStyle(fontSize: 20.0),),
                  const SizedBox(height: 60.0,),
                  _crearEmail( bloc ),
                  const SizedBox(height: 30.0,),
                  _crearPassword( bloc ),
                  const SizedBox(height: 30.0,),
                  _crearBoton( bloc,context)
                ]
                ),
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/Registro');
            },
           child: const Text('Registro')
           ),
          const SizedBox(height: 100.0,)
        ],
      )
    );
  }

  Widget _crearEmail( LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.emailStream,

      builder: (BuildContext context,AsyncSnapshot snapshot){
        return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child:  TextField(
          keyboardType:TextInputType.emailAddress,
          decoration:  InputDecoration(
            icon: const Icon(Icons.alternate_email),
            hintText: 'ejemplo@correo.com',
            labelText: 'Correo electrónico',
            counterText: snapshot.data.toString().length.toString(),
            errorText: snapshot.error?.toString()
          ),
          onChanged: bloc.changeEmail,
        ),
    );
      }
      );

    
  }

    Widget _crearPassword(LoginBloc bloc){
    
      return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context,AsyncSnapshot snapshot){
          return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child:  TextField(
            obscureText: this._obscure,
            keyboardType:TextInputType.emailAddress,
            decoration:  InputDecoration(
              icon: const Icon(Icons.lock_outline),
              labelText: 'Contraseña',
              counterText: snapshot.data.toString().length.toString(),
              errorText: snapshot.error?.toString(),
              suffixIcon: IconButton(
                  icon: Icon(
                      _obscure ? Icons.visibility : Icons.visibility_off),
                  //color: Theme.of(context).primaryColorDark,
                  onPressed: () {
                    setState(() {
                      _obscure = !_obscure;
                    });
                  },
                )
            ),
          onChanged: bloc.changePassword,
          ),
      );
      },
    );
  }

    Widget _crearBoton(LoginBloc bloc, BuildContext context){

    return StreamBuilder(
     stream: bloc.formValidStream,
      builder: (BuildContext context,AsyncSnapshot snapshot){

        return cargando
        ?const CircularProgressIndicator()
        :ElevatedButton(
          style: Estilos.estiloBoton1(context),
           onPressed: snapshot.hasData
                    ?() => login(bloc,context)
                    :null
        , child: const Text('Ingresar'),
       );
      });
  }

  login(LoginBloc bloc, BuildContext context) async{
    cargando=true;
    setState(() {
    });
    Map<String,dynamic> respuesta=await repo.autenticacion(bloc.email(), bloc.password());
    print (json.encode(respuesta));
    Color colorSnack = Colors.red;
    if(respuesta['api']['codeError'] == "200"){
         await repo.setApiToken(respuesta['user']['token']);
         await repo.setCodUsr(respuesta['user']['codUsr']);
         await repo.setEmail(respuesta['user']['email']);
         await repo.setId(respuesta['user']['id']);
         await repo.setNombreUsuario(respuesta['user']['name']);
         Navigator.pushReplacementNamed(context, '/Splash');
         colorSnack = Theme.of(context).primaryColor;
    }
    mostrarSnackbar(context, respuesta['api']['msgError'], colorSnack, Colors.white, 2000);    
    cargando = false;
    setState(() {
    });
  }
}

