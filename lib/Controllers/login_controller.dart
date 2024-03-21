import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:towfactor_ios/Models/Error_response.dart';
import 'package:towfactor_ios/Models/login_model.dart';
import 'package:towfactor_ios/Screens/home_screen.dart';
import 'package:towfactor_ios/Service/Service.dart';
import 'package:towfactor_ios/Utilities/Storage.dart';
import 'package:towfactor_ios/Utilities/Utilities.dart';

class LoginController with ChangeNotifier{

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> userLogin(String userid,String userPassword,String device_id) async{
    notifyListeners();
    _isLoading = true;

    Service().login(userid, userPassword, device_id).then((response) async {
      if(response is LoginResponseModel){
        List<ListElement> data = response.list;
        for(var item in data){
         await Storage().storeToken(item.token);
         await Storage().storeLoginId(item.userId);
         await Storage().storeFullname(item.name);
         Get.off(HomeSreen());
        }
      }else if(response is ErrorResponse){
        Utilities.ErrorMessage(response.message!);
      }else{
        Utilities.ErrorMessage('Unknown response');
      }
      _isLoading = false;
      notifyListeners();
    }).catchError((error, stackTrace) {
      _isLoading = false;
      Utilities.ErrorMessage(error.toString());
      notifyListeners();
    });
  }

}