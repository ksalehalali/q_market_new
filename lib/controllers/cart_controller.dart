import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Assistants/globals.dart';
import '../Data/current_data.dart';
import '../models/product_model.dart';

class CartController extends GetxController {
  var isCartEmpty = true.obs;
  var gotMyCart =false.obs;
  var cartItems = <Widget>[].obs;
  var myPrCartProducts= [];
  var cartProducts= [];

  Column buildCartItem() {
    print("length ${myPrCartProducts.length}");
    // this list will be filled form the API
 for(int i = 0; i< myPrCartProducts.length; i++){
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
                 children:  [
                   Text("${myPrCartProducts[i]['product']}", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 16),),
                   SizedBox(height: 8,),
                   Text("Perfume description text", style: TextStyle(fontWeight: FontWeight.w500),),
                   SizedBox(height: 8,),
                    Text(
                     "${myPrCartProducts[i]["price"]} \$",
                     style: TextStyle(
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
                     "$baseURL/${myPrCartProducts[i]['image']}",height: 150,fit: BoxFit.fill,
                   ),
                 ),
               ),

             ],
           ),

           Text(
             "${(int.parse(myPrCartProducts[i]["price"]))-(int.parse(myPrCartProducts[i]["offer"])*1.0)} QR",
             style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold
             ),
           ),
           SizedBox(height: 8,),
            Text(
             "seller ${myPrCartProducts[i]['userName']}",
             style: TextStyle(
                 fontWeight: FontWeight.bold
             ),
           ),
           SizedBox(height: 12,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               ClipRRect(
                 borderRadius: BorderRadius.circular(10),
                 child: Container(
                   padding: EdgeInsets.symmetric(vertical: 4.0),
                   decoration: BoxDecoration(
                     color: Color.fromRGBO(245, 246, 248, 1),
                     border: Border.all(),
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                   ),
                   child: Row(
                     children: [
                       SizedBox(width: 8,),
                       Container(
                         child: Icon(Icons.remove),
                       ),
                       SizedBox(width: 8,),
                       Text("1"),
                       SizedBox(width: 8,),
                       Container(
                         child: Icon(Icons.add),
                       ),
                       SizedBox(width: 8,),
                     ],
                   ),
                 ),
               ),
               Container(
                 child: Row(
                   children: [
                     Icon(Icons.delete_outline, color: Colors.red,),
                     Text("Remove", style: TextStyle(color: Colors.red),)
                   ],
                 ),
               )
             ],
           ),
           SizedBox(height: 16,),
           Divider(thickness: 2,)
         ],
       ),
     ),
   );
   update();

 }

    return Column(
      children: [
        ...cartItems
      ],
    );
  }

  Future addToCart(String prodId,colorId,sizeId)async{
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://dashcommerce.click68.com/api/AddCart'));
    request.body = json.encode({
      "Number": 2,
      "ProdID": prodId,
      "ColorID": colorId,
      "SizeID": sizeId
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

  Future getMyCartProds()async{
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://dashcommerce.click68.com/api/ListCart'));
    request.body = json.encode({
      "PageNumber": "1",
      "SizeNumber": "11"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      myPrCartProducts = json['description'];
      gotMyCart.value =true;

    }
    else {
      print(response.reasonPhrase);
    }

  }

  Future getOneProductDetailsForCart(String id)async{
    print('get prod id :: $id');
    var headers = {
      'Authorization': 'bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$baseURL/api/GetProduct'));
    request.body = json.encode({
      'id':id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var productData = json['description'];

      print('full product $productData');
       return ProductModel(
         id:productData['id'],
         en_name: productData['name_EN'],
         ar_name: productData['name_AR'],
         price: double.parse(productData['price'].toString()),
         offer: productData['offer'],
         imageUrl:productData['primaryImage'],
         catId: productData['catID'],
         categoryNameEN: productData['categoryName_EN'],
         categoryNameAR: productData['categoryName_AR'],
         modelName: productData['modelName'],
         modelId:productData['modelID'],
         userId: productData['userID'],
         userName: productData['userName'],
         general: productData['general'],
         special: productData['spical'],
         providerName: productData['merchentName'],
         providerId: productData['merchentID'],
         colorsData: productData['image'],
         brand: productData['brandName'],

       );

    }}
}
