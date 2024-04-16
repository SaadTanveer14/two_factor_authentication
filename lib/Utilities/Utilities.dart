
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'dart:io' as io;
import 'package:flutter/services.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';

class Utilities {
  static void showSnackbar(String title, String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text(title,style: TextStyle(color: Colors.white),),
      messageText: Text(message,style : TextStyle(color: Colors.white),),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black,
      borderRadius: 10,
      margin: EdgeInsets.all(15),
      duration: Duration(seconds: 4),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static Future<String?> getDeviceID() async {
    String? deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      // deviceId = '3867527f8fd434dl';
    } on PlatformException {
      deviceId = '';
      Utilities.showSnackbar(
          'Alert',
          'device identifier failed');
    }
    return deviceId;
  }

 static ErrorMessage(String mymsg){
    Fluttertoast.showToast(
        msg: mymsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0
    );
  }

 static normalMessage(String mymsg){
    Fluttertoast.showToast(
        msg: mymsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 14.0
    );
  }

 static SuccessMessage(String mymsg){
    Fluttertoast.showToast(
        msg: mymsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 14.0
    );
  }

 static WarningMessage(String mymsg){
    Fluttertoast.showToast(
        msg: mymsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.white,
        fontSize: 14.0
    );
  }
}