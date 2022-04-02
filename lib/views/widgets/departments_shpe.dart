import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_market_n/controllers/catgories_controller.dart';

import '../../Assistants/globals.dart';
import '../screens/show_product/products_of_department_screen.dart';

class DepartmentShapeTile extends StatelessWidget {
  final Color? color;
  final String? title;
  final String? assetPath;
  final String depId;

   DepartmentShapeTile({Key? key, this.color, this.title, this.assetPath,required this.depId})
      : super(key: key);
  final CategoriesController categoriesController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenSize =Get.size;
    return InkWell(
      onTap: (){
        categoriesController.getListCategoryByCategory(depId);
        Get.to(()=> ProductsOfDepartmentScreen(depId: depId,));
      },
      child: Column(
        children: <Widget>[
          Container(
            height: 63,
            width: 63,
            padding:  EdgeInsets.all(0.1),
            decoration:  BoxDecoration(
              color: myHexColor,
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              child: Image.asset(
                this.assetPath!,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            width: screenSize.width *0.2+10,
              child: Text(this.title!,overflow: TextOverflow.fade,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
        ],
      ),
    );
  }
}