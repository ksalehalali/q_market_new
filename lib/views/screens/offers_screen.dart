import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/data_for_ui.dart';
import '../../controllers/product_controller.dart';
import '../widgets/departments_shpe.dart';
import 'home/search_area_des.dart';
import 'show_product/product_item.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final ProductsController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenSize = Get.size;
    return Container(
      child: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 6.0,
            ),
            SearchAreaDesign(),
            SizedBox(
              height: 4.0,
            ),
            SizedBox(
                height: screenSize.height * 0.2 + 55,
                width: 400,
                child: _buildDepartmentsList()),
            SizedBox(
              height: screenSize.height * 0.1 - 64,
            ),
          ],
        )),
      )),
    );
  }

  Widget _buildDepartmentsList() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        color: Colors.grey[50],
        child: GridView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.zero, //a
          semanticChildCount: 0,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 3,
              crossAxisSpacing: 5.2,
              childAspectRatio: 2.0),
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.zero,
                child: DepartmentShapeTile(
                  assetPath: categories[index]['imagePath'],
                  title: categories[index]['catName'],
                  depId: categories[index]['id']!,
                ));
          },
        ),
      ),
    );
  }

  Widget _buildHorizontalListOfRecommendedProducts() {
    final screenSize = Get.size;
    return SizedBox(
        height: screenSize.height * 0.4 - 28,
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          slivers: [
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ProductItemCard(
                      product: productController.recommendedProducts[index],
                      fromDetails: false,
                      from: "home_ho_rec",
                    );
                  },
                  childCount: productController.recommendedProducts.length,
                  semanticIndexOffset: 2,
                ),
              ),
            )
          ],
        ));
  }
}
