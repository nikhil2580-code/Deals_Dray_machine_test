
import 'package:deals_dray_test/controller/logincontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'otpScreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          toolbarHeight:220,
          elevation: 0,
          backgroundColor: Colors.white,
          leadingWidth: 30,
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,top: 8),
                  child: Icon(Icons.arrow_back_ios_new,color: Colors.black,size: 30,),
                ),
              ],
            ),
          ),
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Image.asset("assets/svg/logo.png",height:280,width: 280,),
          )
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Obx(()=>
                  Container(
                    height: mqh * 0.07,
                    width: mqw * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.4),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30)

                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {

                            _loginController.isPhoneSelected.value = true;

                          },
                          child: Container(
                            height: mqh * 0.07,
                            width: mqw * 0.3,
                            decoration: BoxDecoration(
                              color: _loginController.isPhoneSelected.value ? Colors.red.shade600 : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                  topRight: Radius.circular(30)

                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Phone',
                                style: TextStyle(
                                  color: _loginController.isPhoneSelected.value ? Colors.white : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _loginController.isPhoneSelected.value = false;
                            });
                          },
                          child: Container(
                            height: mqh * 0.07,
                            width: mqw * 0.3,
                            decoration: BoxDecoration(
                              color: _loginController.isPhoneSelected.value ? Colors.transparent : Colors.red.shade600,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                  topRight: Radius.circular(30)
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  color: _loginController.isPhoneSelected.value ? Colors.black : Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ),
            SizedBox(height: mqh*.045,),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Glad To See You !",style: TextStyle(
                      fontSize: 30,fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: mqh*.038,),

                  Text("Please Provide Your Phone Number ",style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,fontWeight: FontWeight.w400
                  ),),
                ],
              ),


            ),
            SizedBox(height: mqh*.05,),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25),
              child: Form(
                key: _loginController.Fkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        errorStyle: TextStyle(color: Colors.red),
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10), // Limit to 10 characters
                        FilteringTextInputFormatter.digitsOnly, // Allow only digits
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Please enter a valid 10-digit phone number';
                        }
                        // You can add additional phone number validation logic here
                        return null;
                      },
                      onSaved: (value) {
                        _loginController.phoneNumber.value = value!;
                      },
                    ),
                    SizedBox(height: mqh*.05,),
                    Center(
                        child: GestureDetector(
                          onTap: ()async {

                            if (_loginController.Fkey.currentState!.validate()) {
                              _loginController.Fkey.currentState?.save();
                              print('Phone Number: $_loginController._phoneNumber');
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              String? deviceId = prefs.getString('device_id');
                              LoginController().loginUser(_loginController.phoneNumber.value, deviceId!);

                            }
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));

                          },
                          child: Container(
                            height: mqh*0.1,
                            width: mqw,
                            decoration: BoxDecoration(
                              color: Colors.red.shade600,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10)
                              ),
                            ),
                            child: Center(child: Text("SFEND CODE",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white),)),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
