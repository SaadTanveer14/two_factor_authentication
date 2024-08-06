import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
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
      print("signup api ${response.body}\n head ${header}\n body ${body}");
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
  

  static Future<bool> getAppVersion() async {
    var url = "https://apps.slichealth.com/ords/ihmis_admin/2FA/getAppVersion";
    var headers = {'appVersion': '1'};

    final client = await CreateHttpClint().getSSLPinningClient();
    // final client = await SSLUtills().globalContext;

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: headers,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseVar = json.decode(response.body);
          if (responseVar['http_status'] == Constants.SUCCESS) {
            return true;
          } else if (responseVar['http_status'] == Constants.ERROR) {
            return false;
          } else {
            Utilities.showSnackbar('Alert', 'Unknown response status');
            throw Exception('Unknown response status');
          }

      } else {
        Utilities.showSnackbar(
            'Response Code:-' + response.statusCode.toString(),
            response.reasonPhrase??'Login failed');
        throw Exception('Failed to login');
      }
    } 
    on SocketException catch (e)
    {
      // showNoInternetSnackbar();
      throw '${e.toString()}';
    } 
    on HandshakeException catch (e){
      if (kDebugMode) {
        print(e.toString());
      }
      Utilities.showSnackbar(
          '',
          e.toString());
      throw Exception('Handshake with server is failed, please hold on issue will be resolved shortly');
    }catch (e) {
      //Utilities.showSnackbar('Exception', e.toString());
      throw e.toString();
    }
    catch (e) {
      Utilities.showSnackbar('Exception', e.toString());
      throw e.toString();
    }finally {
      client.close();
    }
  }

}