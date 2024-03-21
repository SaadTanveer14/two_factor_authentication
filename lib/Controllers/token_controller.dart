import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:towfactor_ios/Models/token_model.dart';

import '../Models/Error_response.dart';
import '../Screens/LoginScreen.dart';
import '../Service/Service.dart';
import '../Utilities/Storage.dart';
import '../Utilities/Utilities.dart';
import '../Widgets/alert_dialog.dart';

class TokenController with ChangeNotifier{
  bool _isLoading = false;
  String _userToken = '- - - -';
  String get userToken => _userToken;
  bool get isLoading => _isLoading;
  bool _requestStatus = false;
  bool get requestStatus => _requestStatus;

  void resetUserToken() {
    _userToken = '- - - -';
    notifyListeners();
  }

  Future<void> getUserToken(String userid,String token,String device_id) async{
    _userToken = '- - - -';
    _isLoading = true;
    notifyListeners();

    Service().getToken(device_id, userid, token).then((response) async {
      if(response is TokenModel){
        _userToken = response.token.toString();
        _requestStatus = true;
        notifyListeners();
      }else if(response is ErrorResponse){
        _requestStatus = false;
        notifyListeners();
        if(response.message == 'User Not Authorized'){
          Get.dialog(
            _buildCustomDialog('Session has expired please login again', 'OK', 'Login'),
          );
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