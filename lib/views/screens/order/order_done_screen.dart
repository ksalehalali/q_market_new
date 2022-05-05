import 'package:flutter/material.dart';
import 'package:q_market_n/Assistants/globals.dart';

import 'order_timeline.dart';

class OrderDoneScreen extends StatelessWidget {
  const OrderDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100,),
              Container(
                  width:double.infinity,
                  height: 120,
                  child: OrderTimeLine())
            ],
          ),
        ),
      ),

    );
  }
}
