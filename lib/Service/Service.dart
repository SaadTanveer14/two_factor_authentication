import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:towfactor_ios/Constants/Constants.dart';
import 'package:towfactor_ios/Models/backup_code_model.dart';
import 'package:towfactor_ios/Models/data_model.dart';
import 'package:towfactor_ios/Models/login_model.dart';
import 'package:towfactor_ios/Utilities/Utilities.dart';
import 'package:towfactor_ios/Utilities/internet_connection.dart';
import 'package:towfactor_ios/Widgets/nointernet_snackbar.dart';

import '../Helpers/httpClient.dart';
import '../Models/Error_response.dart';
import '../Models/success_response.dart';
import '../Models/token_model.dart';

class Service{
  
  InternetConnectivity _internetConnection = InternetConnectivity();

  Future<dynamic> login(String userid, String password,String device_id) async {
    await _internetConnection.checkConnectivity();
    var url = 'https://apps.slichealth.com/ords/ihmis_admin/2FA/userLogin';
    var header = {'userid': userid, "password": password, 'authentication': 'As!gY12cv9#*0(0PTls8ZvQyu(56MM', "device_id": device_id};
    var body = {'version': Constants.Version};

    final client = await CreateHttpClint().getSSLPinningClient();

    try {
      Response response = await client.post(
          Uri.parse(url),
          headers: header,
         body: body
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseVar = json.decode(response.body);
        if (responseVar['status'] == Constants.SUCCESS) {
          return LoginResponseModel.fromJson(responseVar);
        } else if (responseVar['status'] == Constants.ERROR) {
          return ErrorResponse.fromJson(responseVar);
        }else{
          Utilities.ErrorMessage('Undefined status occurs');
        }
      } else if (response.statusCode == 500) {
        throw 'Server Error, please try again';
      } else if (response.statusCode != 200 && response.statusCode != 500) {
        throw Exception(response.body);
      } else {
        throw 'Request failed, please try again!!!';
      }
    } 
     on SocketException catch (e)
    {
      showNoInternetSnackbar();
      throw 'No Internet';
    }  
    on TimeoutException catch (_) {
      throw 'Looks like your internet is unstable, please try again.';
    } catch (e) {
      throw '${e.toString()}';
    }
  }

  Future<dynamic> sigUp(String userid,String password,String device_id,String fullName,String mobNo) async {
    await _internetConnection.checkConnectivity();
    var url = 'https://apps.slichealth.com/ords/ihmis_admin/2FA/reg_user';
    var header = {
      'userid': userid,
      "password": password,
      'authentication': 'As!gY12cv9#*0(0PTls8ZvQyu(56MM',
      "device_id": device_id
    };
    var body = {
      'user_name': fullName,
      'contact_no': mobNo,
      'device_type': 'mobile_app',
      'version': Constants.Version
    };

    final client = await CreateHttpClint().getSSLPinningClient();

    try {
      Response response = await client.post(
          Uri.parse(url),
          headers: header,
          body: body
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseVar = json.decode(response.body);
        if(responseVar['status'] == Constants.SUCCESS){
          return SuccessResponse.fromJson(responseVar);
        }else if(responseVar['status'] == Constants.ERROR){
          return ErrorResponse.fromJson(responseVar);
        }else{
          throw 'Found an issue with status';
        }
      } else if (response.statusCode == 500) {
        throw 'Server Error, please try again';
      } else if (response.statusCode != 200 && response.statusCode != 500) {
        throw Exception(response.body);
      } else {
        throw 'Request failed, please try again!!!';
      }
    }
    on SocketException catch (e)
    {
      showNoInternetSnackbar();
      throw 'No Internet';
    }   
    on TimeoutException catch (_) {
      throw 'Looks like your internet is unstable, please try again.';
    } catch (e) {
      throw '${e.toString()}';
    }
  }

  Future<dynamic> fetchData(String device_id,String token) async {
    await _internetConnection.checkConnectivity();
    var url = 'https://apps.slichealth.com/ords/ihmis_admin/2FA/fetchData';
    var header = {
      'authentication': 'As!gY12cv9#*0(0PTls8ZvQyu(56MM',
      "device_id": device_id,
    };
    var body = {
      'version': Constants.Version
    };

    final client = await CreateHttpClint().getSSLPinningClient();

    try {
      Response response = await client.post(
          Uri.parse(url),
          headers: header,
          body: body
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseVar = json.decode(response.body);
        if(responseVar['status'] == Constants.SUCCESS){
          return DataModel.fromJson(responseVar);
        }else if(responseVar['status'] == Constants.ERROR){
          return ErrorResponse.fromJson(responseVar);
        }else{
          throw 'Found an issue with status';
        }
      } else if (response.statusCode == 500) {
        throw 'Server Error, please try again';
      } else if (response.statusCode != 200 && response.statusCode != 500) {
        throw Exception(response.body);
      } else {
        throw 'Request failed, please try again!!!';
      }
    } 
    on SocketException catch (e)
    {
      showNoInternetSnackbar();
    }
    on TimeoutException catch (_) {
      throw 'Looks like your internet is unstable, please try again.';
    } catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> getToken(String device_id,String userid,String token) async {
    await _internetConnection.checkConnectivity();
    var url = 'https://apps.slichealth.com/ords/ihmis_admin/2FA/getUserToken';
    var header = {
      'userid': userid,
      "device_id": device_id,
      "token": token,
    };
    var body = {
      'version': Constants.Version
    };

    final client = await CreateHttpClint().getSSLPinningClient();

    try {
      Response response = await client.post(
          Uri.parse(url),
          headers: header,
          body: body
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseVar = json.decode(response.body);
        if(responseVar['status'] == Constants.SUCCESS){
          return TokenModel.fromJson(responseVar);
        }else if(responseVar['status'] == Constants.ERROR){
          return ErrorResponse.fromJson(responseVar);
        }else{
          throw 'Found an issue with status';
        }
      } else if (response.statusCode == 500) {
        throw 'Server Error, please try again';
      } else if (response.statusCode != 200 && response.statusCode != 500) {
        throw Exception(response.body);
      } else {
        throw 'Request failed, please try again!!!';
      }
    }
    on SocketException catch (e)
    {
      showNoInternetSnackbar();
      throw 'No Internet';
    } 
    on TimeoutException catch (_) {
      throw 'Looks like your internet is unstable, please try again.';
    } catch (e) {
      throw e.toString();
    }
  }

    Future<dynamic> getBackupCodes(String device_id, String userid, String token) async {
    await _internetConnection.checkConnectivity();
    var url = 'https://apps.slichealth.com/ords/ihmis_admin/2FA/generateBackupCodes';
    var header = {
      'userid': userid,
      "device_id": device_id,
      "token": token,
    };
    var body = {
      'version': Constants.Version
    };

    final client = await CreateHttpClint().getSSLPinningClient();

    try {
      Response response = await client.post(
          Uri.parse(url),
          headers: header,
          body: body
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseVar = json.decode(response.body);
        if(responseVar['status'] == Constants.SUCCESS){
          return BackupCodeModel.fromJson(responseVar);
        }else if(responseVar['status'] == Constants.ERROR){
          return ErrorResponse.fromJson(responseVar);
        }else{
          throw 'Found an issue with status';
        }
      } else if (response.statusCode == 500) {
        throw 'Server Error, please try again';
      } else if (response.statusCode != 200 && response.statusCode != 500) {
        throw Exception(response.body);
      } else {
        throw 'Request failed, please try again!!!';
      }
    }
    on SocketException catch (e)
    {
      showNoInternetSnackbar();
      throw 'No Internet';
    }  
    on TimeoutException catch (_) {
      throw 'Looks like your internet is unstable, please try again.';
    } catch (e) {
      throw e.toString();
    }
  }
}