import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../util/constants.dart';

typedef ButtonCallback = Future Function();

class Button extends StatelessWidget {
  final String text;
  final double minWidth;
  final double borderRadius;
  final ButtonCallback onPressed;

  final bool showLoading;
  final String? loadingMessage;

  Button({required this.text, required this.onPressed, this.minWidth = double.infinity,
     this.showLoading = true, this.loadingMessage, this.borderRadius = 5});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        await callOnPressed();
      },
      elevation: 1,
      height: 55,
      minWidth: minWidth,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(borderRadius),
      ),
      color: AppColors.primaryColor,
      child: Text(
        text,
        style:  const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  callOnPressed() async{

    if(showLoading){
      EasyLoading.show(status: loadingMessage);
      await onPressed.call();
      EasyLoading.dismiss();
    }
    else{
      await onPressed.call();
    }
  }
}

class SecondaryButton extends StatelessWidget {

  final String text;
  final double minWidth;
  final double borderRadius;
  final ButtonCallback onPressed;

  final bool showLoading;
  final String? loadingMessage;
  final double height;
  final double fontSize;

  const SecondaryButton({super.key, required this.text,required this.onPressed, this.minWidth = double.infinity,
    this.showLoading =true, this.loadingMessage, this.borderRadius = 5,this.height=45,this.fontSize=16});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        await callOnPressed();
      },
      elevation: 0,
      height: 55,
      minWidth: minWidth,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(borderRadius),
      ),
      color: Colors.white,
      child: Text(
        text,
        style:  TextStyle(
          color: AppColors.primaryColor,
          fontSize: 16,
        ),
      ),
    );
  }

  callOnPressed() async{
    if(showLoading){
      EasyLoading.show(status: loadingMessage);
      await onPressed.call();
      EasyLoading.dismiss();
    }
    else{
      await onPressed.call();
    }
  }
}