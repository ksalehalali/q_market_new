
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Assistants/globals.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
              Container(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 175,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                "${assetsDir}productsample.jpg",
                                width: 175,
                              ),
                              Positioned(
                                top: 8.0,
                                left: 8.0,
                                child: SvgPicture.asset(
                                  "${assetsIconDir}tick.svg"
                                ),
                              )
                            ],
                          ),
                          const Text(
                            "Christian Dior cream 50 ml sad",
                            style: TextStyle(
                              color: Colors.black54
                            ),
                          ),
                          const Text(
                            "128.00 \$",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold
                            ),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      width: 175,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                "${assetsDir}productsample.jpg",
                                width: 175,
                              ),
                              Positioned(
                                top: 8.0,
                                left: 8.0,
                                child: SvgPicture.asset(
                                    "${assetsIconDir}tick.svg"
                                ),
                              )
                            ],
                          ),
                          const Text(
                            "Christian Dior cream 50 ml sad",
                            style: TextStyle(
                                color: Colors.black54
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 175,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                "${assetsDir}productsample.jpg",
                                width: 175,
                              ),
                              Positioned(
                                top: 8.0,
                                left: 8.0,
                                child: SvgPicture.asset(
                                    "${assetsIconDir}tick.svg"
                                ),
                              )
                            ],
                          ),
                          const Text(
                            "Christian Dior cream 50 ml sad",
                            style: TextStyle(
                                color: Colors.black54
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 175,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                "${assetsDir}productsample.jpg",
                                width: 175,
                              ),
                              Positioned(
                                top: 8.0,
                                left: 8.0,
                                child: SvgPicture.asset(
                                    "${assetsIconDir}tick.svg"
                                ),
                              )
                            ],
                          ),
                          const Text(
                            "Christian Dior cream 50 ml sad",
                            style: TextStyle(
                                color: Colors.black54
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 175,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                "${assetsDir}productsample.jpg",
                                width: 175,
                              ),
                              Positioned(
                                top: 8.0,
                                left: 8.0,
                                child: SvgPicture.asset(
                                    "${assetsIconDir}tick.svg"
                                ),
                              )
                            ],
                          ),
                          const Text(
                            "Christian Dior cream 50 ml sad",
                            style: TextStyle(
                                color: Colors.black54
                            ),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 32,),
            ],
          ),
        ),
      ),
    );
  }
}
