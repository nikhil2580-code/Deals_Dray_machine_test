import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DealsdrayService {
  static const String baseUrl = "http://devapiv3.dealsdray.com/api/v2";
  static const String loginEndpoint = "/user/otp";

  Future<Map<String, dynamic>> loginUser(
      String mobileNumber, String deviceId) async {
    final url = Uri.parse("$baseUrl$loginEndpoint");
    final response = await http.post(
      url,
      body: {"mobileNumber": mobileNumber, "deviceId": deviceId},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Login failed with status: ${response.statusCode}");
    }
  }
}

class LoginController extends GetxController {

  RxBool isPhoneSelected = true.obs;
  final GlobalKey<FormState> Fkey = GlobalKey<FormState>();
  RxString phoneNumber = ''.obs;

  final DealsdrayService _dealsdrayService = DealsdrayService();

  Future<void> loginUser(String mobileNumber, String deviceId) async {
    try {
      print("mN: $mobileNumber, Di:$deviceId");
      final response =
      await _dealsdrayService.loginUser(mobileNumber, deviceId);

      print(response);
    } catch (e) {
      print(e.toString());
    }
  }
}
