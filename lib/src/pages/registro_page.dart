import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:appedvies/src/repositorios/login_repository.dart' as repo;
import '../bloc/provider.dart';
import '../estilos.dart';
import '../utils.dart';
class RegistroPage extends StatefulWidget {

   RegistroPage({Key? key}) : super(key: key);

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final TextEditingController fechaController = TextEditingController();

  bool cargando = false;
  bool _obscure =true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _registroForm(context)
          ],
      ),
    );
  }

    Widget _registroForm(BuildContext context){
    
    final bloc = Provider.ofr(context);
    //  final bloc = new LoginBloc();
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child:Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: 150.0,)
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
                  const Text('Registro de Estudiante',style: TextStyle(fontSize: 20.0),),
                 // const SizedBox(height: 20.0,),
                  _crearEmail( bloc ),
                 // const SizedBox(height: 20.0,),
                  _crearPassword( bloc ),
                  const SizedBox(height: 20.0,),
                  _crearNombre( bloc ),
                  const SizedBox(height: 20.0,),
                  //_crearFechaNac( bloc ),
                 // const SizedBox(height: 20.0,),
                  _crearBoton( bloc,context)
                ]
                ),
            ),
          const SizedBox(height: 100.0,)
        ],
      )
    );
  }

    Widget _crearEmail( RegistroBloc bloc){

    return StreamBuilder(
      stream: bloc.emailrStream,

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
          onChanged: bloc.changeEmailr,
        ),
    );
  }
 );
}

  Widget _crearPassword( RegistroBloc bloc){

    return StreamBuilder(
      stream: bloc.passwordrStream ,
      builder: (BuildContext context,AsyncSnapshot snapshot){
        return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child:  TextField(
          keyboardType:TextInputType.visiblePassword ,
          obscureText: _obscure,
          decoration:  InputDecoration(
            icon: Icon(Icons.password_outlined),
            hintText: '',
            labelText: 'Contraseña',
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
          onChanged: bloc.changePasswordr,
        ),
    );
  }
 );
}

Widget _crearNombre( RegistroBloc bloc){

    return StreamBuilder(
      stream: bloc.nombrerStream,
      builder: (BuildContext context,AsyncSnapshot snapshot){
        return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child:  TextField(
          keyboardType:TextInputType.name,
          decoration:  InputDecoration(
            icon: const Icon(Icons.person),
            hintText: 'nombre completo',
            labelText: 'Nombre',
            counterText: snapshot.data.toString().length.toString(),
            errorText: snapshot.error?.toString()
          ),
          onChanged: bloc.changeNombrer,
        ),
    );
  }
 );
}

Widget _crearFechaNac (RegistroBloc bloc){

    return StreamBuilder(
      stream: bloc.fechaNacrStream,
      builder: (BuildContext context,AsyncSnapshot snapshot){
        return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child:  TextField(
            controller: fechaController,
             onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                showDatePicker(
                initialDatePickerMode: DatePickerMode.year,
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                context: context,
                locale: const Locale("es","ES"),
                initialDate: DateTime(DateTime.now().year - 11),
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime(DateTime.now().year - 10))
            .then((value) { 
              fechaController.text =
               '${value?.day.toString()??"0"}/${value?.month.toString()??"0"}/${value?.year.toString()??"0"}';
                bloc.changeFechaNacr(fechaController.text);
                });
      },
            keyboardType:TextInputType.datetime,
            decoration:  InputDecoration(
              icon: const Icon(Icons.calendar_month),
              hintText: 'dd/mm/aaaa',
              labelText: 'Fecha de Nacimiento',
              counterText: snapshot.data.toString().length.toString(),
              errorText: snapshot.error?.toString()
            ),
            
            onChanged:(String fecha){
              //bloc.changeFechaNacr(fecha);
              //print (fecha);
            } ,
          ),
        
    );
  }
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
        Positioned (top: -40.0,left: -30.0,child: circulo),
        Positioned (bottom: -50.0,right: -10.0,child: circulo),
        Positioned (bottom: 120.0,right: 20.0,child: circulo),
        Positioned (bottom: -50.0,left: -20.0,child: circulo),
        Container(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            children: const <Widget>[
              Image(image: AssetImage('assets/icon/icon.png'),width: 100.0,height: 100.0,),
              
              SizedBox(height: 10.0,width: double.infinity),
              Text('Registro', style: TextStyle(color: Colors.white,fontSize:25.0),)
            ],
          ),
        )
      ],
    );
  }

 Widget _crearBoton(RegistroBloc bloc, BuildContext context){
    return StreamBuilder(
     stream: bloc.formValidStream,
      builder: (BuildContext context,AsyncSnapshot snapshot){

        return cargando
        ?const CircularProgressIndicator()
        :ElevatedButton(
          style: Estilos.estiloBoton1(context),
           onPressed: snapshot.hasData
                    ?() => registrar(bloc,context)
                    :null
        , child: const Text('Registrar'),
       );
      });
  }

    registrar(RegistroBloc bloc, BuildContext context) async{
    cargando=true;
    setState(() {
    });
    Map<String,dynamic> respuesta=await repo.registro(bloc.nombre(),bloc.email(), bloc.password());
    print (json.encode(respuesta));
    Color colorSnack = Colors.red;
    if(respuesta['api']['codeError'] == "201"){
         Navigator.pushNamedAndRemoveUntil(context, '/Login', (route) => false);
         colorSnack = Theme.of(context).primaryColor;
    }
    mostrarSnackbar(context, respuesta['api']['msgError'], colorSnack, Colors.white, 2000);    
    cargando = false;
    setState(() {
    });
  }
}