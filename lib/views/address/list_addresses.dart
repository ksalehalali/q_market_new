import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/address_location_controller.dart';

class ListAddresses extends StatelessWidget {
   ListAddresses({Key? key}) : super(key: key);
  final AddressController addressController = Get.find();
   var addresses =[];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Obx(()=>Column(
              children: [
                ...addresses
              ],
            ),
          ),
        ),
      ),

    );
  }

  void buildList(){
    for(int i=0; i<addressController.myAddressData.length; i++){
      addresses.add(
        ListTile(title: Text(addressController.myAddressData[i]['address']),)
      );

    }

  }
}
