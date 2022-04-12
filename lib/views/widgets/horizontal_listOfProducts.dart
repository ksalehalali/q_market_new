import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
import '../screens/show_product/product_item.dart';

Widget buildHorizontalListOfProducts(bool fromDetails) {
  final ProductsController productController = Get.find();

  final screenSize = Get.size;
  return SizedBox(
    height: screenSize.height * 0.4 - 28,
    child: FutureBuilder(
        builder: (context, data) => data.connectionState ==
                ConnectionState.waiting
            ? const SizedBox(
                width: 110,
                height: 110,
                child: FittedBox(
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 0.9,
                  ),
                ),
              )
            : CustomScrollView(
                scrollDirection: Axis.horizontal,
                slivers: [
                  Obx(
                    () => SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ProductItemCard(
                            product: productController.latestProducts[index],
                            fromDetails: fromDetails,
                          );
                        },
                        childCount: productController.latestProducts.length,
                        semanticIndexOffset: 2,
                      ),
                    ),
                  )
                ],
              )),
  );
}
