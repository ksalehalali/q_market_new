import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:q_market_n/Data/current_data.dart';
import 'package:q_market_n/views/screens/main_screen.dart';
import '../../../Assistants/globals.dart';
import '../../../controllers/address_location_controller.dart';
import '../../../controllers/cart_controller.dart';
import 'order_timeline.dart';

class OrderSummary extends StatelessWidget {
  final bool fromOrdersList;
   OrderSummary({Key? key,required this.fromOrdersList}) : super(key: key);
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
               if(fromOrdersList ==true) {
                 Navigator.of(context).pop();

               }else{
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const MainScreen()));
               }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0,left: 8,bottom: 1,top: 1),
                child: Icon(Icons.cancel_outlined,color: Colors.grey[500],size: 28,),
              )),
          actions:  [
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: (){
                  showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      transitionDuration: 500.milliseconds,
                      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
                      barrierColor: Colors.black.withOpacity(0.5),
                      pageBuilder: (context,_,__){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: screenSize.width,
                              color: Colors.white,
                              child: Card(
                                child:Column(
                                  children: [
                                    const SizedBox(height: 55,),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10,right: 10),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset('assets/icons/done.svg',width: 34,height: 34,color: myHexColor,),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 4.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,

                                                      children:  [
                                                        SizedBox(
                                                          width: screenSize.width *0.4,
                                                          child: const Text('iphone 12 232323 32323 32323 2323 23233 32',maxLines: 1,overflow:TextOverflow.ellipsis,style:  TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w700,
                                                              color: Colors.black87
                                                          ),),
                                                        ),
                                                        Text('Added to cart ',style:  TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w700,
                                                            color: Colors.black87
                                                        ),),
                                                      ],
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 80.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children:  [
                                                        const Text('Cart Total',style:  TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w700,
                                                            color: Colors.black87
                                                        ),),
                                                        Obx(()=> Text(cartController.fullPrice.value.toStringAsFixed(2),style:  const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w700,
                                                            color: Colors.black87
                                                        ),),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();

                                          },
                                          style: ElevatedButton.styleFrom(
                                              maximumSize: Size(200,220),
                                              minimumSize: Size(18, 34),
                                              primary: Colors.green[800],
                                              onPrimary: Colors.green[900],
                                              alignment: Alignment.center),
                                          child: Text('CONTINUE SHOPPING',maxLines:1,style: const TextStyle(fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {

                                          },
                                          style: ElevatedButton.styleFrom(
                                              maximumSize: Size(200,220),
                                              minimumSize: Size(180, 34),
                                              primary: myHexColor,
                                              onPrimary: Colors.white,
                                              alignment: Alignment.center),
                                          child: const Text('CHECKOUT',style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),),
                                        ),
                                      ],
                                    )
                                  ],
                                ) ,
                              ),
                            )
                          ],
                        );
                      },
                      transitionBuilder: (context,animation,secondaryAnimation,child){
                        return SlideTransition(position: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOutCubic,
                        ).drive(Tween<Offset>(
                            begin: const Offset(0,-1.0),
                            end:Offset.zero
                        ),),
                          child: child,);
                      }


                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 8.0,left: 8,bottom: 1,top: 1),
                  child: Text('CANCEL',textAlign: TextAlign.end,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: Colors.red),),
                ),
              ),
            )
          ],

        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity, height: 120, child: OrderTimeLine(status:cartController.oneOrderDetails['status'] ,)),
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
                      color: Colors.grey[800]
                    ),),
                     SizedBox(
                       width: screenSize.width -110,
                       child: SelectableText(
                         cartController.oneOrderDetails['id'],
                         maxLines: 1,
                         scrollPhysics: ScrollPhysics(),
                         style: TextStyle(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[900]

                    ),
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
                        Text('QAR ${cartController.oneOrderDetails['total']}',textAlign: TextAlign.start,
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
                        Text('QAR ${cartController.oneOrderDetails['total']}',textAlign: TextAlign.start,
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
                  child: _buildOrderProductsList())

            ],
          ),
        ),
      ),
    );
  }
   Widget _buildOrderProductsList() {
     return CustomScrollView(
       key: const Key('b'),

       scrollDirection: Axis.horizontal,
       physics: ScrollPhysics(),

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
                   child:  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                      Container(
                        height: 100,
                        width: 2,
                        color: Colors.blueGrey,
                      ),
                       Column(
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
