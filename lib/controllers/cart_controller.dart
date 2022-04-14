import 'dart:convert';
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

  var cartItems = <Widget>[].obs;
  var myPrCartProducts = [].obs;
  var cartProducts = [];
  var fullPrice = 0.0.obs;

  Column buildCartItem() {
    print("length ${myPrCartProducts.length}");
    // this list will be filled form the API
    for (int i = 0; i < myPrCartProducts.length; i++) {
      var price = num.parse(myPrCartProducts[i]["price"]) *
          num.parse(myPrCartProducts[i]["offer"]) /
          100;
      //TODO
      //fullPrice.value = fullPrice.value + price;
      update();

      cartItems.add(
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      const Text(
                        "Perfume description text",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${myPrCartProducts[i]["price"]} \$",
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.black54,
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
                "${num.parse(myPrCartProducts[i]["price"]) - price} QR",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                          const Text("1"),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            child: const Icon(Icons.add),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (() =>
                        deleteProdFromCart(myPrCartProducts[i]['id'])),
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
        ),
      );
      itemsInserted.value = true;

      update();
    }
    update();
    return Column(
      children: [...cartItems],
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
      myPrCartProducts.value = json['description'];
      print(json);
      gotMyCart.value = true;
      calculateFulPriceProducts(0);
      update();
    } else {
      print(response.reasonPhrase);
    }
  }

  calculateFulPriceProducts(int index) {
    fullPrice.value = 0.0;
    var offer = num.parse(myPrCartProducts[index]['offer']);
    for (int i = 0; i < myPrCartProducts.length; i++) {
      fullPrice.value = fullPrice.value +
          num.parse(myPrCartProducts[i]['price']) * offer / 100;
    }
  }

  Future getOneProductDetailsForCart(String id) async {
    print('get prod id :: $id');
    var headers = {
      'Authorization': 'bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$baseURL/api/GetProduct'));
    request.body = json.encode({'id': id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var productData = json['description'];

      print('full product $productData');
      return ProductModel(
        id: productData['id'],
        en_name: productData['name_EN'],
        ar_name: productData['name_AR'],
        price: double.parse(productData['price'].toString()),
        offer: productData['offer'],
        imageUrl: productData['primaryImage'],
        catId: productData['catID'],
        categoryNameEN: productData['categoryName_EN'],
        categoryNameAR: productData['categoryName_AR'],
        modelName: productData['modelName'],
        modelId: productData['modelID'],
        userId: productData['userID'],
        userName: productData['userName'],
        general: productData['general'],
        special: productData['spical'],
        providerName: productData['merchentName'],
        providerId: productData['merchentID'],
        colorsData: productData['image'],
        brand: productData['brandName'],
      );
    }
  }
}
