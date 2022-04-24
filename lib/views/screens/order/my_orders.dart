import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Assistants/globals.dart';
import '../../../controllers/cart_controller.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final CartController cartController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartController.getMyOrders();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: myHexColor,
      child: SafeArea(child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black87,

        ),
      body: SingleChildScrollView(
        child: Obx(()=>Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cartController.gotMyOrders.value ==true ?cartController.buildOrderItem():Container(),
             cartController.gotMyOrders.value ==true ? SizedBox(
                  height: screenSize.height -300,

                  child: buildOrdersList()):Container(),

           
            ],
          ),
        ),


      ),
      ),
      ),
    );
  }

  Widget buildOrdersList() {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        Obx(
              () => SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, indexA) {

                return InkWell(
                  onTap: () {

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 0.7,
                          color: Colors.grey,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:screenSize.width *0.8-46,
                                      child: Text(
                                        'Order ${cartController.myOrders[indexA]['id']}',overflow: TextOverflow.ellipsis,maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[900],fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    Text(
                                      'Placed On  ${DateFormat('yyyy-MM-dd  HH:mm :ss').format(DateTime.parse(cartController.myOrders[indexA]['orderDate']))}',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 2),
                                  child: Row(
                                    children: [
                                      Text(
                                        'View Details',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.blue[700],fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            Divider(
                              thickness: 1,
                              height: 10,
                            ),

                            // Text("${cartController.myOrdersDetails[0]['listProduct'][0]['product']}")
                        ]),
                      ),
                    ),
                  ),
                );
              },
              childCount: cartController.myOrders.length,
              semanticIndexOffset: 2,
            ),
          ),
        ),


      ],
    );
  }
  Widget buildOrderItems(int indexA){
    print(indexA);
    return  SizedBox(
      width: 100,
      height: 100,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          Obx(
                () => SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {

                  return InkWell(
                    onTap: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 0.7,
                            color: Colors.grey,
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child:Obx(()=>
                               Column(
                                children: [
                                  Text('${cartController.myOrdersDetails[3]['listProduct'][index]['product']}'),
                                  Text('${cartController.myOrdersDetails[3]['listProduct'][index]['color']}'),

                                ],
                              ),
                            )
                        ),
                      ),
                    ),
                  );
                },
                childCount: cartController.myOrdersDetails[indexA]['listProduct'].length,
                semanticIndexOffset: 2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
