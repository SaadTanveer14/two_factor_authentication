import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:towfactor_ios/Controllers/login_controller.dart';
import 'package:towfactor_ios/Screens/Signup_screen.dart';

import '../Utilities/Utilities.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController useridController = TextEditingController();
  bool _obscureText = true;
  bool isLogin = true;
  String? deviceId = 'device_id';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeVariables();
  }


  @override
  Widget build(BuildContext context) {

    final loginController = Provider.of<LoginController>(context);

    return Scaffold(
        body:ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Center(
                    child: Image(
                      image: new AssetImage('assets/images/round_logo_frame.jpg'),
                      width: MediaQuery.of(context).size.width/1.5, // Set the desired width
                      height: MediaQuery.of(context).size.width/1.5, // Set the desired height
                    ),
                  ),
                  Center(
                    child: Image(
                      image: new AssetImage('assets/images/updated_logo.png'),
                      width: MediaQuery.of(context).size.width/5.5,
                      height: MediaQuery.of(context).size.width/5.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Align(
              alignment: Alignment.topCenter, // Align however you like (i.e .centerRight, centerLeft)
              child: Text('StateHealth Authenticator',style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 17,

              ),),
            ),
            SizedBox(height: 40,),
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: useridController,
                      cursorColor: Colors.blue,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        labelText: 'Userid',
                        helperText: 'Enter provided userid',
                        labelStyle: TextStyle(color: Colors.black),
                        helperStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.blue, width: 2.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextField(
                      obscureText: _obscureText,
                      style: TextStyle(color: Colors.black),
                      controller: passwordController,
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        helperText: 'Enter provided password',
                        labelStyle: TextStyle(color: Colors.black),
                        helperStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.blue,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.blue, width: 2.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          String userid = useridController.text;
                          String password = passwordController.text;

                          if(userid.isEmpty){
                            Utilities.ErrorMessage('Please enter userid ');
                          }else if(password.isEmpty){
                            Utilities.ErrorMessage('Please enter password');
                          }else if (deviceId!.isEmpty){
                            Utilities.ErrorMessage('Found an issue with device.');
                          }else{
                            loginController.userLogin(userid, password,deviceId!);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shadowColor: Colors.blueAccent,
                          elevation: 10,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            loginController.isLoading
                                ? Container(width: 20,height: 20,child: CircularProgressIndicator(color: Colors.white,),)
                                : Text('Login', style: TextStyle(fontSize: 16, color: Colors.white),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      Get.to(SignupScreen());
                    },
                    child: Align(
                      alignment: Alignment.topCenter, // Align however you like (i.e .centerRight, centerLeft)
                      child: Text('Dont have an account?Signup.',style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,

                      ),),
                    ),
                  )
                ],
              ),
            )

          ],
        )
    );
  }

  Future<void> _initializeVariables() async {
    String? device = await Utilities.getDeviceID();
    setState(() {
      deviceId = device;
    });
  }
}
