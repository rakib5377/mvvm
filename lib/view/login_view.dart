import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/model/UserModel.dart';
import 'package:mvvm/resources/components/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _obscureText.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final authViewModel = Provider.of<AuthViewModel>(context);
    final userModel = UserModel();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Email",
              prefixIcon: Icon(Icons.email_outlined),

            ),
            onFieldSubmitted: (value){
              Utils.changeFieldFocus(context, _emailFocusNode, _passwordFocusNode);
            },
          ),
          SizedBox(height: height * 0.031,),
          ValueListenableBuilder(
              valueListenable: _obscureText,
              builder: (context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  obscureText: _obscureText.value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock_open),
                    suffixIcon: InkWell(
                      onTap: (){
                        _obscureText.value = !_obscureText.value;
                      },
                      child: Icon(_obscureText.value? Icons.visibility_off : Icons.visibility),
                    )

                  ),
                );
              },)
          ,
          SizedBox(height: height * 0.06,),
          RoundButton(
              title: "Login",
              loading: authViewModel.loading,
              onPress: (){
            if(_emailController.text.isEmpty){
              Utils.flushbarErrorMessage("Email is required", context);
            }
            else if(_passwordController.text.isEmpty){
              Utils.flushbarErrorMessage("Password is required", context);
            }
            else if(_passwordController.text.length < 6){
              Utils.toastMessage("Enter at least 6 digits of password");
            }
            else{
              // Map data = {
              //   "email" : _emailController.text.toString(),
              //   "password" : _passwordController.text.toString()
              // };
              Map data = {
                "email" : 'eve.holt@reqres.in',
                "password" : 'cityslicka'
              };
              authViewModel.loginApi(data, context,);
              if(kDebugMode){
                print("api hit");
                print("Login success, token: ${userModel.token}");
              }
            }
          }
            ,),
          SizedBox(height: height * 0.02,),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, RoutesName.signUp);
            },
            child: Text("Don't have an account ? SignUp"),
          )
        ],
      ),
    );
  }
}
