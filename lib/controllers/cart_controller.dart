import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_market_n/controllers/base_controller.dart';

import '../Assistants/globals.dart';
import '../Data/current_data.dart';
import '../models/product_model.dart';

class CartController extends GetxController with BaseController {
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
                            editProdCountCart(myPrCartProducts[i]['id'], countFromItem.value);
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
  Row buildOrderItem(int index) {
    orderItems.value =[];

    for (int i = 0; i < myOrders[index]['result']['prduct'].length; i++) {
      var price = myOrders[index]['result']['prduct'][i]["price"] *
          myOrders[index]['result']['prduct'][i]["offer"] /
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

                ///to do
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 100,
                    child: Image.network(
                      "$baseURL/${myOrders[index]['result']['prduct'][i]['image']}",
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${myOrders[index]['result']['prduct'][i]['product']}",
                      style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),

                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.4 + 10,
                      child: Row(
                        children: [
                          Text(
                            "${myOrders[index]['result']['prduct'][i]["price"]} QAR".toUpperCase(),
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
                            "Discount ${myOrders[index]['result']['prduct'][i]["offer"]}%",
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

              ],
            ),
            Text(
              "${myOrders[index]['result']['prduct'][i]["price"] - price} QAR",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(
              height: 12,
            ),


              ],
            ),
      );
      itemsInserted.value = true;

      update();
    }
    update();
    return Row(
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
      getMyCartProds(true);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future deleteProdFromCart(String prodId) async {
    showLoading('loading');

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
      getMyCartProds(false);
      hideLoading();

    } else {
      hideLoading();
      print(response.reasonPhrase);
    }
  }

  Future getMyCartProds(bool fromAdd) async {
    if(fromAdd){

    }else{
      Future.delayed(5.milliseconds,(){
        showLoading('loading');
      });
    }

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
        cartProducts = json['description'];
        gotMyCart.value = true;
        print('cart items = ${myPrCartProducts.length}');
        calculateFulPriceProducts(0);
       if(fromAdd){

       }else{
         hideLoading();
        }
        update();
      }else{
        if(fromAdd){

        }else{
          hideLoading();
        }
      }
    } else {
      if(fromAdd){
      }else{
        hideLoading();
      }

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

  Future editProdCountCart(String id ,int count)async{
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://dashcommerce.click68.com/api/EditCart'));
    request.body = json.encode({
      "id": id,
      "Number": count
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

  final storage = GetStorage();

  Future addNewOrder(String invoiceId,String paymentGateway,double invoiceValue)async{
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://dashcommerce.click68.com/api/AddOrder'));
    request.body = json.encode({
      "api_key": "u#XW|27@vl*8>n,sCr]qq)K@c^tpC}",
      "api_secret": "/IIOpP`[(9]e`#S1&Yx{zm_w(mkbMO",
      "invoiceValue": invoiceValue,
      "invoiceId": invoiceId,
      "paymentGateway": paymentGateway,
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
      // for(int i =0; i<myOrders.length; i++){
      //   await getOneOrder(myOrders[i]['id']);
      //   print(myOrdersDetails[i]['listProduct'][0]['product']);
      // }
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
