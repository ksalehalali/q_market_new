
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Assistants/globals.dart';
import '../../../controllers/cart_controller.dart';
import '../../widgets/horizontal_listOfProducts.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!cartController.isCartEmpty.value) Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("${assetsIconDir}sad cart.svg"),
                      SizedBox(height: 32,),
                      const Text(
                        "Shopping cart is empty!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16,),
                      const Text(
                        "Shop now & add things you love to the cart",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54
                        ),
                      ),
                    ],
                  ),
                )
                else Column(
                  children: [
                    // DELIVERY ADDRESS
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Row(
                        children: const [
                          Icon(Icons.directions_car_rounded, color: Colors.black54,),
                          SizedBox(width: 8,),
                          Text(
                            "Delivery address",
                            style: TextStyle(
                                color: Colors.black54
                            ),
                          ),
                          SizedBox(width: 8,),
                          // TODO: REPLACE THE 'ADDRESS' WORD WITH THE ACTUAL VARIABLE NAME
                          Text(
                            "Address",
                            style: TextStyle(
                                color: Colors.black54
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54, size: 16,),
                          SizedBox(width: 8,),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0,),
                    Divider(thickness: 1.0, color: Colors.black54,),
                    SizedBox(height: 16.0,),
                    cartController.buildCartItem(),
                  ],
                ),

                SizedBox(height: 32,),
                Container(
                  child: const Text(
                    "Things you might like",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: 32,),
                buildHorizontalListOfProducts(false),

//              Container(
//                height: 250,
//                child: ListView(
//                  scrollDirection: Axis.horizontal,
//                  children: [
//                    // A SINGLE PRODUCT
//                    Container(
//                      width: 175,
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Stack(
//                            children: [
//                              Image.asset(
//                                "${assetsDir}digital-marketing-courses-in-qatar-featured-image.jpeg",
//                                width: 175,
//                              ),
//                              Positioned(
//                                top: 8.0,
//                                left: 8.0,
//                                child: SvgPicture.asset(
//                                  "${assetsIconDir}tick.svg"
//                                ),
//                              )
//                            ],
//                          ),
//                          SizedBox(height: 5.0,),
//                          const Text(
//                            "Christian Dior cream 50 ml sad",
//                            style: TextStyle(
//                              color: Colors.black54,
//                              fontSize: 18
//                            ),
//                          ),
//                          SizedBox(height: 5.0,),
//                          const Text(
//                            "128.00 \$",
//                            style: TextStyle(
//                              color: Colors.black54,
//                              fontWeight: FontWeight.bold,
//                              fontSize: 20
//                            ),
//                          ),
//
//                        ],
//                      ),
//                    ),
//                    SizedBox(width: 16.0,),
//                    // A SINGLE PRODUCT
//                    Container(
//                      width: 175,
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Stack(
//                            children: [
//                              Image.asset(
//                                "${assetsDir}productsample.jpg",
//                                width: 175,
//                              ),
//                              Positioned(
//                                top: 8.0,
//                                left: 8.0,
//                                child: SvgPicture.asset(
//                                    "${assetsIconDir}tick.svg"
//                                ),
//                              )
//                            ],
//                          ),
//                          SizedBox(height: 5.0,),
//                          const Text(
//                            "Christian Dior cream 50 ml sad",
//                            style: TextStyle(
//                                color: Colors.black54,
//                                fontSize: 18
//                            ),
//                          ),
//                          SizedBox(height: 5.0,),
//                          const Text(
//                            "128.00 \$",
//                            style: TextStyle(
//                                color: Colors.black54,
//                                fontWeight: FontWeight.bold,
//                                fontSize: 20
//                            ),
//                          ),
//
//                        ],
//                      ),
//                    ),
//
//                    SizedBox(width: 16.0,),
//                    // A SINGLE PRODUCT
//                    Container(
//                      width: 175,
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Stack(
//                            children: [
//                              Image.asset(
//                                "${assetsDir}productsample.jpg",
//                                width: 175,
//                              ),
//                              Positioned(
//                                top: 8.0,
//                                left: 8.0,
//                                child: SvgPicture.asset(
//                                    "${assetsIconDir}tick.svg"
//                                ),
//                              )
//                            ],
//                          ),
//                          SizedBox(height: 5.0,),
//                          const Text(
//                            "Christian Dior cream 50 ml sad",
//                            style: TextStyle(
//                                color: Colors.black54,
//                                fontSize: 18
//                            ),
//                          ),
//                          SizedBox(height: 5.0,),
//                          const Text(
//                            "128.00 \$",
//                            style: TextStyle(
//                                color: Colors.black54,
//                                fontWeight: FontWeight.bold,
//                                fontSize: 20
//                            ),
//                          ),
//
//                        ],
//                      ),
//                    ),
//
//                    SizedBox(width: 16.0,),
//                    // A SINGLE PRODUCT
//                    Container(
//                      width: 175,
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Stack(
//                            children: [
//                              Image.asset(
//                                "${assetsDir}productsample.jpg",
//                                width: 175,
//                              ),
//                              Positioned(
//                                top: 8.0,
//                                left: 8.0,
//                                child: SvgPicture.asset(
//                                    "${assetsIconDir}tick.svg"
//                                ),
//                              )
//                            ],
//                          ),
//                          SizedBox(height: 5.0,),
//                          const Text(
//                            "Christian Dior cream 50 ml sad",
//                            style: TextStyle(
//                                color: Colors.black54,
//                                fontSize: 18
//                            ),
//                          ),
//                          SizedBox(height: 5.0,),
//                          const Text(
//                            "128.00 \$",
//                            style: TextStyle(
//                                color: Colors.black54,
//                                fontWeight: FontWeight.bold,
//                                fontSize: 20
//                            ),
//                          ),
//
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              ),
                SizedBox(height: 32,),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
