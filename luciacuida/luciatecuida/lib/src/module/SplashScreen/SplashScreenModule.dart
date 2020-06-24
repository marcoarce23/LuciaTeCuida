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
    return SafeArea(
          child: SplashScreen(
            backgroundColor: Colors.white, //AppTheme.themeVino,
        seconds: 4,
        navigateAfterSeconds: new SignUpModule(),
       
        photoSize: 200,
        image: Image(
          image: AssetImage('assets/icon.png') ,       
          fit: BoxFit.cover,
        ),
      
  
      ),
    );
  }
}
//RadialGradient