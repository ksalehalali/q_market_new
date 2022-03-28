import 'dart:math';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Assistants/request-assistant.dart';

import '../controllers/address_location_controller.dart';

class AssistantMethods {
  final box = GetStorage();
  final AddressController addressController = Get.find();
  Future<String> searchCoordinateAddress(LatLng latLng, context, bool homeCall) async {
    String placeAddress = "";

    var res = await RequestAssistant.getRequest('https://api.mapbox.com/geocoding/v5/mapbox.places/${latLng.longitude},${latLng.latitude}.json?access_token=pk.eyJ1Ijoia2hhbGVkOTg4MjQiLCJhIjoiY2t6Mmg5NjlmMW5rZzJubXY4NTN4enp5YSJ9.37lqCbPUZEusWKQtoc_FIQ');
    if (res != "failed") {
     print('address :: ${res['features'][0]['place_name']}');
      placeAddress = res['features'][0]['place_name']  ;
     box.write('address', res['features'][0]['place_name']);
     addressController.updatePinAddress(res['features'][0]['place_name']);
    } else {
      print(res);
      print("get address failed");
    }

    return placeAddress;
  }

  //
   Future obtainDirectionDetails(
     ) async {
    String directionURL =
        "https://maps.googleapis.com/maps/api/directions/json?destination=29.37477,47.994738;&origin=29.37477,47.994738;29.374678,47.99484;29.374527,47.995005&key=AIzaSyBSn3hFO_1ndRGrxuCZcnQ-LzhWet2Nq-s";

    var res = await RequestAssistant.getRequest(directionURL);

    if (res == "failed") {
      return null;
    }
    print("res :: $res");

  }



  static void getCurrentOnLineUserInfo()async{



  }

  static double createRandomNumber (int num){
    var random = Random();
    int redNumber = random.nextInt(num);

    return redNumber.toDouble();
  }
}
