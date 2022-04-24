import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:q_market_n/models/product_model.dart';

import '../../Assistants/request-assistant.dart';
import '../../controllers/address_location_controller.dart';
import '../../models/address.dart';
import '../address/address_on_map.dart';
import '../address/config-maps.dart';
import '../widgets/divider.dart';
import '../widgets/progressDialog.dart';



class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({Key? key}) : super(key: key);

  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  TextEditingController dropAddressController = TextEditingController();
  final AddressController addressController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 70,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: dropAddressController,

              onTap: () {

              },
              onChanged: (val) {
                addressController.findProduct(val);

              },
              onFieldSubmitted: (val) {

              },
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: 'What are you looking for?',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.grey[400],
                ),
                filled: true,
                fillColor: Colors.white,
                labelText: "Enter Product Name",
                labelStyle: TextStyle(color: Colors.grey[400]),
              ),
            ),
          ),

          //
          Obx(() {
            return Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.all(0.0),
                    itemBuilder: (context, index) => PredictionTile(
                      productPredictions:
                      addressController.productPredictionList[index],
                    ),
                    itemCount: addressController.productPredictionList.length,
                    separatorBuilder: (BuildContext context, index) =>
                        DividerWidget(),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                  )),
            );
          })
        ],
      ),
    );
  }
}

class PredictionTile extends StatelessWidget {
  final ProductModel? productPredictions;
  final AddressController addressController = Get.find();

  PredictionTile({Key? key, this.productPredictions}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {

        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => const AddressOnMap()),
        //         (route) => false);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              width: 10.0,
            ),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(
                  width: 14.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productPredictions!.ar_name!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        productPredictions!.price.toString(),
                        overflow: TextOverflow.ellipsis,
                        style:
                        TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 14.0,
            ),
          ],
        ),
      ),
    );
  }

}