import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stroke_text/stroke_text.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData(
      primaryColor: const Color(0xFF1349EF) /* const Color(0xFF3378F3) */,
      primaryColorDark: const Color(0xFF3378F3),
      backgroundColor: Colors.white /* const Color(0xFF041A75) */,
      splashColor: Colors.black,/* Colors.white */
      indicatorColor: const Color(0xFF1349EF), /* Colors.white */
    );
    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                left: -50,
                top: 50,
                child: Image.asset('assets/images/wifi.png', color: themeData.primaryColor,)),
              Padding(
                padding: EdgeInsets.all(13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 200,),
                    
                    StrokeText(
                      strokeColor: themeData.indicatorColor,
                      strokeWidth: 3,
                      text: "Oops!",
                      textStyle: TextStyle(
                        fontFamily: "BambinoNew",
                        fontWeight: FontWeight.bold,
                        fontSize: 100,
                        color: themeData.backgroundColor
                      ),
                    ),
                
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 20),
                      child: Text("No internet Connection!", style: TextStyle(
                        fontFamily: "BambinoNew",
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: themeData.splashColor
                      ),),
                    ),
          
          
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),                
                        child: Text("Something went wrong. Try refreshing the page or checking your internet connection. We'll see you in a moment!", 
                        style: TextStyle(
                        fontFamily: "BambinoNew",
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: themeData.splashColor
                      ),),
                    ),
          
                    SizedBox(height: 50,),
          
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),                
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                              
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeData.primaryColor,
                                shadowColor: Colors.blueAccent,
                                elevation: 10,
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 100),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text('Retry', style: TextStyle(fontSize: 16, color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}