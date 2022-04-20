import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:q_market_n/Data/current_data.dart';
import 'package:q_market_n/models/user.dart';
import '../views/screens/auth/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Assistants/globals.dart';
import '../views/screens/main_screen.dart';

class RegisterController extends GetxController {
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final signUpUsernameController = TextEditingController();
  final signUpEmailController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpConfirmPasswordController = TextEditingController();

  Future<void> makeLoginRequest() async {
    var head = {
      "Accept": "application/json",
      "content-type": "application/json"
    };

    var response = await http
        .post(Uri.parse(baseURL + "/api/Login"),
            body: jsonEncode(
              {
                "UserName": loginEmailController.text,
                "Password": loginPasswordController.text
              },
            ),
            headers: head)
        .timeout(const Duration(seconds: 20), onTimeout: () {
      Fluttertoast.showToast(
          msg: "The connection has timed out, Please try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white70,
          textColor: Colors.black,
          fontSize: 16.0);
      throw TimeoutException('The connection has timed out, Please try again!');
    });

    if (response.statusCode == 500) {
      Fluttertoast.showToast(
          msg: "Error 500",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white70,
          textColor: Colors.black,
          fontSize: 16.0);
    } else if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse["status"]) {
        user.accessToken = jsonResponse["description"]["token"];
        user.id = jsonResponse["description"]["id"];

        storeUserLoginPreference(
            jsonResponse["description"]["token"],
            jsonResponse["description"]["userName"],
            loginPasswordController.text,
            jsonResponse["description"]["id"]);
        Get.to(MainScreen());
      } else {
        Fluttertoast.showToast(
            msg: "Username and password do not match!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white70,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    }
  }

  Future<void> makeAutoLoginRequest(username, password) async {
    var head = {
      "Accept": "application/json",
      "content-type": "application/json"
    };

    var response = await http
        .post(Uri.parse(baseURL + "/api/Login"),
            body: jsonEncode(
              {"UserName": username, "Password": password},
            ),
            headers: head)
        .timeout(const Duration(seconds: 20), onTimeout: () {
      Fluttertoast.showToast(
          msg: "The connection has timed out, Please try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white70,
          textColor: Colors.black,
          fontSize: 16.0);
      throw TimeoutException('The connection has timed out, Please try again!');
    });

    if (response.statusCode == 500) {
      Fluttertoast.showToast(
          msg: "Error 500",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white70,
          textColor: Colors.black,
          fontSize: 16.0);

      Get.to(() => Register());
    } else if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse["status"]) {
        print("auttto login ${jsonResponse["description"]}");
        user = User(
          accessToken: jsonResponse["description"]['token'],
          name: jsonResponse["description"]['userName'],
          phone: jsonResponse["description"]['phoneNumber'],
          email: jsonResponse["description"]['email'],
          id: jsonResponse["description"]['id'],
        );
        storeUserLoginPreference(
            jsonResponse["description"]["token"],
            jsonResponse["description"]["userName"],
            password,
            jsonResponse["description"]["id"]);
        print(jsonResponse["description"]["token"]);
        Get.offAll(MainScreen());
        Get.to(MainScreen());
      } else {
        Fluttertoast.showToast(
            msg: "Username and password do not match!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white70,
            textColor: Colors.black,
            fontSize: 16.0);
        Get.to(() => Register());
      }
    }
  }

  Future<void> storeUserLoginPreference(token, username, password, id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('token', token);
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setString('id', id);

    final storage = GetStorage();

    storage.write('token', token);
    storage.write('username', username);
    storage.write('password', password);
    storage.write('id', id);
  }
}
