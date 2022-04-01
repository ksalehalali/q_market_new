
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:q_market_n/views/screens/auth/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Assistants/globals.dart';
import '../views/screens/main_screen.dart';

class AccountController extends GetxController {

  var isLoggedIn = false.obs;
  var username = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUserLoginPreference();
  }


  void signOut() {
    final storage = GetStorage();

    storage.erase();
  }

  Future<void> fetchUserLoginPreference() async {
    final storage = GetStorage();


    storage.read('token');
    username.value = storage.read('username');
    print("ssssssssss ${username.value}");

  }


}