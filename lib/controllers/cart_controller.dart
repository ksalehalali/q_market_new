import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Assistants/globals.dart';
import '../Data/current_data.dart';
import '../models/product_model.dart';

class CartController extends GetxController {
  var isCartEmpty = true.obs;
  var gotMyCart = false.obs;
  var itemsInserted = false.obs;
  var gotMyOrders =false.obs;
  var cartItems = <Widget>[].obs;
  var orderItems = <Widget>[].obs;

  var myPrCartProducts = [].obs;
  var myOrders = [].obs;
  var myOrdersDetails = [].obs;
  var ordersProdsWidget =[];
  var listOfListOrdersWidget =[[],[]];

  var oneOrderDetails = {}.obs;
  var cartProducts = [];
  var fullPrice = 0.0.obs;
  var countFromItem = 1.obs;
  Column buildCartItem() {
    cartItems.value = [];
    print("length ${myPrCartProducts.length}");
    // this list will be filled form the API
    for (int i = 0; i < myPrCartProducts.length; i++) {
      var price = num.parse(myPrCartProducts[i]["price"]) *
          num.parse(myPrCartProducts[i]["offer"]) /
          100;

      update();

      cartItems.add(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${myPrCartProducts[i]['product']}",
                      style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${myPrCartProducts[i]["color"]}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${myPrCartProducts[i]["size"]}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.4 + 10,
                      child: Row(
                        children: [
                          Text(
                            "${myPrCartProducts[i]["price"]} QAR".toUpperCase(),
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
                            "Discount ${myPrCartProducts[i]["offer"]}%",
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
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 100,
                    child: Image.network(
                      "$baseURL/${myPrCartProducts[i]['image']}",
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "${num.parse(myPrCartProducts[i]["price"]) - price} QAR",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "seller ${myPrCartProducts[i]['userName']}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(245, 246, 248, 1),
                      border: Border.all(),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          child: const Icon(Icons.remove),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text("$countFromItem"),
                        const SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: () {
                            countFromItem++;
                          },
                          child: Container(
                            child: const Icon(Icons.add),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (() => deleteProdFromCart(myPrCartProducts[i]['id'])),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      Text(
                        "Remove",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(
              thickness: 2,
            )
          ],
        ),
      );
      itemsInserted.value = true;

      update();
    }
    update();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...cartItems],
    );
  }

  //orders
  Column buildOrderItem() {
    orderItems.value =[];
    print("----0 ${myOrdersDetails[0]['listProduct']}");
    print("----1 ${myOrdersDetails[1]['listProduct']}");
    print("----2 ${myOrdersDetails[2]['listProduct']}");
    print("----3 ${myOrdersDetails[3]['listProduct']}");

    for (int i = 0; i < myOrdersDetails[0]['listProduct'].length; i++) {
      var price = myOrdersDetails[0]['listProduct'][i]["price"] *
          myOrdersDetails[0]['listProduct'][i]["offer"] /
          100;

      update();
      orderItems.add(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${myOrdersDetails[0]['listProduct'][i]['product']}",
                      style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${myOrdersDetails[0]['listProduct'][i]["color"]}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${myOrdersDetails[0]['listProduct'][i]["size"]}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.4 + 10,
                      child: Row(
                        children: [
                          Text(
                            "${myOrdersDetails[0]['listProduct'][i]["price"]} QAR".toUpperCase(),
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
                            "Discount ${myOrdersDetails[0]['listProduct'][i]["offer"]}%",
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
                  ],
                ),
                ///to do
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(10),
                //   child: Container(
                //     width: 100,
                //     child: Image.network(
                //       "$baseURL/${myPrCartProducts[i]['image']}",
                //       height: 150,
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                // ),
              ],
            ),
            Text(
              "${myOrdersDetails[0]['listProduct'][i]["price"] - price} QAR",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "seller ${myOrdersDetails[0]['userName']}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),



                InkWell(
                  onTap: (() => deleteProdFromCart(myPrCartProducts[i]['id'])),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      Text(
                        "Remove",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                )
              ],
            ),
      );
      itemsInserted.value = true;

      update();
    }
    update();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...orderItems],
    );
  }
  Future addToCart(String prodId, colorId, sizeId) async {
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://dashcommerce.click68.com/api/AddCart'));
    request.body = json.encode(
        {"Number": 1, "ProdID": prodId, "ColorID": colorId, "SizeID": sizeId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      getMyCartProds();
    } else {
      print(response.reasonPhrase);
    }
  }

  Future deleteProdFromCart(String prodId) async {
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://dashcommerce.click68.com/api/DeleteCart'));
    request.body = json.encode({"id": prodId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      getMyCartProds();
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getMyCartProds() async {
    gotMyCart.value = false;
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://dashcommerce.click68.com/api/ListCart'));
    request.body = json.encode({"PageNumber": "1", "SizeNumber": "15"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      myPrCartProducts.value = [];
      cartProducts = [];
      cartItems.value = [];
      var json = jsonDecode(await response.stream.bytesToString());
      print(json);
      if (json['status'] == true) {
        myPrCartProducts.value = json['description'];

        gotMyCart.value = true;
        print('cart items = ${myPrCartProducts.length}');
        calculateFulPriceProducts(0);
        update();
      }
    } else {
      print('error in get cart items');
      print(response.reasonPhrase);
    }
  }

  calculateFulPriceProducts(int index) {
    fullPrice.value = 0.0;
    var offer = num.parse(myPrCartProducts[index]['offer']);
    for (int i = 0; i < myPrCartProducts.length; i++) {
      fullPrice.value = fullPrice.value +
          num.parse(myPrCartProducts[i]['price']) -
          num.parse(myPrCartProducts[i]['price']) * offer / 100;
    }
  }
  final storage = GetStorage();

  Future addNewOrder()async{
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://dashcommerce.click68.com/api/AddOrder'));
    request.body = json.encode({
      "api_key": "u#XW|27@vl*8>n,sCr]qq)K@c^tpC}",
      "api_secret": "/IIOpP`[(9]e`#S1&Yx{zm_w(mkbMO",
      "invoiceValue": fullPrice.toDouble(),
      "invoiceId": "11212",
      "paymentGateway": "test",
      "AddressID": storage.read("idAddressSelected"),
      "Payment": 0
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }

  Future getMyOrders()async{
    gotMyOrders.value = false;
    myOrdersDetails.value = [];
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://dashcommerce.click68.com/api/ListOrderByUser'));
    request.body = json.encode({
      "PageNumber": "0",
      "SizeNumber": "22"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];
      myOrders.value =data;
      for(int i =0; i<myOrders.length; i++){
        await getOneOrder(myOrders[i]['id']);
        print(myOrdersDetails[i]['listProduct'][0]['product']);
      }
      print(myOrdersDetails.length);
      gotMyOrders.value = true;

    }
    else {
      print(response.reasonPhrase);
    }

  }

  Future getOneOrder(String id)async{
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://dashcommerce.click68.com/api/GetOrder'));
    request.body = json.encode({
      "id": id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];
      oneOrderDetails.value = data;
      myOrdersDetails.add(data);

      print(oneOrderDetails);

    }
    else {
      print(response.reasonPhrase);
    }

  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
