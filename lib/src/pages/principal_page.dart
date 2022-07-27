import 'package:appedvies/src/estilos.dart';

import 'package:appedvies/src/pages/perfil_page.dart';
import 'package:appedvies/src/providers/db_provider.dart';
import 'package:appedvies/src/utils.dart';
import 'package:flutter/material.dart';
import 'package:appedvies/src/repositorios/login_repository.dart' as repo;

import 'home_page.dart';
// ignore: must_be_immutable
class PrincipalPage extends StatefulWidget {
  PrincipalPage({Key? key}) : super(key: key);

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  bool cargando = false;
  String nombreUsuario ='';
  String emailUsuario = '';
  String iniciales = '';
  int _index = 1;
  static  List<Widget> _widgetOptions = <Widget>[
           Text('Index 0: Salir'),
          HomePage(),
          PerfilPage(),      
        ];
  static const List<BottomNavigationBarItem> _navigationItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.close, size: 30.0, ), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.home,size: 30.0,), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.assignment_ind_outlined,size: 30.0, ), label: ''),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
      if(index == 0){
        mostrarAlertaCerrarSesionsino(context);
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    iniciarVariables();
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
            appBar: AppBar(
              //leading: SizedBox(width: 10.0,height: 10.0,),
              backgroundColor: Theme.of(context).primaryColor,
              centerTitle: false,
              automaticallyImplyLeading: false,
        title: cargando
        ? const CircularProgressIndicator()
        :Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: <Widget>[
                Text(nombreUsuario,style: Estilos.titScaf(Colors.white),),
               // Text (emailUsuario,style: Estilos.subtitscaf(Colors.white) )
              ],
            ),
            CircleAvatar(
              child: Text(iniciales)
            )
            
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationItems,
        currentIndex: _index,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
   
    // 
  }
  void iniciarVariables()async{
    cargando = true;
    setState(() {
      
    });
      emailUsuario = await repo.getEmail();
      nombreUsuario = await repo.getNombreUsuario();
      iniciales = genIniciales(nombreUsuario).toUpperCase() ; 
      cargando = false;
    setState(() {
        
    });
  }

    void mostrarAlertaCerrarSesionsino(BuildContext context,) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Advertencia'),
          content: Text('¿Esta seguro de cerrar esta session?'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  print(Navigator.of(context).canPop());
                  Navigator.of(context).pop();
                  _onItemTapped(1);
                },
                child: Text('NO')),
            TextButton(
                onPressed: () async {
                  cargando = true;
                  setState(() {
                    });
                  await repo.setApiToken('');
                  await repo.setCodUsr('');
                  await repo.setEmail('');
                  await repo.setNombreUsuario('');
                  await repo.setId(0);
                  await DBProvider.db.deleteCursoAll();
                  await DBProvider.db.deleteMaterialeAll();
                  Navigator.pushNamedAndRemoveUntil(context, '/Login', (route) => false); 
                },
                child: Text('SI'))
          ],
        );
      });
}

  
}