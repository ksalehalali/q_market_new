import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:q_market_n/views/screens/show_product/product_details.dart';

import '../../../Assistants/globals.dart';
import '../../../controllers/product_controller.dart';
import '../../../models/product_model.dart';

List likesList = [''];

bool like = false;

class ProductItemCard extends StatelessWidget {

  final ProductModel product;
  final bool fromDetails;
   ProductItemCard({
    Key? key,
   required this.product,required this.fromDetails
  }) : super(key: key);

  final ProductsController productController = Get.find();


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double buttonSize =22;
    final screenSize = Get.size;
    return InkWell(
      onTap: (){
         productController.getOneProductDetails(product.id!);
        print( product.providerName);
       if(fromDetails){
        Get.to(()=>ProductDetails(product: product,));
       }else{
         productController.getOneProductDetails(product.id!);

         Get.to(()=>ProductDetails(product: product,));
       }
      },
      child: Container(
        height: 250,
        width: size.width *0.4 +10,
        decoration: BoxDecoration(
            border: Border.all(width: 0.3,color: Colors.grey.withOpacity(0.4))
        ),
        margin: EdgeInsets.only(
          left:5,
          right: 5,
        ),
        padding: EdgeInsets.only(top: 6,right: 6,left: 6,bottom: 0),
        child: Stack(
          children: <Widget>[
            InkWell(
                onTap: () {
                  productController.getOneProductDetails(product.id!);
                  print( product.providerName);

                  if(fromDetails){
                    Get.to(()=>ProductDetails(product: product,));
                  }else{
                    Get.to(()=>ProductDetails(product: product,));
                  }                },
                child: Image.network(
                  '$baseURL/${product.imageUrl!}',
                  fit: BoxFit.fill,
                  height: 180,
                  width: size.width / 2,
                )),
            Positioned(
                top: 8.0,
                left: 10.0,
                child: Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  width: screenSize.width*.1-5,
                  height: screenSize.width*.1-5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(.9)
                  ),
                  child: LikeButton(
                    size: buttonSize,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    padding: EdgeInsets.only(left:screenSize.width*.1-37,top: 2),
                    circleColor:
                    CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {

                      return SvgPicture.asset(
                          'assets/icons/heart.svg',
                          alignment: Alignment.center,
                          color: isLiked ? myHexColor3 : Colors.grey,
                          height:buttonSize,
                          width: buttonSize,
                          semanticsLabel: 'A red up arrow'
                      );
                    },
                    //likeCount: 665,
                    // countBuilder: (int? count, bool isLiked, String text) {
                    //   var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                    //   Widget result;
                    //   if (count == 0) {
                    //     result = Text(
                    //       "love",
                    //       style: TextStyle(color: color),
                    //     );
                    //   } else
                    //     result = Text(
                    //       text,
                    //       style: TextStyle(color: color),
                    //     );
                    //   return result;
                    // },
                  ),
                )),
            Positioned(
              top:size.height *0.3 -56,
              child: InkWell(
                onTap: (){
                  productController.getOneProductDetails(product.id!);
                  print( product.providerName);

                  if(fromDetails){

                    Get.to(()=>ProductDetails(product: product,));
                  }else{
                    Get.to(()=>ProductDetails(product: product,));
                  }                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 8.0),
                              child: SizedBox(
                                width: size.width * 0.3,
                                child: Text("${product.en_name}".toUpperCase(),textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:TextStyle(fontSize: 13,color: Colors.grey)),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.3,
                              child: Text(
                                "${(product.price)!-(product.offer!*1.0)} QR ".toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'Montserrat-Arabic Regular',
                                    color: Colors.black,
                                    fontSize: 13,fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 6.0),
                              child: Text(
                                '${product.categoryNameEN}'.toUpperCase(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: 'Montserrat-Arabic Regular',
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 12,fontWeight: FontWeight.w500),
                              ),
                            ),

                            SizedBox(
                              width: size.width * 0.4-10,
                              child: Row(
                                children: [
                                  Text(
                                    "${product.price!.toStringAsFixed(3)} QR".toUpperCase(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                        fontFamily: 'Montserrat-Arabic Regular',
                                        color: Colors.grey,
                                        fontSize: 11),
                                  ),
                                  SizedBox(width: 7.0,),
                                  Text(
                                    "Discount ${product.offer}%",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,

                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat-Arabic Regular',
                                        color: myHexColor3,
                                        fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}