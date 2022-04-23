import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Assistants/globals.dart';
import '../../controllers/address_location_controller.dart';

Future<void> showD(context) async {
  final String mAPIKey =
      "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";

  return await showDialog(
      context: context,
      builder: (context) {
        int? value = 1;
        double? kNetPos = 600;

        return StatefulBuilder(builder: (context, setState) {
          Timer(Duration(milliseconds: 2), () {
            setState(() {
              kNetPos = 290.0;
            });
          });
          return Container(
            width: screenSize.width,
            child: AlertDialog(
                backgroundColor: Colors.white,
                insetPadding: EdgeInsets.only(top: 0.0),
                contentPadding: EdgeInsets.all(5),
                content: buildAddressesOptions()),
          );
        });
      });
}

Widget buildAddressesOptions() {
  final AddressController addressController = Get.find();

  List colors = [];

  Color color = Colors.grey;
  final storage = GetStorage();

  List<double> opacityColor = [];
  return CustomScrollView(
    scrollDirection: Axis.vertical,
    slivers: [
      Obx(
        () => SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              for (int i = 0; i < addressController.myAddressData.length; i++) {
                if (i == 0) {
                  colors.add(myHexColor);
                  opacityColor.add(1.0);
                } else {
                  opacityColor.add(0.7);
                  colors.add(Colors.black);
                }
              }
              return InkWell(
                onTap: () {
                  storage.write('idAddressSelected',
                      addressController.myAddressData[index]['id']);
                  storage.write('address',
                      addressController.myAddressData[index]['address']);
                  storage.write('indexAddressSelected', index);
                  addressController.addressSelected.value =
                      addressController.myAddressData[index]['address'];
                  //  setState(() {
                  for (int i = 0; i < colors.length; i++) {
                    if (index == i) {
                      colors[index] = myHexColor;
                      opacityColor[index] = 1.0;
                    } else {
                      opacityColor[i] = 0.7;
                      colors[i] = Colors.black;
                    }
                  }
                  //});
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 0.7,
                        color: colors[index].withOpacity(opacityColor[index]),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 2),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      size: 22,
                                      color: Colors.grey[700],
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Edit',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  addressController.deleteAddress(
                                      addressController.myAddressData[index]
                                          ['id']);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2, right: 2.0),
                                  child: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.3,
                                child: Text('Name',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[700])),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.5,
                                child: Text(
                                    addressController.myAddressData[index]
                                        ['nameAddress'],
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[700])),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.3,
                                child: Text('Phone',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[700])),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.5,
                                child: Text(
                                    addressController.myAddressData[index]
                                        ['phone'],
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[700])),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.3,
                                child: Text('Address',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[700])),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.5,
                                child: Text(
                                    addressController.myAddressData[index]
                                        ['address'],
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[700])),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: addressController.myAddressData.length,
            semanticIndexOffset: 2,
          ),
        ),
      )
    ],
  );
}
