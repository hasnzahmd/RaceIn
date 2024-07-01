import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:race_in/constants/custom_colors.dart';

void showToast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.white,
      textColor: CustomColors.f1red,
      fontSize: 16.0);
}
