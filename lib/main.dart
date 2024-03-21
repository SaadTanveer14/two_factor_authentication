import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:towfactor_ios/Controllers/backup_code_controller.dart';
import 'package:towfactor_ios/Controllers/login_controller.dart';
import 'package:towfactor_ios/Controllers/signup_controller.dart';
import 'package:towfactor_ios/Controllers/token_controller.dart';
import 'package:towfactor_ios/Screens/splash_screen.dart';
import 'package:towfactor_ios/Utilities/internet_connection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.blue,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => SignUpController()),
        ChangeNotifierProvider(create: (context) => TokenController()),
        ChangeNotifierProvider(create: (context) => BackupCodeController()),
      ],
      child: GetMaterialApp(
        navigatorKey: SignUpController.navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

class InternetConnectivity_internetConnection {
}
