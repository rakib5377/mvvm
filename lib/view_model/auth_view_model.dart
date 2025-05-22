import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm/model/UserModel.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  final _myRepo = AuthRepository();

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<dynamic> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo
        .loginApi(data)
        .then((value) {
          Utils.flushbarErrorMessage("Login Successfully", context);

          final userPreference = Provider.of<UserViewModel>(context,listen: false);
          userPreference.saveUser(
              UserModel(
                  token: value['token'].toString()
              ));

          // final userModel = UserModel(token: value['token']);
          // await UserViewModel().saveUser(userModel);
          if (kDebugMode) {
            print('loginApi value: $value');
          }
          Navigator.pushReplacementNamed(context, RoutesName.home);
          setLoading(false);
        })
        .onError((error, stackTrace) {
          Utils.flushbarErrorMessage(error.toString(), context);
          if (kDebugMode) {
            print(error.toString());
          }
          setLoading(false);
        });
  }

  Future<dynamic> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);

    _myRepo
        .signUpApi(data)
        .then((value) {
          Utils.flushbarErrorMessage("SignUp Successful", context);
          if (kDebugMode) {
            print(value.toString());
          }
          setSignUpLoading(false);
          Navigator.pushReplacementNamed(context, RoutesName.home);
        })
        .onError((error, stackTrace) {
          Utils.flushbarErrorMessage(error.toString(), context);
          if (kDebugMode) {
            print(error.toString());
          }
          setSignUpLoading(false);
        });
  }
}
