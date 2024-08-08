import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import 'package:towfactor_ios/Controllers/signup_controller.dart';
import 'package:towfactor_ios/Screens/LoginScreen.dart';
import 'package:towfactor_ios/Utilities/Utilities.dart';
import 'package:towfactor_ios/Widgets/alert_dialog.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController useridController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool _obscureText = true;
  bool _visible = true;
  String? deviceId = 'device_id';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeVariables();
  }

  @override
  Widget build(BuildContext context) {
    final signupController = Provider.of<SignUpController>(context);
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
            SizedBox(height: 20,),
            FadeInRight(
              duration: Duration(milliseconds: 1000),
              child: Container(
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
                          labelStyle: TextStyle(color: Colors.black),
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
                          labelText: 'Passwords',
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
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        controller: fullnameController,
                        cursorColor: Colors.blue,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          labelText: 'Your fullname',
                          labelStyle: TextStyle(color: Colors.black),
                          helperStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.person,
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
                        style: TextStyle(color: Colors.black),
                        controller: phoneController,
                        cursorColor: Colors.blue,
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Contact number',
                          labelStyle: TextStyle(color: Colors.black),
                          helperStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.phone_android,
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
                    SizedBox(height: 20,),
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          onPressed: signupController.isLoading ? null : () async{

                            String userid = useridController.text.trim();
                            String password = passwordController.text.trim();
                            String fullname = fullnameController.text.trim();
                            String phoneNo = phoneController.text.trim();

                            if(userid.isEmpty){
                              Utilities.ErrorMessage('Please Enter provided userid');
                            }else if(password.isEmpty){
                              Utilities.ErrorMessage('Please Enter provided password');
                            }else if(fullname.isEmpty){
                              Utilities.ErrorMessage('Please Enter your fullname');
                            }else if(phoneNo.isEmpty){
                              Utilities.ErrorMessage('Please Enter mobile no');
                            }else if(phoneNo.length < 11){
                              Utilities.ErrorMessage('Please Enter correct mobile no');
                            }else if(deviceId!.isEmpty){
                              Utilities.ErrorMessage('Found an issue with your device');
                            }else{
                              /*showDialog(context: context,
                                  builder: (BuildContext context){
                                    return CustomDialogBox(
                                      title: "Custom Dialog Demo",
                                      descriptions: "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                                      text: "Yes",
                                    );
                                  }
                              );*/
                              await signupController.signUp(userid, password, fullname, phoneNo, deviceId!);
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
                              signupController.isLoading
                                  ? Container(width: 20,height: 20,child: CircularProgressIndicator(color: Colors.white,),)
                                  : Text('Signup', style: TextStyle(fontSize: 16, color: Colors.white),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    GestureDetector(
                      onTap: (){
                        Get.off(LoginScreen());
                      },
                      child: Align(
                        alignment: Alignment.topCenter, // Align however you like (i.e .centerRight, centerLeft)
                        child:
                        RichText(text:
                          TextSpan(
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'Already have an account? '),
                              TextSpan(text: 'login', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                            ],

                          ),)

                      ),
                    ),
                    SizedBox(height: 15,),
                  ],
                ),
              ),
            ),
          ],
        )
    );;
  }

  Future<void> _initializeVariables() async {
    String? device = await Utilities.getDeviceID();
    setState(() {
      deviceId = device;
    });
  }
}
