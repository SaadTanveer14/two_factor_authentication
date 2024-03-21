import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:towfactor_ios/Widgets/nointernet_snackbar.dart';

class InternetConnectivity  {
  static final InternetConnectivity _internetConnectivity = InternetConnectivity._privateConstructor();
  factory InternetConnectivity() => _internetConnectivity;
  InternetConnectivity._privateConstructor();

  final Connectivity _connectivity = Connectivity();
  bool _isConnected = false;
  Future<bool> checkConnectivity() async
  {
    final ConnectivityResult result  =  await _connectivity.checkConnectivity();
    _isConnected = result != ConnectivityResult.none;
    if(!_isConnected) {
      showNoInternetSnackbar();
    }
    return _isConnected;
  } 

 }