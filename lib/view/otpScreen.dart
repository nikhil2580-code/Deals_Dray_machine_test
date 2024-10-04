import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:deals_dray_test/view/registration.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final _start = ValueNotifier<int>(90);

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      if (_start.value == 0) {
        timer.cancel();
        // You can also update the state to show a message or resend the OTP
      } else {
        _start.value--;
      }
    });
  }

  Future<void> verifyOTP(String otp, String deviceId) async {
    try {

      final response = await http.post(
        Uri.parse('http://devapiv3.dealsdray.com/api/v2/user/otp/verification'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'otp': otp,
          'deviceId': deviceId,
          'userId': deviceId,
        }),
      );

      if (response.statusCode == 200) {
        print('OTP verification successful');
      } else {
        print('Failed to verify OTP: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while verifying OTP: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => startTimer());
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(.4)),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight:20,
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 30,
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.0, top: 8),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 30,
                  )),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/svg/mobile.png",
              height: 190,
              width: 240,
            ),
            SizedBox(
              height: mqh * .02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "OTP Verification",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: mqh * .038,
                  ),
                  Text(
                    "We have sent a unique OTP number\nto your mobile +91- 9946988566",
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        height: 1.5),
                  ),
                  SizedBox(
                    height: mqh * .038,
                  ),
                  Pinput(
                      length: 4,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      showCursor: true,
                      onCompleted: (pin) async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        String? deviceId = prefs.getString('device_id');
                        verifyOTP(pin,deviceId!);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
                      }
                  ),
                  SizedBox(
                    height: mqh * .02,
                  ),
                  ValueListenableBuilder<int>(
                      valueListenable: _start,
                      builder: (context, value, child){
                        return Padding(
                          padding: const EdgeInsets.only(left: 5.0, top: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${value ~/ 60}:${(value % 60).toString().padLeft(2, '0')}",
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 20),
                              ),
                              GestureDetector(
                                onTap: (){
                                  _start.value = 90;
                                  startTimer();
                                },
                                child: Text(
                                  "SEND AGAIN?",
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
