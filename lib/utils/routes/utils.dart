import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static tosatMassage(String massage) {
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: const Color(0xFFD32F2F),
      textColor: Colors.white,
      webBgColor: "linear-gradient(to right, #D32F2F, #F44336)",
      msg: massage,
    );
  }

  static void fieldFoucsChange(
    BuildContext context,
    FocusNode current,
    FocusNode nextFoucs,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFoucs);
  }

  static void flushBarErrorMassage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.all(15),
        //backgroudColors
        message: message,
        borderRadius: BorderRadius.circular(20),
        backgroundColor: Colors.red,
        title: "error",
        messageColor: Colors.black,
        positionOffset: 20,
        flushbarPosition: FlushbarPosition.BOTTOM,
        icon: Icon(Icons.error, size: 28, color: Colors.white),
        duration: Duration(seconds: 3),
      )..show(context),
    );
  }
}

snakBar(String massage, BuildContext context) {
  return ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(backgroundColor: const Color(0xFFD32F2F), content: Text(massage)));
}
