import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar.dart';

class Utils {

  static double averageRating(List<num>? rating){
    if(rating == " " || rating!.isEmpty) return 0.0;
    num avgRating = 0;
    for(int i = 0; i < rating.length; i++){
      avgRating = avgRating + rating[i];
    }
    return double.parse((avgRating/rating.length).toStringAsFixed(1));
  }

  static void changeFieldFocus(
      BuildContext context,
      FocusNode current,
      FocusNode nextFocus
      ){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message){
    Fluttertoast.showToast(msg: message,
        backgroundColor: Colors.black,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 18
    );
  }


  static flushbarErrorMessage(String message, BuildContext context){
    showFlushbar(context: context, flushbar: Flushbar(
      message: message,
      messageSize: 18,
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(20),
      icon: Icon(Icons.error,size: 20,color: Colors.white,),
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      forwardAnimationCurve: Curves.easeIn,
      reverseAnimationCurve: Curves.easeOut,
      duration: Duration(seconds: 3),
    )..show(context));
  }

  static snackBar(String message, BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
          duration: Duration(seconds: 2),
          content: Text(message,style: TextStyle(color: Colors.white),))
    );
  }
}