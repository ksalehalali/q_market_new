
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CartController extends GetxController {
  var isCartEmpty = true.obs;

  var cartItems = <Widget>[].obs;

  Column buildCartItem() {
    // this list will be filled form the API
    cartItems.add(
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Channel", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 16),),
                    SizedBox(height: 8,),
                    Text("Perfume description text", style: TextStyle(fontWeight: FontWeight.w500),),
                    SizedBox(height: 8,),
                    Text(
                      "190 \$",
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 100,
                    child: Image.network(
                      "https://dashcommerce.click68.com/Files/Image/Primary/82841370-56a9-4c1c-84f6-043257bce3af/ECommerce637837246457023512.webp",
                    ),
                  ),
                ),

              ],
            ),
            const Text(
              "128.00 \$",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 8,),
            const Text(
              "seller Finn",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(245, 246, 248, 1),
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 8,),
                        Container(
                          child: Icon(Icons.remove),
                        ),
                        SizedBox(width: 8,),
                        Text("1"),
                        SizedBox(width: 8,),
                        Container(
                          child: Icon(Icons.add),
                        ),
                        SizedBox(width: 8,),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, color: Colors.red,),
                      Text("Remove", style: TextStyle(color: Colors.red),)
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 16,),
          ],
        ),
      ),
    );

    return Column(
      children: [
        ...cartItems
      ],
    );
  }

}
