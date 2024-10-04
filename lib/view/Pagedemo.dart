import 'package:deals_dray_test/view/landingPage.dart';
import 'package:deals_dray_test/view/registration.dart';
import 'package:deals_dray_test/view/spalsh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loginPage.dart';
import 'otpScreen.dart';

class PageDemo extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("NavigationPage"),

      ),
      body: Center(child: Column(
        children: [
          SizedBox(height: 30,),
          TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen()));}, child: Text("SplashPage")),
          SizedBox(height: 30,),
          TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));}, child: Text("Login")),
          SizedBox(height: 30,),
          TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));}, child: Text("Register")),
          SizedBox(height: 30,),
          TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Landingpage()));}, child: Text("Landing Page")),
          SizedBox(height: 30,),
          TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));}, child: Text("OTP screen")),
        ],
      )),
    );
  }
}