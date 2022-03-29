import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:q_market_n/views/screens/main_screen.dart';
import 'Assistants/assistantMethods.dart';
import 'controllers/address_location_controller.dart';
import 'controllers/product_controller.dart';
import 'controllers/start_up_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final addressController =Get.putAsync(() async => AddressController(),permanent: true);
  final productController =Get.putAsync(() async => ProductsController(),permanent: true);

  runApp(
      const GetMaterialApp(
        home: MyApp(),
        debugShowCheckedModeBanner: false,
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AddressController addressController = Get.find();
  final startUpController = Get.put(StartUpController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locatePosition();
   //startUpController.fetchUserLoginPreference();
  }


var geoLocator = geo.Geolocator();
geo.Position? currentPos;
  void locatePosition()async{
geo.Position position = await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
addressController.areaLoc.value = LatLng(position.latitude, position.longitude);

print(position);

  }

  @override
  Widget build(BuildContext context) {
    return MainScreen();
      // Container(
      //   padding: EdgeInsets.all(140),
      //   margin: EdgeInsets.zero,
      //   color: Colors.white,
      //   child: FittedBox(
      //     child: SizedBox(
      //         height: 22,
      //         width: 22,
      //         child: CircularProgressIndicator.adaptive(
      //           backgroundColor: myHexColor,
      //           strokeWidth: 2,
      //         )),
      //   ),
      // );
  }
}
