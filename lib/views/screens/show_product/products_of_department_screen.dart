import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Assistants/globals.dart';
import '../../../controllers/catgories_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../widgets/search_area_des.dart';
import '../home/head_home_screen.dart';
import '../home/search_area_des.dart';
import 'product_item.dart';

class ProductsOfDepartmentScreen extends StatefulWidget {
  final String depId;

  const ProductsOfDepartmentScreen({Key? key, required this.depId})
      : super(key: key);

  @override
  State<ProductsOfDepartmentScreen> createState() =>
      _ProductsOfDepartmentScreenState();
}

class _ProductsOfDepartmentScreenState
    extends State<ProductsOfDepartmentScreen> {
  bool showOneList = false;
  final CategoriesController categoriesController = Get.find();
  final ProductsController productController = Get.find();

  List colors =[];
  Color color =Colors.grey;
  List<double> opacityColor = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   if(categoriesController.departments.length > 0){
     productController.getProductsByCat(categoriesController.departments[0]['id']);
   }else{
     Timer(1500.milliseconds,(){
       productController.getProductsByCat(categoriesController.departments[0]['id']);
     });
   }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: myHexColor5,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                            productController.catProducts.value = [];
                            categoriesController.departments.value = [];

                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 12, left: 12, bottom: 12),
                            child: SvgPicture.asset(
                                'assets/icons/left arrow.svg',
                                color: Colors.grey[800],
                                height: 27.00,
                                width: 27.0,
                                semanticsLabel: 'A red up arrow'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (showOneList) {
                                showOneList = false;
                              } else {
                                showOneList = true;
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 12, left: 12, bottom: 12),
                            child: showOneList
                                ? SvgPicture.asset('assets/icons/menu.svg',
                                    color: Colors.grey[800],
                                    height: 26.00,
                                    width: 26.0,
                                    semanticsLabel: 'A red up arrow')
                                : SvgPicture.asset(
                                    'assets/icons/menu_category.svg',
                                    color: Colors.grey[800],
                                    height: 29.00,
                                    width: 29.0,
                                    semanticsLabel: 'A red up arrow'),
                          ),
                        ),
                      ],
                    ),
                    const SearchAreaDesign(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: screenSize.width,
                      height: 2,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                  width: screenSize.width,
                  height: screenSize.height * 0.1 - 50,
                  child: _buildDepartmentsOptions()),
              const SizedBox(
                height: 1.0,
              ),

              SizedBox(
                  width: screenSize.width,
                  height: screenSize.height * 0.7,
                  child: _buildDepartmentProductsList())
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDepartmentsOptions() {
    return CustomScrollView(
      scrollDirection: Axis.horizontal,
      slivers: [
        Obx(
          () => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                for(int i =0; i<categoriesController.departments.length;i++){
                  if(i==0){
                    colors.add(myHexColor);
                    opacityColor.add(1.0);

                  }else{
                    opacityColor.add(0.7);
                    colors.add(Colors.black);
                  }}
                return InkWell(
                  onTap: (){
                    setState(() {

                      for(int i =0; i<colors.length;i++){
                        if(index==i){
                          colors[index]= myHexColor;
                          opacityColor[index]= 1.0;
                        }else{
                          opacityColor[i]= 0.7;
                          colors[i]=Colors.black;
                        }
                      }
                    });
                    productController.getProductsByCat(categoriesController.departments[index]['id']);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.4, color: colors[index].withOpacity(opacityColor[index]),
                        ),
                        borderRadius: BorderRadius.circular(22),

                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.1 - 84, horizontal: 18),
                      child: Center(
                        child: Text(
                          categoriesController.departments[index]['name_EN'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400,color: colors[index].withOpacity(opacityColor[index]),),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: categoriesController.departments.length,
              semanticIndexOffset: 2,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDepartmentProductsList() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        color: Colors.grey[50],
        child: Obx(()=>GridView.builder(
            itemCount: productController.catProducts.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            semanticChildCount: 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 6.2,
                childAspectRatio: 0.6),
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.zero,
                  child: ProductItemCard(
                    product:productController.catProducts[index] ,
                    fromDetails: false,
                  ),);
            },
          ),
        ),
      ),
    );
  }
}
