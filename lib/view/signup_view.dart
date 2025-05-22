import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/resources/components/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _obscureText.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(title: Text("SignUp"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email_outlined),
              labelText: "Email",
              hintText: "Email"
            ),
            onFieldSubmitted: (value) {
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
                  keyboardType: TextInputType.text,
                  obscureText: _obscureText.value,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_open),
                      labelText: "Password",
                      hintText: "Password",
                    suffixIcon: InkWell(
                      onTap: (){
                        _obscureText.value = !_obscureText.value;
                      },
                      child: Icon(_obscureText.value ? Icons.visibility_off : Icons.visibility),
                    )
                  ),
                  onFieldSubmitted: (value){
                    Utils.changeFieldFocus(context, _passwordFocusNode, _confirmPasswordFocusNode);
                  },
                );
              },),
          SizedBox(height: height * 0.031,),
          ValueListenableBuilder(
              valueListenable: _obscureText,
              builder: (context, value, child) {
                return TextFormField(
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocusNode,
                  keyboardType: TextInputType.text,
                  obscureText: _obscureText.value,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_open),
                      labelText: "Confirm Password",
                      hintText: "Confirm Password",
                    suffixIcon: InkWell(
                      onTap: (){
                        _obscureText.value = !_obscureText.value;
                      },
                      child: Icon(_obscureText.value ? Icons.visibility_off : Icons.visibility),
                    )
                  ),
                );
              },),
          SizedBox(height: height * 0.061,),
          RoundButton(
              title: "Sign Up",
              loading: authViewModel.signUpLoading,
              onPress: (){
                if(_emailController.text.isEmpty){
                  Utils.flushbarErrorMessage("Email is Required", context);
                }
                else if(_passwordController.text.isEmpty){
                  Utils.flushbarErrorMessage("Password is Required", context);
                }
                else if(_confirmPasswordController.text.isEmpty){
                  Utils.flushbarErrorMessage("Confirm password is Required", context);
                }
                else if(_passwordController.text != _confirmPasswordController.text){
                  Utils.flushbarErrorMessage("Password and Confirm Password did not Matched", context);
                }
                else if(_passwordController.text.length < 6 || _confirmPasswordController.text.length < 6){
                  Utils.flushbarErrorMessage("Enter at least 6 digits of password", context);
                }
                else{
                  Map data = {
                    "email" : _emailController.text.toString(),
                    "password" : _passwordController.text.toString()
                  };
                  authViewModel.signUpApi(data, context);
                  if(kDebugMode){
                    print('api hit');
                  }
                }
              }),
          SizedBox(height: height * 0.06,),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, RoutesName.login);
            },
            child: Text("Already have an account? Login"),
          )
        ],
      ),
    );
  }
}
