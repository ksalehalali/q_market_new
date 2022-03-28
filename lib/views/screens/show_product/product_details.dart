import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../../../Assistants/globals.dart';
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

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  ColorTween _colorTween = ColorTween(begin: Colors.blue, end: Colors.red);
  late AnimationController _animationController;
  final ProductsController productController = Get.find();
  List<Color> _colorSize = [
    myHexColor3,
  ];
  List<Color> _colorSizeBorder = [
    myHexColor3,
  ];
  Color? _color = myHexColor3;
  Color? _color2 = Colors.grey[700];
  bool showOver = false;
  bool showSpec = false;
  List sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  var currentSize;
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

  @override
  Widget build(BuildContext context) {
    double buttonSize = 22;
    final screenSize = Get.size;
    return Obx(
      () => Container(
        color: myHexColor,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Scaffold(
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
                      SizedBox(
                        width: 12.0,
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                          print(productController.latestProducts.length);
                        },
                        child: SvgPicture.asset('assets/icons/left arrow.svg',
                            alignment: Alignment.center,
                            //color:,
                            height: buttonSize,
                            width: buttonSize,
                            semanticsLabel: 'A red up arrow'),
                      ),
                      SizedBox(
                        width: 2.0,
                      ),
                      Expanded(child: SearchAreaDesign()),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Stack(
                    children: [
                      productController.getDetailsDone.value == true
                          ? Column(
                            children: [
                              SizedBox(
                                  height: 360.0,
                                  width: double.infinity,
                                  child: Carousel(
                                    dotSize: 4.0,
                                    dotSpacing: 15.0,
                                    autoplay: true,
                                    autoplayDuration: 4.seconds,
                                    animationDuration: 500.milliseconds,
                                    dotBgColor: Colors.transparent.withOpacity(0.1),
                                    dotColor: Colors.white,
                                    dotIncreasedColor: Colors.red,
                                    dotPosition: DotPosition.bottomLeft,
                                    images: productController.imagesWidget,
                                  ),
                                ),
                            ],
                          )
                          : Center(child: CircularProgressIndicator.adaptive()),
                      Positioned(
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              padding: EdgeInsets.only(
                                  left: screenSize.width * .1 - 37, top: 2),
                              circleColor: CircleColor(
                                  start: Color(0xff00ddff),
                                  end: Color(0xff0099cc)),
                              bubblesColor: BubblesColor(
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
                          )),
                      Positioned(
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
                            bubblesColor: BubblesColor(
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
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
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
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.1 - 60,
                        ),
                        Text(
                          'Size',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        _buildSizesOptions(screenSize),
                        SizedBox(
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
                              SizedBox(
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
                              Text('Delivery time :'),
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
                                    SizedBox(
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
                            SizedBox(
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
                            SizedBox(
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
                                      width: 210,
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
                                        width: 210,
                                        child: Text(
                                          'Red ',
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
                                    'Specifications',
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
                                          'Fit',
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
                                        'Department',
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  Text(
                                    'Specifications',
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
                                          'Color name',
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    Text(
                                      'Red ',
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
                                    'M33333',
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
                      'More from ${widget.product!.brand}',
                      style: TextStyle(
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
                    currentSize = sizes[index];
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
                          sizes[index],
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
              childCount: sizes.length,
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
              child: Container(
            height: 54,
            color: myHexColor1,
            child: Center(
              child: Text(
                'Add to Cart',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )),
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
}
