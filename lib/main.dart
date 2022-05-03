import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geolocator/geolocator.dart' as geo;
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';
import 'package:q_market_n/controllers/cart_controller.dart';
import 'package:q_market_n/controllers/catgories_controller.dart';
import 'package:q_market_n/views/screens/main_screen.dart';
import 'Assistants/globals.dart';
import 'controllers/address_location_controller.dart';
import 'controllers/lang_controller.dart';
import 'controllers/product_controller.dart';
import 'controllers/start_up_controller.dart';
import 'localization/localization.dart';
import 'views/screens/categories/categories_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final addressController =
      Get.putAsync(() async => AddressController(), permanent: true);
  final productController =
      Get.putAsync(() async => ProductsController(), permanent: true);
  final categoriesController =
      Get.putAsync(() async => CategoriesController(), permanent: true);
  final cartController =
      Get.putAsync(() async => CartController(), permanent: true);
  final langController =Get.putAsync(() async => LangController(),permanent: true);
   MFSDK.init( 'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',MFCountry.KUWAIT,MFEnvironment.TEST);

  runApp( GetMaterialApp(
    locale: Locale('en'),
    fallbackLocale: Locale('en'),
    translations: Localization(),
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AddressController addressController = Get.find();
  final startUpController = Get.put(StartUpController());
  late loc.PermissionStatus _permissionGranted;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locatePosition();
    startUpController.fetchUserLoginPreference();
  }

  var geoLocator = geo.Geolocator();
  loc.Location location = loc.Location.instance;

  geo.Position? currentPos;
  void locatePosition() async {
    loc.PermissionStatus permissionStatus = await location.hasPermission();
    _permissionGranted = permissionStatus;
    if (_permissionGranted != loc.PermissionStatus.granted) {
      final loc.PermissionStatus permissionStatusReqResult =
          await location.requestPermission();

      _permissionGranted = permissionStatusReqResult;
    }

    geo.Position position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high,
        forceAndroidLocationManager: true);
    addressController.areaLoc.value =
        LatLng(position.latitude, position.longitude);

    print(position);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(140),
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: FittedBox(
        child: SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator.adaptive(
              backgroundColor: myHexColor,
              strokeWidth: 2,
            )),
      ),
    );
  }
}
