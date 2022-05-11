import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:q_market_n/views/address/add_address_screen.dart';
import 'package:q_market_n/views/screens/home/search_area_des.dart';
import '../../../Assistants/globals.dart';
import '../../../Data/data_for_ui.dart';
import '../../../controllers/address_location_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../address/address_on_map.dart';
import '../../address/list_addresses.dart';
import '../../address/search_address_screen.dart';
import '../../widgets/departments_shpe.dart';
import '../../widgets/flash_messages_screen.dart';
import '../../widgets/horizontal_listOfProducts.dart';
import '../show_product/product_details.dart';
import '../show_product/product_item.dart';
import '../../address/address_area.dart';
import 'head_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductsController productController = Get.find();
  final AddressController addressController = Get.find();

  ScrollController? scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    scrollController!.addListener(listenBottom);
  }

  void listenBottom() {
    if (kDebugMode) {}
    //final direction = controller.position.userScrollDirection;
    if (scrollController!.position.pixels >= 200) {
      addressController.showHideAddress(false);
    } else {
      addressController.showHideAddress(true);
    }
  }

  static const defaultPadding = 20.0;
  static const cartBarHeight = 100.0;
  static const headerHeight = 85.0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = Get.size;

    return Container(
        color: myHexColor5,
        child: SafeArea(
            child: Scaffold(
                body: Stack(children: [
          Positioned(
              top: 10,
              child: InkWell(
                  onTap: () {

                  },
                  child: headHomeScreen(MediaQuery.of(context)))),
          Positioned(
              top: 50, width: screenSize.width, child: SearchAreaDesign()),
          Positioned(
            top: 100,
            child: Obx(() => AnimatedContainer(
                  duration: 400.milliseconds,
                  height: addressController.addressWidgetSize.value,
                  child: InkWell(
                    onTap: () {
                      addressController.getMyAddresses();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListAddresses(
                                    fromCart: false,
                                    fromAccount: false,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 6.0),
                      child: addressHomeScreen(MediaQuery.of(context)),
                    ),
                  ),
                )),
          ),
          Positioned(
            top: 122,
            child: Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              height: screenSize.height > 800
                  ? screenSize.height - screenSize.height * 0.2 - 96
                  : screenSize.height - screenSize.height * 0.2 - 50,
              width: screenSize.width,
              child: ListView(
                controller: scrollController,
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 160.0,
                    width: double.infinity,
                    child: Carousel(
                      dotSize: 6.0,
                      dotSpacing: 15.0,
                      autoplayDuration: 8.seconds,
                      animationDuration: 500.milliseconds,
                      dotBgColor: Colors.transparent.withOpacity(0.1),
                      dotColor: Colors.white,
                      dotIncreasedColor: Colors.red,
                      dotPosition: DotPosition.bottomLeft,
                      images: [
                        Image.asset('assets/images/productsample.jpg',
                            fit: BoxFit.fill),
                        Image.asset(
                            'assets/images/Qatar-Online-Marketing-Profile.jpg',
                            fit: BoxFit.fill),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 22.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Shop by category',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  SizedBox(
                      height: screenSize.height * 0.2 + 55,
                      width: 400,
                      child: _buildDepartmentsList()),
                  SizedBox(
                    height: screenSize.height * 0.1 - 64,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 0.0,
                          left: 12,
                        ),
                        child: Text(
                          'Latest Products',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, left: 12, right: 5.0),
                        child: Text(
                          'View all',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.grey[700]),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Colors.grey[700],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  buildHorizontalListOfProducts(false),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 0.0, left: 12),
                        child: Text(
                          'Recommended for you',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, left: 12, right: 5.0),
                        child: Text(
                          'View all',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.grey[700]),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Colors.grey[700],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  _buildHorizontalListOfRecommendedProducts(),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 0.0, left: 12),
                        child: Text(
                          'Offers',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, left: 12, right: 5.0),
                        child: Text(
                          'View all',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.grey[700]),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Colors.grey[700],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  _buildHorizontalListOfOffersProducts(),
                  const SizedBox(
                    height: 22,
                  ),
                  _buildOfferArea()
                ],
              ),
            ),
          ),
        ]))));
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
          padding: EdgeInsets.zero,
          semanticChildCount: 0,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 3,
              crossAxisSpacing: 5.0,
              childAspectRatio: 1.0),
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
                      press: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 200),
                            reverseTransitionDuration:
                                const Duration(milliseconds: 200),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    FadeTransition(
                              opacity: animation,
                              child: ProductDetails(
                                product: productController
                                    .recommendedProducts[index],
                              ),
                            ),
                          ),
                        );
                      },
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

  Widget _buildHorizontalListOfOffersProducts() {
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
                      product: productController.offersProducts[index],
                      fromDetails: false,
                      from: "home_hor_offers",
                      press: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 200),
                            reverseTransitionDuration:
                                const Duration(milliseconds: 200),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    FadeTransition(
                              opacity: animation,
                              child: ProductDetails(
                                product: productController
                                    .recommendedProducts[index],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  childCount: productController.offersProducts.length,
                  semanticIndexOffset: 2,
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildOfferArea() {
    final screenSize = Get.size;
    return InkWell(
      onTap: () {
        if (kDebugMode) {
          print('tap');
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 22.0),
        child: Stack(
          children: [
            FittedBox(
              child: SizedBox(
                height: screenSize.height * 0.2,
                width: screenSize.width,
                child: Container(
                    decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    const BoxShadow(color: Colors.black),
                    BoxShadow(color: myHexColor1),
                  ],
                  image: const DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage(
                      'assets/images/aniket-narula-XjNI-C5G6mI-unsplash.jpg',
                    ),
                  ),
                )),
              ),
            ),
            Positioned(
              top: 0.0,
              child: Container(
                color: Colors.black.withOpacity(0.4),
                height: 200,
                width: screenSize.width,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                const Text(
                  'Offers and Promotions',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenSize.height * 0.1 - 70,
                ),
                Text(
                  'On all men\'s suits from the most famous world',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[50],
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
