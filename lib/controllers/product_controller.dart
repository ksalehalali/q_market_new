import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../Assistants/globals.dart';
import '../models/product_model.dart';

import '../Data/current_data.dart';
import '../models/product_colors_data.dart';

class ProductsController extends GetxController {
var latestProducts = <ProductModel>[].obs;
var catProducts = <ProductModel>[].obs;

var product = ProductModel().obs;
var productForCart = ProductModel();

ProductModel productDetails = ProductModel();
var colorsData=[].obs;
var imagesData=[].obs;
var getDetailsDone= false.obs;
var imagesWidget=[[],[],[],[],[]].obs;
var imagesWidget1=[].obs;
var imagesWidget2=[].obs;
var imagesWidget3=[].obs;
var productData ={};
var sizes =[];
var colors =[];


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
        brand: data[i]['brandName'],

      ));
    }
    print('latest products count :: ${latestProducts.length}');
  }else{
    print(response.reasonPhrase);
  }
  update();
}

//get products by cat
  Future getProductsByCat(String catId)async{
    getDetailsDone.value = false;
    var headers = {
      'Authorization': 'bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$baseURL/api/ListProductByCategory'));
    request.body = json.encode({
      "id":catId,
      "PageNumber": 0,
      "PageSize": 50
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      catProducts.value = [];
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];

      for(int i=0; i<data.length; i++){
        catProducts.add(ProductModel(
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
          brand: data[i]['brandName'],

        ));
      }
      print(' products count :: ${catProducts.length}');
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
    imagesData.value=[];
    imagesWidget.value= [];
    sizes = [];
    var json = jsonDecode(await response.stream.bytesToString());
     productData = json['description'];
    print('full product $productData');
    product.value = ProductModel(
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
    productDetails =ProductModel(
      id:productData['id'],
      en_name: productData['name_EN'],
      ar_name: productData['name_AR'],
      price: double.parse(productData['price'].toString()),
      offer: productData['offer'],
      imageUrl:productData['primaryImage'],
      catId: productData['catID'],
      categoryNameEN: productData['categoryName'],
      //categoryNameAR: productData['categoryName_AR'],
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
    sizes = productData['size'];
    colors = productData['size'][0]['color'];
    print('colors productData ${productDetails.colorsData}');
   await addImagesData();
    createImages(2);
    print(product);
  }
}



createImages(int indexX){
  imagesWidget.value =[[],[],[],[]];
  imagesWidget1.value =[];
  imagesWidget2.value =[];
  imagesWidget3.value =[];

  for(int index =0; index< imagesData.length; index++){
      for(int i =0; i< imagesData[index].imagesUrls!.length; i++){
        if(imagesData[index].imagesUrls![i] !=null){
          print('the index is $i');
          imagesWidget[index].add(
              Image.network('$baseURL/${imagesData[index].imagesUrls![i]}',fit: BoxFit.fill,)
          );

        }
     }

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

addImagesData(){
  for(int i =0; i<productDetails.colorsData!.length;i++){
    List<String> urls =[];
    if(productDetails.colorsData![i]['image1']!=null)urls.add(productDetails.colorsData![i]['image1'],);
    if(productDetails.colorsData![i]['image2']!=null)urls.add(productDetails.colorsData![i]['image2'],);
    if(productDetails.colorsData![i]['image3']!=null)urls.add(productDetails.colorsData![i]['image3'],);
    if(productDetails.colorsData![i]['image4']!=null)urls.add(productDetails.colorsData![i]['image4'],);

    imagesData.add(
        ProductImagesData(
            imagesUrls: urls,
            color: productDetails.colorsData![i]['color'],
            colorId: productDetails.colorsData![i]['colorID']

        )
    );

    print("$i ${productDetails.colorsData![i]['image1']}");
    print("$i ${productDetails.colorsData![i]['image2']}");
    print("$i ${productDetails.colorsData![i]['image3']}");
    print("$i ${productDetails.colorsData![i]['image4']}");
    //print(imagesData[i].imagesUrls);
  }
  update();
}

Future<bool> addProductToFav(String prodId) async {
  var headers = {
    'Authorization': 'Bearer ${user.accessToken}',
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('https://dashcommerce.click68.com/api/AddFavourite'));
  request.body = json.encode({
    "ProdID": prodId
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    return true;
  }
  else {
  print(response.reasonPhrase);
  return false;
  }

}

Future getMyFav()async{
  var headers = {
    'Authorization': 'Bearer ${user.accessToken}',
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('https://dashcommerce.click68.com/api/ListFavourite'));
  request.body = json.encode({
    "PageNumber": "0",
    "SizeNumber": "1"
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

Future deleteProdFromFav()async{
  var headers = {
    'Authorization': 'Bearer ${user.accessToken}',
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('https://dashcommerce.click68.com/api/DeleteFavourite'));
  request.body = json.encode({
    "id": "93b38d25-0bb1-4eb7-acb9-08da1a1a6526"
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
resetAll(){
  productDetails =ProductModel();
  sizes = [];
  imagesData.value = [];
  product.value = ProductModel();
  imagesWidget.value =[];
}
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLatestProducts();
  }
}