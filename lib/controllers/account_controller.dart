
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../views/screens/auth/register.dart';

import '../Assistants/globals.dart';
import '../views/screens/main_screen.dart';

class AccountController extends GetxController {

  var isLoggedIn = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUserLoginPreference();
  }


  Future<void> fetchUserLoginPreference() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   //
   // await prefs.setString('token', token);
   // await prefs.setString('username', username);
   // await prefs.setString('password', password);
   // await prefs.setString('id', id);

    final storage = GetStorage();

   //
   //  storage.write('token', token);
   // storage.write('username', username);
   // storage.write('password', password);
   // storage.write('id', id);

  }


}