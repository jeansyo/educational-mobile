
import 'package:appedvies/src/pages/home_page.dart';
import 'package:appedvies/src/pages/login_page.dart';
import 'package:appedvies/src/pages/material_web_page.dart';
import 'package:appedvies/src/pages/principal_page.dart';
import 'package:appedvies/src/pages/registro_page.dart';
import 'package:flutter/material.dart';
//import 'package:proy1cossmil/src/pages/login_page.dart';
import 'package:appedvies/src/pages/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashPage());
      
      case '/Login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
     
      case '/Principal':
        return MaterialPageRoute(builder: (_) => PrincipalPage());
      
      case '/Registro':
        return MaterialPageRoute(builder: (_) => RegistroPage());
      
      case '/MaterialWeb':
        return MaterialPageRoute(builder: (_) => MaterialWebPage());
      //case '/InicioSalud':
      //   return MaterialPageRoute(builder: (_) => PaginaInicioSalud());
      // case '/InicioVivienda':
      //   return MaterialPageRoute(builder: (_) => PaginaInicioVivienda());
      // case '/InicioSeguros':
      //   return MaterialPageRoute(builder: (_) => PaginaInicioSeguros());
      // case '/Entidades':
      //   return MaterialPageRoute(builder: (_) => PaginaEntidades());
      // case '/CitasPendientes':
      //   return MaterialPageRoute(builder: (_) => PaginaCitasPendientes());
      // case '/UltimasCitas':
      //   return MaterialPageRoute(builder: (_) => PaginaUltimasCitas());

      // //case '/DetalleNoticia':
      // return MaterialPageRoute(builder: (_) => WidgetDetalleNoticia());

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(body: SizedBox(height: 0)));
    }
  }
}
