import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/home_view.dart';
import 'package:mvvm/view/login_view.dart';
import 'package:mvvm/view/signup_view.dart';
import 'package:mvvm/view/splash_view.dart';

class Routes {

  static Route<dynamic> generateRoutes (RouteSettings settings){


    switch(settings.name){

      case RoutesName.splash:
        return MaterialPageRoute(builder: (context)=> SplashView());

      case RoutesName.login:
        return MaterialPageRoute(builder: (context)=> LoginView());

      case RoutesName.signUp:
        return MaterialPageRoute(builder: (context)=> SignupView());

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