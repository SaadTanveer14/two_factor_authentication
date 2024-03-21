import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:towfactor_ios/Models/Error_response.dart';
import 'package:towfactor_ios/Models/success_response.dart';
import 'package:towfactor_ios/Service/Service.dart';
import 'package:towfactor_ios/Widgets/alert_dialog.dart';

import '../Utilities/Utilities.dart';

class SignUpController with ChangeNotifier{
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> signUp(String userid,String password,String fullname,String mobNo,String device_id)async{
    final BuildContext context = navigatorKey.currentState!.overlay!.context;
    notifyListeners();
    _isLoading = true;

    Service().sigUp(userid, password, device_id, fullname, mobNo).then((response){
      if(response is SuccessResponse){
        _isLoading = false;
        notifyListeners();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'Congratulations',
              descriptions: 'Registeration completed successfuly click ok to login.',
              text: 'OK', TAG: 'Signup',
            );
          },
        );
      }else if(response is ErrorResponse){
        _isLoading = false;
        notifyListeners();
        Utilities.ErrorMessage(response.message!);
      }else{
        _isLoading = false;
        notifyListeners();
        Utilities.ErrorMessage('Unknown response');
      }
    } ).catchError((error, stackTrace){
      _isLoading = false;
      Utilities.ErrorMessage(error.toString());
      notifyListeners();
    });
  }
}