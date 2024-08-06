import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:towfactor_ios/Widgets/Update_Widgets/update_alert_dialog.dart';

class UpdateApp extends StatefulWidget {
  const UpdateApp({super.key});

  @override
  State<UpdateApp> createState() => _UpdateAppState();
}

class _UpdateAppState extends State<UpdateApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showUpdateDialog();
  });
}

  void showUpdateDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent, // Make the background transparent
          content: CustomAlertDialogContent(),
        ),
      )
    );
  }
}