import 'dart:convert';

import 'package:appedvies/src/bloc/provider.dart';
import 'package:appedvies/src/estilos.dart';
import 'package:flutter/material.dart';

import 'package:appedvies/src/repositorios/login_repository.dart' as repolo;

import '../utils.dart';
class PerfilPage extends StatefulWidget {
  PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  bool cargando= false;
  bool respuestaAlerta = false;
  bool esVerificado = true;
  bool verificando = false;

  bool _obscure = true;
  bool _obscurea = true;
  bool _obscureb = true;
  String apitoken='';
  TextEditingController passworda_controller =new TextEditingController();
  TextEditingController passwordb_controller =new TextEditingController();
  
  @override
  void initState()  {
      super.initState;
      setDatos();     
  }
    String codigo ='SIN CÓDIGO';
    String email = 'SIN EMAIL';
    String nombre='SIN NOMBRE';
    
      
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top:10.0),
        margin: EdgeInsets.only(left: 10.0),
        child: Stack(
          
          children:<Widget>[
            SizedBox(width: double.infinity,),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: double.infinity,),
                  Text('$codigo',
                      style:Estilos.titulo_page(Colors.black)),
                  Text('$email',
                      style:Estilos.titMat(Colors.black)),
            
                ],
              ),
            ),
            
            _registroForm(context)
          ]
          
        ),
      ),
    );
  }

setDatos() async{
    codigo = await repolo.getCodUsr();
    email = await repolo.getEmail();
    nombre =await repolo.getNombreUsuario();
    apitoken = await repolo.getApiToken();
    
    
    //print(await repolo.getApiToken());
    setState(() {});
  }


   Widget _registroForm(BuildContext context){
    
    final bloc = Provider.ofp(context);
    //  final bloc = new LoginBloc();
    bloc.changeNombrep(this.nombre);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child:Column(
        children: <Widget>[  
          SafeArea(
            child: Container(
              height: 80.0,)
              ),        
          Container(
              width: size.width*0.90,
              margin: const EdgeInsets.symmetric(vertical:10.0),
              padding: const EdgeInsets.symmetric(vertical: 30.0 ),
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
                 
                  const SizedBox(height: 10.0,),
                 Text('Editar Datos',style: TextStyle(fontSize: 20.0,color: Theme.of(context).primaryColor ),),
                  _crearNombre( bloc ),
                  const SizedBox(height: 10.0,),
                  

                  _crearPassworda( bloc ),
                  const SizedBox(height: 10.0,),
                  _crearPasswordb( bloc ),
                  const SizedBox(height: 10.0,),
                  
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

 



Widget _crearNombre( PerfilBloc bloc){

    return StreamBuilder(
      stream: bloc.nombreStreamp,
      builder: (BuildContext context,AsyncSnapshot snapshot){
        return Container(
          margin: EdgeInsets.symmetric(horizontal:10.0),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Theme.of(context).primaryColor)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child:  TextField(
          keyboardType:TextInputType.name,
          
          decoration:  InputDecoration(
            icon: const Icon(Icons.person),
            hintText: 'Nombre completo',
            labelText: 'Nuevo nombre',
            //counterText: snapshot.data.toString().length.toString(),
            errorText: snapshot.error?.toString()
          ),
          onChanged: bloc.changeNombrep,
        ),
    );
  }
 );
}

  Widget _crearPassworda( PerfilBloc bloc){

    return StreamBuilder(
      stream: bloc.passwordaStreamp ,
      builder: (BuildContext context,AsyncSnapshot snapshot){
        return Container(
          margin: EdgeInsets.symmetric(horizontal:10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Theme.of(context).primaryColor)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child:  TextField(
          obscureText: _obscurea,
          keyboardType:TextInputType.visiblePassword ,
          controller: this.passworda_controller,
          decoration:  InputDecoration(
            icon: Icon(Icons.password_outlined),
            hintText: '',
            labelText: 'Nueva Contraseña',
            errorText: snapshot.error?.toString(),
            suffixIcon: IconButton(
                  icon: Icon(
                      _obscurea ? Icons.visibility : Icons.visibility_off),
                  //color: Theme.of(context).primaryColorDark,
                  onPressed: () {
                    setState(() {
                      _obscurea = !_obscurea;
                    });
                  },
                )
          ),
          onChanged: bloc.changePasswordap,
        ),
    );
  }
 );
}
  Widget _crearPasswordb( PerfilBloc bloc){

    return StreamBuilder(
      stream: bloc.passwordbStreamp ,
      builder: (BuildContext context,AsyncSnapshot snapshot){
        return Container(
        margin: EdgeInsets.symmetric(horizontal:10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Theme.of(context).primaryColor)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child:  TextField(
          obscureText: _obscureb,
          controller: passwordb_controller,
          keyboardType:TextInputType.visiblePassword ,
          decoration:  InputDecoration(
            icon: Icon(Icons.password_outlined),
            hintText: '',
            labelText: 'Repita Nueva Contraseña',
            errorText: snapshot.error?.toString(),
            suffixIcon: IconButton(
                  icon: Icon(
                      _obscureb ? Icons.visibility : Icons.visibility_off),
                  //color: Theme.of(context).primaryColorDark,
                  onPressed: () {
                    setState(() {
                      _obscureb = !_obscureb;
                    });
                  },
                )
          ),
          onChanged: bloc.changePasswordbp,
        ),
    );
  }
 );
}

 Widget _crearBoton(PerfilBloc bloc, BuildContext context){
    return StreamBuilder(
     stream: bloc.formValidStream,
      builder: (BuildContext context,AsyncSnapshot snapshot){

        return cargando
        ?const CircularProgressIndicator()
        :ElevatedButton(
          style: Estilos.estiloBoton1(context),
           onPressed: snapshot.hasData && bloc.passwordap()==bloc.passwordbp()
                    ?() => mostrarAlertaPerfilsino(context, bloc, "¿Esta seguro de cambiar estos valores?", 'Advertencia')
                    :null
        , child: const Text('Modificar'),
       );
      });
  }

  void mostrarAlertaPerfilsino(BuildContext context,PerfilBloc bloc, String mensaje, String titulo) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  print(Navigator.of(context).canPop());
                  Navigator.of(context).pop();
                },
                child: Text('NO')),
            TextButton(
                onPressed: () {
                  registrar(bloc, context);
                },
                child: Text('SI'))
          ],
        );
      });
}

  registrar(PerfilBloc bloc, BuildContext context) async{
    cargando=true;

    setState(() {
    });
    Color colorSnack = Colors.red;
   
      Map<String,dynamic> respuesta=await repolo.actualizaDatos(bloc.nombrep(),bloc.passwordap(),this.apitoken);
      
      if(respuesta['api']['codeError'] == "200"){
          repolo.setApiToken('');
          Navigator.pushNamedAndRemoveUntil(context, '/Login', (route) => false);
           colorSnack = Theme.of(context).primaryColor;
           bloc.changeNombrep('');
           bloc.changePasswordap('');
           bloc.changePasswordbp('');
           bloc.changePasswordp('');
      }
       mostrarSnackbar(context, respuesta['api']['msgError'], colorSnack, Colors.white, 2000);    
    

   
    cargando = false;
    setState(() {
    });
  }

}