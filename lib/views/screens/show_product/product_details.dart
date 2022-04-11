import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../Assistants/globals.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../models/product_model.dart';
import '../../widgets/horizontal_listOfProducts.dart';
import '../home/search_area_des.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel? product;
  const ProductDetails({Key? key, this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

int indexListImages =0;
class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final ProductsController productController = Get.find();
  final CartController cartController = Get.find();

  List<Color> _colorSize = [
    myHexColor3,
  ];
  List<Color> _colorSizeBorder = [
    myHexColor3,
  ];
  Color? _color = myHexColor3;
  Color? _color2 = Colors.grey[700];

  List<Color> _colorColor = [
    myHexColor3,
  ];
  List<Color> _colorColorBorder = [
    myHexColor3,
  ];
  final Color? _colorColorC = myHexColor3;
  final Color? _color2C = Colors.grey[700];
  bool showOver = false;
  bool showSpec = false;
  List sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  var urlImages=[];
  var currentSize;
  var currentColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  Future<bool> onLikeButtonTapped(bool isLiked) async{
    /// send your request here
    final bool success= await productController.addProductToFav(widget.product!.id!);

    /// if failed, you can do nothing
    return success? !isLiked:isLiked;

    //return !isLiked;
  }
  @override
  Widget build(BuildContext context) {
    double buttonSize = 21;
    final screenSize = Get.size;
    return Obx(
      () => Container(
        color: myHexColor,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              height: screenSize.height,
              width: screenSize.width,
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    children: [

                      InkWell(
                        onTap: () {
                          Get.back();
                          print(productController.latestProducts.length);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0,left: 10),
                          child: SvgPicture.asset('assets/icons/left arrow.svg',
                              alignment: Alignment.center,
                              //color:,
                              height: buttonSize,
                              width: buttonSize,
                              semanticsLabel: 'A red up arrow'),
                        ),
                      ),

                      Expanded(child: SearchAreaDesign()),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Stack(
                    children: [
                      productController.getDetailsDone.value == true
                          ? Column(
                            children: [
                              SizedBox(
                                  height: screenSize.height*0.4,
                                  width: double.infinity,
                                  child:
                                  // InkWell(
                                  //     onTap: (){
                                  //       gallery();
                                  //     },
                                  //     child: Ink.image(image: NetworkImage("$baseURL/${productController.imagesData[0].imagesUrls[0]}",),height: 300,))

                                  Obx(()=> Carousel(
                                    onImageTap: (i){
                                      print(i);
                                      gallery(i);
                                    },
                                      dotSize: 4.0,
                                      dotSpacing: 15.0,
                                      dotVerticalPadding: 00,
                                      indicatorBgPadding: 14,
                                      autoplay: true,
                                      autoplayDuration: 7.seconds,
                                      animationDuration: 900.milliseconds,
                                      dotBgColor: Colors.transparent.withOpacity(0.1),
                                      dotColor: Colors.white,
                                      dotIncreasedColor: Colors.red,
                                      dotPosition: DotPosition.bottomLeft,
                                      images: productController.imagesWidget.value[indexListImages],
                                    ),
                                  ),
                                ),
                            ],
                          )
                          : Center(child: Container(
                        color: Colors.white,
                          height: screenSize.height*0.4,
                          width: double.infinity,
                          child: Image.asset('assets/images/animation/99353-loading-circle.gif',))),
                      productController.getDetailsDone.value == true
                          ? Positioned(
                          top: 8.0,
                          left: 10.0,
                          child: Container(
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.zero,
                            width: screenSize.width * .1 - 5,
                            height: screenSize.width * .1 - 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white.withOpacity(.9)),
                            child: LikeButton(
                              size: buttonSize,
                              onTap: onLikeButtonTapped,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              padding: EdgeInsets.only(
                                  left: screenSize.width * .1 - 37, top: 2),
                              circleColor: const CircleColor(
                                  start: Color(0xff00ddff),
                                  end: Color(0xff0099cc)),
                              bubblesColor: const BubblesColor(
                                dotPrimaryColor: Color(0xff33b5e5),
                                dotSecondaryColor: Color(0xff0099cc),
                              ),
                              likeBuilder: (bool isLiked) {
                                return SvgPicture.asset(
                                    'assets/icons/heart.svg',
                                    alignment: Alignment.center,
                                    color: isLiked ? myHexColor3 : Colors.grey,
                                    height: buttonSize,
                                    width: buttonSize,
                                    semanticsLabel: 'A red up arrow');
                              },
                            ),
                          )):Container(),
                      productController.getDetailsDone.value == true
                          ?Positioned(
                        top: screenSize.height * .1 - 28,
                        left: 10.0,
                        child: Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          width: screenSize.width * .1 - 5,
                          height: screenSize.width * .1 - 5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white.withOpacity(.9)),
                          child: LikeButton(
                            size: buttonSize,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            onTap: (isLiked) async {
                              print('share');
                              return isLiked;
                            },
                            padding: EdgeInsets.only(
                                left: screenSize.width * .1 - 37, top: 2),
                            circleColor: const CircleColor(
                                start: Colors.grey, end: Colors.grey),
                            bubblesColor: const BubblesColor(
                              dotPrimaryColor: Color(0xff33b5e5),
                              dotSecondaryColor: Color(0xff0099cc),
                            ),
                            likeBuilder: (bool isLiked) {
                              return SvgPicture.asset('assets/icons/share3.svg',
                                  alignment: Alignment.center,
                                  color: isLiked ? myHexColor3 : Colors.grey,
                                  height: buttonSize,
                                  width: buttonSize,
                                  semanticsLabel: 'A red up arrow');
                            },
                          ),
                        ),
                      ):Container()
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          '${widget.product!.providerName}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: myHexColor1),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.1 - 76,
                        ),
                        Text(
                          '${widget.product!.en_name}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.1 - 60,
                        ),
                        const Text(
                          'Size',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        _buildSizesOptions(screenSize),
                        const SizedBox(
                          height: 22.0,
                        ),
                        const Text(
                          'Colors',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        _buildColorsOptions(screenSize),
                        const SizedBox(
                          height: 22.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey[500]!,
                              )),
                          width: screenSize.width,
                          height: screenSize.height * 0.1 - 30,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10.0,
                              ),
                              SvgPicture.asset('assets/icons/shipping.svg',
                                  color: Colors.grey[600],
                                  height: 18.00,
                                  width: 18.0,
                                  semanticsLabel: 'A red up arrow'),
                              SizedBox(
                                width: 10.0,
                              ),
                              const Text('Delivery time :'),
                              Spacer(),
                              Text(' Jan 28 - Jan 30'),
                              SizedBox(
                                width: screenSize.width * 0.1 - 12,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(3)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 12),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/svg/9593997931634472866.svg',
                                        // color: Colors.black,
                                        height: 21.00,
                                        width: 21.0,
                                        semanticsLabel: 'A red up arrow'),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    const Text(
                                      'Seller',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      'QR Market',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: myHexColor3),
                                    ),
                                    Spacer(),
                                    Icon(Icons.keyboard_arrow_right)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _color = myHexColor3;
                            _color2 = Colors.grey[700];
                            showOver = true;
                            showSpec = false;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                                duration: 11.seconds,
                                curve: Curves.easeIn,
                                child: Text('Overview',
                                    style: TextStyle(
                                        color: _color,
                                        fontWeight: FontWeight.w500))),
                            const SizedBox(
                              height: 10.0,
                            ),
                            AnimatedContainer(
                              curve: Curves.easeInOut,
                              width: screenSize.width / 2,
                              height: 2.5,
                              color: _color,
                              duration: 900.milliseconds,
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _color2 = myHexColor3;
                            _color = Colors.grey[700];
                            showOver = false;
                            showSpec = true;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                                curve: Curves.easeIn,
                                duration: 14.seconds,
                                child: Text(
                                  'Specifications',
                                  style: TextStyle(
                                      color: _color2,
                                      fontWeight: FontWeight.w500),
                                )),
                            const SizedBox(
                              height: 10.0,
                            ),
                            AnimatedContainer(
                              curve: Curves.easeInOut,
                              width: screenSize.width / 2,
                              height: 2.5,
                              color: _color2,
                              duration: 900.milliseconds,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  showSpec
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 14.0, horizontal: 12),
                              child: Text(
                                'Specifications',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      child: Text(
                                        'Specifications',
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      width: screenSize.width * .5 - 30),
                                  SizedBox(
                                      width: screenSize.width *0.5,
                                      child: Text(
                                        'Specifications Specifications Specifications Specifications Specifications',
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[800],
                                          fontSize: 11,
                                        ),
                                      )),
                                  Spacer()
                                ],
                              ),
                            ),
                            Container(
                              color: myHexColor3.withOpacity(0.4),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        child: Text(
                                          'Color name',
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        width: screenSize.width * .5 - 30),
                                    SizedBox(
                                        width: screenSize.width *0.5,
                                        child: Text(
                                          productController.productDetails.colorsData![0]['color'],
                                          maxLines: 3,
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    Spacer()
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: screenSize.width * .5 - 30,
                                      child: Text(
                                        'Department',
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  Text(
                                    productController.productDetails.categoryNameEN!,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[800],
                                      fontSize: 11,
                                    ),
                                  ),
                                  Spacer()
                                ],
                              ),
                            ),
                            Container(
                              color: myHexColor3.withOpacity(0.4),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: screenSize.width * .5 - 30,
                                        child: Text(
                                          'Offer',
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    Text(
                                      'Relaxed ',
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer()
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: screenSize.width * .5 - 30,
                                      child: Text(
                                        'Material',
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  Text(
                                    'Cotton',
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[800],
                                      fontSize: 11,
                                    ),
                                  ),
                                  Spacer()
                                ],
                              ),
                            ),
                            Container(
                              color: myHexColor3.withOpacity(0.4),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: screenSize.width * .5 - 30,
                                        child: Text(
                                          'Material Composition',
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    Text(
                                      '100% Organic Cotton ',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer()
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: screenSize.width * .5 - 30,
                                      child: Text(
                                        'Model Number',
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  Text(
                                    productController.productDetails.modelName!,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[800],
                                      fontSize: 11,
                                    ),
                                  ),
                                  Spacer()
                                ],
                              ),
                            ),
                            Container(
                              color: myHexColor3.withOpacity(0.4),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    SizedBox(
                                        width: screenSize.width * .5 - 30,
                                        child: Text(
                                          'Season Code',
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    Text(
                                      'SS',
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer()
                                  ],
                                ),
                              ),
                            ),

                          ],
                        )
                      : Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 12.0,
                                    left: 12.0,
                                    top: 22.0,
                                    bottom: 10),
                                child: Text(
                                  'Highlights',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 12),
                                child: Text(
                                  'Highlights..........eee eeedsdsde fefe eeded edfed efdede efef eefde ee 6h6yh rrg tgtt trgf rf  rrrtrf rtrf.',
                                  maxLines: 6,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 12.0, left: 12.0, top: 22.0, bottom: 10),
                    child: Text(
                      'More from ${productController.product.value.brand}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  buildHorizontalListOfProducts(true),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
            bottomSheet: buildAddCartPrice(widget.product!.price!),
          ),
        ),
      ),
    );
  }

  Widget _buildSizesOptions(size) {
    return SizedBox(
      width: size.width,
      height: 38,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                _colorSize.add(Colors.grey[800]!);
                _colorSizeBorder.add(Colors.grey[400]!);

                return InkWell(
                  onTap: () {
                    currentSize = productController.sizes[index]['size'];
                    setState(() {
                      print('sizes');
                      for (var i = 0; i < _colorSize.length; i++) {
                        if (i == index) {
                          _colorSize[i] = myHexColor3;
                          _colorSizeBorder[i] = myHexColor3;
                        } else {
                          _colorSize[i] = Colors.grey[800]!;
                          _colorSizeBorder[i] = Colors.grey[400]!;
                        }
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 24,
                      width: 78,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.2, color: _colorSizeBorder[index])),
                      child: Center(
                        child: Text(
                            productController.sizes[index]['size'],
                          style: TextStyle(
                              color: _colorSize[index],
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: productController.sizes.length,
              semanticIndexOffset: 0,
            ),
          )
        ],
      ),
    );
  }

//build colors options
  Widget _buildColorsOptions(size) {
    return SizedBox(
      width: size.width,
      height: 38,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                _colorColor.add(Colors.grey[800]!);
                _colorColorBorder.add(Colors.grey[400]!);

                return InkWell(
                  onTap: () {
                    currentColor = productController.imagesData[index].color;
                    print(index);
                    indexListImages=index;
                    setState(() {
                      for (var i = 0; i < _colorColor.length; i++) {
                        if (i == index) {
                          _colorColor[i] = myHexColor3;
                          _colorColorBorder[i] = myHexColor3;
                        } else {
                          _colorColor[i] = Colors.grey[800]!;
                          _colorColorBorder[i] = Colors.grey[400]!;
                        }
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 24,
                      width: 78,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.2, color: _colorColorBorder[index])),
                      child: Center(
                        child: Text(
                          productController.imagesData[index].color,
                          style: TextStyle(
                              color: _colorColor[index],
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: productController.imagesData.length,
              semanticIndexOffset: 0,
            ),
          )
        ],
      ),
    );
  }

  Widget buildAddCartPrice(double price) {
    return Card(
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
                child:  InkWell(
                    onTap: (){
                      cartController.addToCart(productController.productData['id'], productController.productData['image'][0]['colorID'], productController.productData['size'][0]['sizeID']);
                    },
                    child:Container(
              height: 54,
              color: myHexColor1,
              child: const Center(
                child: Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )),
          ),
          Container(
            height: 44,
            width: 130,
            color: Colors.white,
            child: Center(
              child: Text(
                '${price.toStringAsFixed(3)}',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
  
  void gallery(int i)=> Navigator.of(context).push(MaterialPageRoute(builder: (_)=>GalleryWidget(index:i,urlImages:productController.imagesData[indexListImages].imagesUrls)));
}

class GalleryWidget extends StatefulWidget {
  final PageController pageController;
  final List<String> urlImages;
  final int index;
   GalleryWidget({Key? key,required this.urlImages, this.index =0}) :pageController =PageController(initialPage: index);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  late int index = widget.index;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: myHexColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: myHexColor,
          appBar: AppBar(
            foregroundColor: Colors.black.withOpacity(1.0),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Container(
            color: myHexColor,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                PhotoViewGallery.builder(
                  backgroundDecoration: BoxDecoration(
                    color: myHexColor
                  ),
                  pageController: widget.pageController,
                  itemCount: widget.urlImages.length,
                  builder: (context,index){
                    final urlImage = widget.urlImages[index];
                    return PhotoViewGalleryPageOptions(imageProvider: NetworkImage("$baseURL/$urlImage",),
                    minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.contained *4,

                    );
                  },
                  onPageChanged: (index)=> setState(() =>this.index =index),
                ),
                Container(
                  padding: EdgeInsets.only(top: 33,bottom: 20,right: 20,left: 20),
                  child:  Text(
                    'image ${index + 1}/${widget.urlImages.length}',
                    style: TextStyle(fontSize: 22,color: myHexColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

