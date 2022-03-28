import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../Assistants/globals.dart';
import '../models/product_model.dart';

import '../Data/current_data.dart';
import '../models/product_colors_data.dart';

class ProductsController extends GetxController {
var latestProducts = <ProductModel>[].obs;
var product = ProductModel().obs;
ProductModel productDetails = ProductModel();
var colorsData=[].obs;
var getDetailsDone= false.obs;
var imagesWidget=[].obs;



Future getLatestProducts()async{
  getDetailsDone.value = false;
  var headers = {
    'Authorization': 'bearer ${user.accessToken}',
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('$baseURL/api/ListProduct'));
  request.body = json.encode({
    "PageNumber": 0,
    "PageSize": 50
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    latestProducts.value = [];
    var json = jsonDecode(await response.stream.bytesToString());
    var data = json['description'];

    for(int i=0; i<data.length; i++){
      latestProducts.add(ProductModel(
          id:data[i]['id'],
         en_name: data[i]['name_EN'],
        ar_name: data[i]['name_AR'],
        price: double.parse(data[i]['price'].toString()),
        offer: data[i]['offer'],
        imageUrl:data[i]['image'],
        catId: data[i]['catID'],
        categoryNameEN: data[i]['categoryName_EN'],
        categoryNameAR: data[i]['categoryName_AR'],
        modelName: data[i]['modelName'],
        modelId:data[i]['modelID'],
        userId: data[i]['userID'],
        userName: data[i]['userName'],
        providerName: data[i]['userName'],
        providerId: data[i]['userID'],

      ));
    }
    print('latest products count :: ${latestProducts.length}');
  }else{
    print(response.reasonPhrase);
  }
  update();
}

Future getOneProductDetails(String id)async{
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
    var data = json['description'];
    print('full product $data');
    product.value = ProductModel(
      id:data['id'],
      en_name: data['name_EN'],
      ar_name: data['name_AR'],
      price: double.parse(data['price'].toString()),
      offer: data['offer'],
      imageUrl:data['primaryImage'],
      catId: data['catID'],
      categoryNameEN: data['categoryName_EN'],
      categoryNameAR: data['categoryName_AR'],
      modelName: data['modelName'],
      modelId:data['modelID'],
      userId: data['userID'],
      userName: data['userName'],
      general: data['general'],
      special: data['spical'],
      providerName: data['merchentName'],
      providerId: data['merchentID'],
      colorsData: data['image'],

    );
    productDetails =ProductModel(
      id:data['id'],
      en_name: data['name_EN'],
      ar_name: data['name_AR'],
      price: double.parse(data['price'].toString()),
      offer: data['offer'],
      imageUrl:data['primaryImage'],
      catId: data['catID'],
      categoryNameEN: data['categoryName_EN'],
      categoryNameAR: data['categoryName_AR'],
      modelName: data['modelName'],
      modelId:data['modelID'],
      userId: data['userID'],
      userName: data['userName'],
      general: data['general'],
      special: data['spical'],
      providerName: data['merchentName'],
      providerId: data['merchentID'],
      colorsData: data['image'],

    );
    print('colors data ${productDetails.colorsData}');
   await addColorsData();
    createImages(2);
    print(product);
  }
}
createImages(int index){
  imagesWidget.value =[];
    for(int i =0; i< colorsData[index].imagesUrls.length; i++){
      imagesWidget.add(
        Image.network(
            '$baseURL/${colorsData[index].imagesUrls[i]}',
            fit: BoxFit.fill),
      );

  }
  getDetailsDone.value =true;
update();
}
addColorsData(){
  for(int i =0; i<productDetails.colorsData!.length;i++){
    colorsData.add(
        ProductColorsData(imagesUrls:
          productDetails.colorsData![i]['image'],
          color: productDetails.colorsData![i]['property']
        )
    );
  }
  update();
}
}