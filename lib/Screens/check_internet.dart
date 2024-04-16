import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:towfactor_ios/Screens/home_screen.dart';
import 'package:towfactor_ios/Screens/no_internet.dart';

class CheckInternet extends StatefulWidget {
  const CheckInternet({super.key});

  @override
  State<CheckInternet> createState() => _CheckInternetState();
}

class _CheckInternetState extends State<CheckInternet> {
  late Stream<ConnectivityResult> connectivityStream;
  @override
  void initState() {
    super.initState();
    connectivityStream = Connectivity().onConnectivityChanged;
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: connectivityStream,
        builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
        print(snapshot.toString());
        if(snapshot.data == ConnectivityResult.mobile || snapshot.data == ConnectivityResult.wifi){
          return const HomeSreen();
        }
        else
        {
          return const NoInternet();
        }
      }
    );

  }
}