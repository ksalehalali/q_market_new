import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Assistants/request-assistant.dart';
import '../models/placePredictions.dart';
import '../views/address/config-maps.dart';

class AddressController extends GetxController{
var myCurrentLoc = LatLng(0.0, 0.0).obs;
var areaLoc = LatLng(0.0, 0.0).obs;
var addressWidgetSize=20.0.obs;
var addressWidgetIconSize=17.0.obs;


var pinAddress =''.obs;
List placePredictionList = [].obs;

updatePinAddress(String address){
  pinAddress.value = address;
  update();
}


updateCurrentLoc(LatLng latLng){
  myCurrentLoc.value = latLng;
  print(myCurrentLoc.value.latitude);
  update();
}

showHideAddress(bool show){
 if(show){
   addressWidgetSize.value =20;
   addressWidgetIconSize.value = 17.0;
 }else{
   addressWidgetIconSize.value = 0.0;
   addressWidgetSize.value=0.0;
 }
 update();
}

void findPlace(String placeName) async {
  if (placeName.length > 1) {

    placePredictionList.clear();
    String autoCompleteUrl =
        "https://api.mapbox.com/geocoding/v5/mapbox.places/$placeName.json?worldview=us&country=kw&access_token=$mapbox_token";

    var res = await RequestAssistant.getRequest(autoCompleteUrl);


    if (res == "failed") {
      print('failed');
      return;
    }
    if (res["features"] != null) {
      print(res['status']);
      var predictions = res["features"];

      var placesList = (predictions as List)
          .map((e) => PlacePredictions.fromJson(e))
          .toList();

      //placePredictionList = placesList;
      placesList.forEach((element) {
        placePredictionList.add(PlaceShort(
            placeId: element.id,
            mainText: element.text,
            secondText: element.place_name,
            lat: element.lat,
            lng: element.lng
        ));
      });
      print(placePredictionList.first.mainText);
      update();
    }
  }
}
}

class PlaceShort {
  String? placeId;
  String? mainText;
  String? secondText;
  double? lat;
  double? lng;

  PlaceShort({this.mainText, this.placeId, this.secondText,this.lat,this.lng});
}