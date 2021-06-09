import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

SharedPreferences prefs;
const Color primaryColor = Color(0xffFF0000);
const String token = "wjeiwenwejwkejwke98w9e8wewnew8wehwenj232jh32j3h2j3h2j";

final String path_api = "http://192.168.0.105:82/flutterrestaurant/api/";
final String path_images = "http://192.168.0.105:82/flutterrestaurant/images/";
final String images_Category = path_images + "category/";
final String imagesFood = path_images + "food/";
final String currency = "ل.س";
String G_cus_id_val = "";

final String G_cus_id = "cus_id";
final String G_cus_name = "cus_name";
final String G_cus_mobile = "cus_mobile";
final String G_cus_email = "cus_email";
final String G_cus_image = "cus_image";

Future<bool> checkConnection() async {
  try {
    return true;
    final result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print("connect");
      return true;
    } else {
      print("not connect");
      return false;
    }
  } on SocketException catch (_) {
    print("not connect");
    return false;
  }
}
