import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:q_market_n/Assistants/globals.dart';
import 'package:q_market_n/views/screens/home/Cart.dart';

import '../controllers/address_location_controller.dart';
import '../controllers/cart_controller.dart';
import 'address/list_addresses.dart';

class BuyOptions extends StatefulWidget {
  const BuyOptions({Key? key}) : super(key: key);

  @override
  State<BuyOptions> createState() => _BuyOptionsState();
}

class _BuyOptionsState extends State<BuyOptions> {
  int _value =1;
  final storage = GetStorage();
  bool showAddressDetails=false;
  final AddressController addressController = Get.find();
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    int indexAddress = storage.read("indexAddressSelected");
    if(indexAddress != null){
      showAddressDetails =true;
    }
    return Container(
      color: myHexColor,
      child: SafeArea(child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey[800],

          elevation: 0.0,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(width: screenSize.width,height: 1,color: myHexColor,),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Shipping Address',style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700
                              ),),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text('Change Address',textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: myHexColor,
                                  fontWeight: FontWeight.w700
                              ),),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${addressController.myAddressData[indexAddress]['nameAddress']}',textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[900],
                                    fontWeight: FontWeight.w700
                                ),),
                              SizedBox(height: 5,),

                              SizedBox(
                                width: screenSize.width - 50,
                                child: Text('${addressController.myAddressData[indexAddress]['address']}',textAlign: TextAlign.start,overflow: TextOverflow.ellipsis,maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[900],
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w700
                                  ),),
                              ),
                              SizedBox(height: 5,),
                              Text('${addressController.myAddressData[indexAddress]['phone']}',textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[900],
                                    fontWeight: FontWeight.w700
                                ),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    color: Colors.grey[200],
                    width: screenSize.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0,right: 12.0,left: 12.0,bottom: 16),
                          child: Text('Payment method',style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700
                          ),),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(right: 18.0,left: 18,bottom: 12),
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Radio(value: 1, groupValue: _value, onChanged: (int? val){
                                  setState(() {
                                    _value = val!;
                                  });
                                }),
                                Text('Pay by card'),
                                Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: SvgPicture.asset('assets/icons/creditCard.svg',
                                    //color: Colors.grey[600],
                                    height: 22.00,
                                    width: 22.0,
                                    semanticsLabel: 'A red up arrow'),)
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 18.0,left: 18,bottom: 28),
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Radio(value: 2, groupValue: _value, onChanged: (int? val){
                                  setState(() {
                                    _value =val!;
                                  });
                                }),
                                Text('Cash pay'),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: SvgPicture.asset('assets/icons/cash2.svg',
                                      //color: Colors.grey[600],
                                      height: 22.00,
                                      width: 22.0,
                                      semanticsLabel: 'A red up arrow'),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    color: myHexColor.withOpacity(0.1),
                    width: screenSize.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0,right: 12.0,left: 12.0,bottom: 14),
                          child: Text('Order Summary',style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700
                          ),),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 12),
                          child: Container(
                            //color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [


                                Text('Total product price', style:  TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.w600),),
                                Spacer(),
                                 Text(

                                       '${cartController.fullPrice.value.toStringAsFixed(2)}  QAR',
                                    style:  TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.w600),

                                )
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 12),
                          child: Container(
                            //color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [


                                Text('Shipping fee', style:  TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.w600),),
                                Spacer(),
                                Text(

                                    '0.0  QAR',
                                    style:  TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.w600),
                                  ),

                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 12),
                          child: Container(
                            //color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [


                                Text('Total', style:  TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.w600),),
                                Spacer(),
                                Obx(
                                      () => Text(

                                    '${cartController.fullPrice.value.toStringAsFixed(2)}  QAR',
                                    style:  TextStyle(color: Colors.grey[800],fontSize: 14,fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomSheet: buildBuyButton(0),
      ),
      ),
    );
  }
  Widget buildBuyButton(double price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 14),
      child: Card(
        margin: EdgeInsets.zero,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                  onTap: () {
                    cartController.addNewOrder();
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ListAddresses(fromCart: true,)));
                  },
                  child: Container(
                    height: 44,
                    color: myHexColor2,
                    child: Center(
                        child:  Text(
                              'Confirm Order'.toUpperCase(),
                            style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        )
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
