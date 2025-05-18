import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/home_screen.dart';
import 'package:mvvm/view/login_screen.dart';

class Routes {

  static Route<dynamic> generateRoutes (RouteSettings settings){


    switch(settings.name){


      case RoutesName.login:
        return MaterialPageRoute(builder: (context)=> LoginScreen());

      case RoutesName.home:
        return MaterialPageRoute(builder: (context)=> HomeScreen());


      default:
        return MaterialPageRoute(builder: (context){
          return Scaffold(
            appBar: AppBar(title: Text("Default"),),
            body: Center(child: Text('No Routes defined'),),
          );
        });
    }
  }
}