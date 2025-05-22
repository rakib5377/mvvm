import 'package:flutter/material.dart';
import 'package:mvvm/resources/colors.dart';

class RoundButton extends StatelessWidget {
  String title;
  bool loading;
  VoidCallback onPress;
  RoundButton({super.key,
  required this.title,
    required this.onPress,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
          color: AppColor.buttonColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
            child: loading ? CircularProgressIndicator(color: AppColor.whiteColor,) : Text(title,style: TextStyle(color: AppColor.whiteColor,fontSize: 18),)),
      ),
    );
  }
}
