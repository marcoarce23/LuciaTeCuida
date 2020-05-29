import 'package:flutter/material.dart';
import 'package:luciatecuida/src/module/Login/SignUpModule.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenModule extends StatefulWidget {
  @override
  SplashScreenModuleState createState() => SplashScreenModuleState();
}

class SplashScreenModuleState extends State<SplashScreenModule> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new SignUpModule(),
     
      photoSize: 210,
      image: Image(
        image: AssetImage('assets/fondo.png') ,       
        fit: BoxFit.cover,
      ),
    
  
    );
  }
}
//RadialGradient