import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:towfactor_ios/Models/backup_code_model.dart';
import 'package:pdf/widgets.dart' as pw;
import '../Models/Error_response.dart';
import '../Screens/LoginScreen.dart';
import '../Service/Service.dart';
import '../Utilities/Storage.dart';
import '../Utilities/Utilities.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BackupCodeController with ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  BackupCodeModel _backupCodeModel = BackupCodeModel();
  BackupCodeModel get backupCodeModel => _backupCodeModel; 


  bool _requestStatus = false;
  bool get requestStatus => _requestStatus;

  void resetUserToken() {
    notifyListeners();
  }

  Future<void> getBackupCodes(String userid, String token, String device_id) async{
    _isLoading = true;
    notifyListeners();

    Service().getBackupCodes(device_id, userid, token).then((response) async {
      if(response is BackupCodeModel){
        _backupCodeModel = response;
        _requestStatus = true;
        if(backupCodeModel.codeList!.isNotEmpty)
        {
          await generateAndDownloadPDF(backupCodeModel.codeList!);
        }
        notifyListeners();
      }else if(response is ErrorResponse){
        _requestStatus = false;
        notifyListeners();
        if(response.message == 'User Not Authorized'){
          Get.dialog(
            _buildCustomDialog('Session has expired please login again', 'OK', 'Login'),
          );
        }else{
          Utilities.ErrorMessage(response.message!);
        }
      }else{
        _requestStatus = false;
        notifyListeners();
        Utilities.ErrorMessage('Unknown response');
      }
      _isLoading = false;
      notifyListeners();
    }).catchError((error, stackTrace) {
      _isLoading = false;
      Utilities.ErrorMessage(error.toString());
      _requestStatus = false;
      notifyListeners();
    });
  }


  Future<void> generateAndDownloadPDF(List<CodeList> list) async {
    
    try{
        if (await Permission.manageExternalStorage.request().isGranted)   
        {
            final pdf = pw.Document();
          pdf.addPage(
            pw.Page(
              build: (pw.Context context) {
                return pw.Column(
                  children: list.map((item) {
                    return pw.Text('${item.code}');
                  }).toList(),
                );
              },
            ),
          );

          final output = await getApplicationDocumentsDirectory();
          final file = File('${output.path}/BackUpCodes.pdf');
          await file.writeAsBytes(await pdf.save());

          // Open the generated PDF file
          Utilities.normalMessage("The BackUp Two factors code is saved in Documents");
          OpenFile.open(file.path);
        }
    }
    catch(e){
       Utilities.normalMessage(e.toString());
    }
  

  
  }


  Widget _buildCustomDialog(String message, String buttonText, String tag) {
    return AlertDialog(
      title: Row(
        children: [
          Image.asset(
            'assets/images/updated_logo.png', // replace with your image asset path
            width: 40, // adjust the width as needed
            height: 40, // adjust the height as needed
          ),
          SizedBox(width: 8),
          Text('Alert..!',style: TextStyle(fontSize: 15),),
        ],
      ),
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if(tag == 'Login'){
              bool result = await Storage().clearStorage();
              if (result) {
                Get.offAll(LoginScreen());
              }
            }else{
              Get.back();
            }
          },
          child: Text(buttonText),
        ),
      ],
    );
  }

}