import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
class Storage{
    final _storage = FlutterSecureStorage();

    Future<void> storeToken(String token) async {
      await _storage.write(key: 'token', value: token,);
    }

    Future<String?> getToken() async {
      return await _storage.read(key: 'token');
    }

    Future<void> storeDeviceId(String deviceId) async {
      await _storage.write(key: 'deviceId', value: deviceId,);
    }

    Future<String?> getDeviceId() async {
      return await _storage.read(key: 'deviceId');
    }

    Future<void> storeFullname(String fullname) async {
      await _storage.write(key: 'name', value: fullname,);
    }

    Future<String?> getFullname() async {
      return await _storage.read(key: 'name');
    }

    Future<void> storeLoginId(String loginId) async {
      await _storage.write(key: 'user_id', value: loginId,);
    }

    Future<String?> getLoginId() async {
      return await _storage.read(key: 'user_id');
    }

    Future<void> storePassword(String password) async {
      await _storage.write(key: 'password', value: password,);
    }

    Future<String?> getPassword() async {
      return await _storage.read(key: 'password');
    }

    Future<String?> loginStatus() async{
      return await _storage.read(key: 'user_id');
    }

    Future<bool> clearStorage()async{
      try{
        // await _storage.deleteAll();
        await _storage.delete(key: 'token');
        await _storage.delete(key: 'user_id');
        await _storage.delete(key: 'password');
        await _storage.delete(key: 'name');


        return true;
      }catch(e){
        return false;
      }
    }
}