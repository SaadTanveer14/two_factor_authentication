import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAlertDialogContent extends StatelessWidget {

  void _openStore() async {
    String storeUrl="";
    if (Platform.isAndroid) {
      storeUrl = 'https://play.google.com/store/apps'; // Android Play Store URL
    } else if (Platform.isIOS) {
      storeUrl = 'https://apps.apple.com/app'; // iOS App Store URL
    }
    if (storeUrl != "") {
      if (await canLaunch(storeUrl)) {
        await launch(storeUrl);
      } else {
        throw 'Could not launch $storeUrl';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 0.12.sh,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 0.05.sh,
                    ),
                    Text(
                      'App Update Required!',
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w600
                        ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'We have added new features and fixed some bugs \nto make your experience seamless.',
                      style: TextStyle(
                        color: const Color(0xFFA8A2A6),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () { 
                              SystemNavigator.pop(); // This will exit the app
                           },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                          ),
                          child: Text(
                            "Exit",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.black)
                          ),
                           onPressed: _openStore,
                          child: const Text("Update App"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              child: Image.asset('assets/images/rocket.png'),
              height: 150,
              width: 150,
            ),
          ),

        ],
      ),
    );
  }
}