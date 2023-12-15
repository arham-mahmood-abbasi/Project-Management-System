import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:paca_app/Model/Authentication/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("login_details");
  }

  static Future<Map?> getLoginDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("login_details");
    print(jsonString);
    if (jsonString != null) {
      return json.decode(jsonString);
    } else {
      return null;
    }
  }

  static Future<void> setLoginDetails(Map model) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(model.toJson());

    await prefs.setString("login_details", jsonString);
  }

  static Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("login_details");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginSc();
    }));
  }
}
