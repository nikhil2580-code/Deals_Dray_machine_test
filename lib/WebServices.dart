
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<String>getLocalIpAddress() async {
  final InternetAddress internetAddress = await InternetAddress.loopbackIPv4;
  final String ipAddress = internetAddress.address;
  return ipAddress;
}

Future<void> checkAndRequestLocationPermissions()async{
  var status = await Permission.location.status;
  if(!status.isGranted){
    await Permission.location.request();
  }
}

Future<void> sendDeviceData() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String ipAddress = await getLocalIpAddress();
  try {
    await checkAndRequestLocationPermissions();
    var status = await Permission.location.status;
    if(status.isGranted){


      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        prefs.setString('device_id', androidInfo.androidId);
        var deviceData = {
          "deviceType": "android",
          "deviceId": androidInfo.androidId,
          "deviceName": androidInfo.device,
          "deviceOSVersion": androidInfo.version.release,
          "deviceIPAddress": ipAddress,
          "lat": position.latitude,
          "long": position.longitude,
          "buyer_gcmid": "",
          "buyer_pemid": "",
          "app": {
            "version": packageInfo.version,
            "installTimeStamp": packageInfo.buildNumber,
            "uninstallTimeStamp": "",
            "downloadTimeStamp": ""
          }
        };
        var url = Uri.parse(
            'http://devapiv3.dealsdray.com/api/v2/user/device/add');
        var response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(deviceData),
        );
        // if (response.statusCode == 200) {
        print('Device data sent successfully');
        print("Device data:$deviceData");
        // } else {
        //   print('Failed to send device data');
        //   print("Device data:$deviceData");
        //
        // }
      }}
  } catch(e) {
    print('Error obtaining device location: $e');
  }
}