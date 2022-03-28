
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/account_controller.dart';
import '../../../controllers/register_controller.dart';

class Account extends StatelessWidget {
  Account({Key? key}) : super(key: key);

  final registerController = Get.put(RegisterController());
  final accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // WELCOME
              Container(
                height: 75,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(56, 216, 218, 1.0),
                      ),
                    ),
                    Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54
                      ),
                    )
                  ],
                ),
              ),
              // MY ACCOUNT
              Container(
                height: 75,
                color: Color.fromRGBO(245, 246, 248, 1.0),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                  child: Text(
                    "My Account",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              buildOptionRow("Favorite List", Icons.favorite_border),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 64.0),
                child: Divider(
                  thickness: 1,
                ),
              ),
              buildOptionRow("Personal File", Icons.account_circle_outlined),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 64.0),
                child: Divider(
                  thickness: 1,
                ),
              ),
              buildOptionRow("My Orders", Icons.shopping_bag_outlined),
              // APP SETTINGS
              Container(
                height: 75,
                color: Color.fromRGBO(245, 246, 248, 1.0),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                  child: Text(
                    "App Settings",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              buildOptionRow("Language", Icons.language),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 64.0),
                child: Divider(
                  thickness: 1,
                ),
              ),
              buildOptionRow("Notifications", Icons.notification_important_outlined),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 64.0),
                child: Divider(
                  thickness: 1,
                ),
              ),
              // CONTACT US
              Container(
                height: 75,
                color: Color.fromRGBO(245, 246, 248, 1.0),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                  child: Text(
                    "Contact Us",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              buildOptionRow("Help And Technical Support", Icons.contact_support_outlined),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 64.0),
                child: Divider(
                  thickness: 1,
                ),
              ),
              buildOptionRow("Terms Of Usage", Icons.event_note_outlined),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 64.0),
                child: Divider(
                  thickness: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildOptionRow(String optionText, IconData optionIcon) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        height: 75,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              optionIcon,
              size: 30,
              color: Colors.black54,
            ),
            SizedBox(width: 16,),
            Text(
              optionText,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
                fontWeight: FontWeight.bold
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.black54,),
          ],
        ),
      ),
    );
  }

}
