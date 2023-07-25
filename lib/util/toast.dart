
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Toast {

  Toast.message(String message, {int duration = 5000}){
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        isDismissible: true,
        duration: Duration(milliseconds: duration),
        backgroundColor: const Color(0xff191919),
        borderRadius: 10,
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      ),
    );
  }
}