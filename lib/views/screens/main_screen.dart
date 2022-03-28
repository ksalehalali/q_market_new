import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


import '../../Assistants/assistantMethods.dart';
import '../../Assistants/globals.dart';
import '../../controllers/address_location_controller.dart';
import '../../controllers/product_controller.dart';
import 'auth/register.dart';
import 'categories/categories_screen.dart';
import 'home/Cart.dart';
import 'home/account.dart';
import 'home/home.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AddressController addressController = Get.find();

  final List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const Register(),
    const Cart(),
     Account(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();
  final ProductsController productsController = Get.find();

  int? currentTp = 0;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    productsController.getLatestProducts();
  }
  @override
  Widget build(BuildContext context) {
  print(Get.size.height);
  print(Get.size.width);

  return Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        bottomNavigationBar: NavigationBar(
            height: 55.0,
            backgroundColor: Colors.white,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            selectedIndex: currentTp!,
            onDestinationSelected: (index) {
              setState(() {
                currentScreen = screens[index];
                currentTp = index;
              });
            },
            animationDuration: Duration(milliseconds: 1),
            destinations: [
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 11,fontWeight: FontWeight.bold))),
                  child: NavigationDestination(
                    icon:  SvgPicture.asset(
                        'assets/icons/home-fill.svg',
                        color: Colors.grey[600],
                        height: 22.00,
                        width: 22.0,
                        semanticsLabel: 'A red up arrow'
                    ),
                    label: 'Home',
                    selectedIcon:  SvgPicture.asset(
                        'assets/icons/home-fill.svg',
                        height: 22.00,
                        width: 22.0,
                        color:myHexColor3,
                        semanticsLabel: 'A red up arrow'
                    ),

                  )),
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                    indicatorColor: Colors.grey.shade200,
                    labelTextStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 11,fontWeight: FontWeight.bold),
                    ),
                  ),
                  child: NavigationDestination(
                    icon:
                    SvgPicture.asset(
                        'assets/icons/categories-outline.svg',
                        color: Colors.grey[600],
                        height: 22.00,
                        width: 22.0,
                        semanticsLabel: 'A red up arrow'
                    ),
                    label: 'Categories',
                    selectedIcon: SvgPicture.asset(
                        'assets/icons/categories-fill.svg',
                        color: myHexColor3,
                        height: 22.00,
                        width: 22.0,
                        semanticsLabel: 'A red up arrow'
                    ),
                  )),
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 11,fontWeight: FontWeight.bold))),
                  child: NavigationDestination(
                    icon: SvgPicture.asset(
                        'assets/icons/offers-outline.svg',
                        color: Colors.grey[600],
                        height: 22.00,
                        width: 22.0,
                        semanticsLabel: 'A red up arrow'
                    ),
                    label: 'Clearance',
                    selectedIcon:
                    SvgPicture.asset(
                        'assets/icons/offers-fill.svg',
                        color: Colors.red,
                        height: 22.00,
                        width: 22.0,
                        semanticsLabel: 'A red up arrow'
                    ),
                  )),
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 11,fontWeight: FontWeight.bold))),
                  child: NavigationDestination(
                    icon: SvgPicture.asset(
                        'assets/icons/cart-outline.svg',
                        color: Colors.grey[600],
                        height: 22.00,
                        width: 22.0,
                        semanticsLabel: 'A red up arrow'
                    ),
                    label: 'Cart',
                    selectedIcon:
                    SvgPicture.asset(
                        'assets/icons/cart-fill.svg',
                        height: 22.00,
                        width: 22.0,
                        color: Colors.red,
                        semanticsLabel: 'A red up arrow'
                    ),
                  )),
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  child: NavigationDestination(
                    icon: SvgPicture.asset(
                        'assets/icons/account-outline.svg',
                        height: 22.00,
                        width: 22.0,
                        color: Colors.grey[600],
                        semanticsLabel: 'A red up arrow'
                    ),
                    label: 'My Account',
                    selectedIcon:
                    SvgPicture.asset(
                        'assets/icons/account-fill.svg',
                        height: 22.00,
                        width: 22.0,
                        color: Colors.red,
                        semanticsLabel: 'A red up arrow'
                    ),
                  )),
            ]));
  }
}
