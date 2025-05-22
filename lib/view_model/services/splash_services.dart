import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm/model/UserModel.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    try{

      UserModel user = await getUserData();

      if(kDebugMode){
        print('value of token: ${user.token}');
      }

      await Future.delayed(Duration(seconds: 3));

      if(user.token == "null" || user.token!.isEmpty) {
        Navigator.pushReplacementNamed(context, RoutesName.login);
      }
      else {
        Navigator.pushReplacementNamed(context, RoutesName.home);
      }


    }
        catch(e){
      if(kDebugMode){
        print("Authentication Error: $e");
      }
        }
  }
}
