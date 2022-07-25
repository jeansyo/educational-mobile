import 'package:appedvies/src/pages/asignaturas_page.dart';
import 'package:appedvies/src/pages/ultimo_material_page.dart';
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar:AppBar(
          toolbarHeight: 20.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          bottom: TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Theme.of(context).primaryColor,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.auto_mode,
                    size: 40.0,
                  ),
                  text: "Material Reciente",
                ),
                Tab(
                    icon: Icon(
                      Icons.school,
                      size: 40.0,
                    ),
                    text: "Asignaturas"),
              ],
        
          ),
          
        ),
        body: TabBarView(children: <Widget>[
          UltimoMaterialPage(),
          AsignaturasPage()
        ])

        )
      );
  }
}