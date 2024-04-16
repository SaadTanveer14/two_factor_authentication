import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:towfactor_ios/Screens/LoginScreen.dart';
import 'package:towfactor_ios/Screens/home_screen.dart';
import 'package:towfactor_ios/Screens/no_internet.dart';
import 'package:towfactor_ios/Utilities/Storage.dart';
import '../Constants/Constants.dart';
import '../Utilities/Utilities.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? deviceId = 'device_id';
  String? isLoggedIn;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose()
  {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
          print(snapshot.toString());

            if(snapshot.data == ConnectivityResult.mobile || snapshot.data == ConnectivityResult.wifi)
            {
              _initializeVariables();
              // return Center(child: Text("internet Exists"));
              return Scaffold(
                body: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Center(
                          child: Image(
                            image: new AssetImage('assets/images/round_logo_frame.jpg'),
                            width: 200, // Set the desired width
                            height: 200, // Set the desired height
                          ),
                        ),
                        Center(
                          child: Image(
                            image: new AssetImage('assets/images/updated_logo.png'),
                            width: 70, // Set the desired width
                            height: 70, // Set the desired height
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('StateHealth Authenticator',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 17,
                  ),),
                  Container(
                    height: 300,
                    width: 300,
                    color: Colors.transparent,
                    child: Lottie.asset(
                      'assets/Animation/anim.json',
                      repeat: true,
                      reverse: false,
                      animate: true,
                    ),
                  ),
                  SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text('${deviceId!}_${Constants.Version}',style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),),
                  ),
                ],
              ),
              );
            }
            else{
              return NoInternet();
            }
          


          
        }
      );
    
  }

  Future<void> _initializeVariables() async {
    String? device = await Utilities.getDeviceID();
    String? status = await Storage().loginStatus();
    setState(() {
      deviceId = device;
      isLoggedIn = status;
    });

    Future.delayed(Duration(seconds: 3),(){
      if(isLoggedIn != null){
        Get.off(HomeSreen());
      }else{
        Get.off(LoginScreen());
      }
    });
  }
}
