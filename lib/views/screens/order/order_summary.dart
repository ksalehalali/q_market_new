import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:q_market_n/Data/current_data.dart';

import '../../../Assistants/globals.dart';
import '../../../controllers/address_location_controller.dart';
import '../../../controllers/cart_controller.dart';
import 'order_timeline.dart';

class OrderSummary extends StatelessWidget {
   OrderSummary({Key? key}) : super(key: key);
  final AddressController addressController = Get.find();
   final storage = GetStorage();
   final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    int indexAddress = storage.read("indexAddressSelected");

    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0
          ,
          leading: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Icon(Icons.cancel_outlined,color: Colors.grey[500],size: 28,)),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity, height: 120, child: OrderTimeLine()),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Row(
                  children:  [
                    Text('Order : ',style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700]
                    ),),
                     SelectableText(
                      'a23231333',style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[900]

                    ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const Text('SHIPPING ADDRESS ',style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800
                    ),),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text('${addressController.myAddressData[indexAddress]['nameAddress']}',textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w700
                      ),),
                    SizedBox(height: 8,),

                    SizedBox(
                      width: screenSize.width - 50,
                      child: Text('${addressController.myAddressData[indexAddress]['address']}',textAlign: TextAlign.start,overflow: TextOverflow.ellipsis,maxLines: 1,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[900],
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w700
                        ),),
                    ),
                    SizedBox(height: 8,),
                    Text('${addressController.myAddressData[indexAddress]['phone']}',textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w700
                      ),),
                  ],
                ),
              ),
              Divider(height: 42,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const Text('PAYMENT METHOD ',style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800
                    ),),
                    const SizedBox(
                      height: 12.0,
                    ),
                    lastOrder.payment == 0 ?Row(
                      children: [
                        SvgPicture.asset('assets/icons/cash2.svg',
                            //color: Colors.grey[600],
                            height: 22.00,
                            width: 22.0,
                            semanticsLabel: 'A red up arrow'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text('Cash on Delivery',textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w700
                            ),),
                        ),
                      ],
                    ):Row(
                      children: [
                        SvgPicture.asset('assets/icons/creditCard.svg',
                            //color: Colors.grey[600],
                            height: 22.00,
                            width: 22.0,
                            semanticsLabel: 'A red up arrow'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text('Credit Card',textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w700
                            ),),
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),

                  ],
                ),
              ),
              Divider(height: 42,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                        const Text('ORDER SUMMARY ',style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800
                    ),),
                    const SizedBox(
                      height: 12.0,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Subtitle',textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w700
                          ),),
                        Spacer(),
                        Text('QAR ${lastOrder.invoiceValue}',textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w700
                          ),),
                      ],
                    ),
                    SizedBox(height: 14,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Shipping Fee',textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w700
                          ),),
                        Spacer(),
                        Text('FREE',textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 13,
                              color: myHexColor,
                              fontWeight: FontWeight.w700
                          ),),
                      ],
                    ),

                    SizedBox(height: 8,),
                    const SizedBox(
                      height: 12.0,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('TOTAL',textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w700
                          ),),
                        Spacer(),
                        Text('QAR ${lastOrder.invoiceValue}',textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w700
                          ),),
                      ],
                    ),
                    SizedBox(height: 8,),

                  ],
                ),
              ),
              SizedBox(height: 18,),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('PRODUCTS ORDER',style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800
                ),),
              ),
              SizedBox(
                  height: 200,
                  child: _buildOrderProductsList(1))

            ],
          ),
        ),
      ),
    );
  }
   Widget _buildOrderProductsList(int indexA) {
     return CustomScrollView(
       key: const Key('b'),

       scrollDirection: Axis.horizontal,
       slivers: [
         Obx(
               () => SliverList(
             delegate: SliverChildBuilderDelegate(
                   (context, index) {
                 var price = cartController.oneOrderDetails['listProduct'][index]["price"] *
                     cartController.oneOrderDetails['listProduct'][index]["offer"] /
                     100;
                 return InkWell(
                   onTap: () {

                   },
                   child:  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       SizedBox(
                         height: 3,
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [

                           ///to do
                           ClipRRect(
                             borderRadius: BorderRadius.circular(10),
                             child: Container(
                               width: 80,
                               child: Image.network(
                                 "$baseURL/${cartController.oneOrderDetails['listProduct'][index]['image']}",
                                 height: 122,
                                 fit: BoxFit.fill,
                               ),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left: 8.0),
                             child: Container(
                               height: screenSize.height *0.1+30,

                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                                 children: [
                                   Text(
                                     "${cartController.oneOrderDetails['listProduct'][index]['product']}",
                                     style: const TextStyle(
                                         color: Colors.black54,
                                         fontWeight: FontWeight.bold,
                                         fontSize: 14),
                                   ),

                                   const SizedBox(
                                     height: 8,
                                   ),
                                   SizedBox(
                                     width: screenSize.width * 0.4 + 10,
                                     child: Row(
                                       children: [
                                         Text(
                                           "${cartController.oneOrderDetails['listProduct'][index]["price"]} QAR".toUpperCase(),
                                           overflow: TextOverflow.ellipsis,
                                           maxLines: 1,
                                           textAlign: TextAlign.left,
                                           style: const TextStyle(
                                               decoration: TextDecoration.lineThrough,
                                               fontFamily: 'Montserrat-Arabic Regular',
                                               color: Colors.grey,
                                               fontSize: 13),
                                         ),
                                         const SizedBox(
                                           width: 7.0,
                                         ),
                                         Text(
                                           "Discount ${cartController.oneOrderDetails['listProduct'][index]["offer"]}%",
                                           overflow: TextOverflow.ellipsis,
                                           maxLines: 1,
                                           textAlign: TextAlign.left,
                                           style: TextStyle(
                                               fontFamily: 'Montserrat-Arabic Regular',
                                               color: myHexColor3,
                                               fontSize: 13),
                                         ),
                                       ],
                                     ),
                                   ),
                                   Text(
                                     "${cartController.oneOrderDetails['listProduct'][index]["price"] - price} QAR",
                                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                   ),

                                   const SizedBox(
                                     height: 12,
                                   ),
                                 ],
                               ),
                             ),
                           ),

                         ],
                       ),



                     ],
                   ),
                 );

               },
               childCount: cartController.oneOrderDetails['listProduct'].length,
               semanticIndexOffset: 2,
             ),
           ),
         )
       ],
     );
   }
}
