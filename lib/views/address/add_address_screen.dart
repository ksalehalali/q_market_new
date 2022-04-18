import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:q_market_n/Assistants/globals.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  PhoneNumber number = PhoneNumber(isoCode: 'KW');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12, top: 0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.1 - 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.location_history,
                    size: 32,
                    color: Colors.green[800],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.1 - 60,
              ),
              const Text(
                'Location Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenSize.height * 0.1 - 44,
              ),
              Row(
                children: [
                  Column(
                    children: const [
                      Text(
                        'Address String',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Address String',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                      height: 72,
                      width: 72,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            fit: BoxFit.fill,
                            opacity: 0.7,
                            image: AssetImage(
                              'assets/images/isolate-golden-location-pin.jpg',
                            ),
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 18,
                            color: Colors.white.withOpacity(0.3),
                          ),
                          Text(
                            'Edit',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ))
                ],
              ),
              Divider(
                thickness: 1,
                height: 20,
              ),
              SizedBox(
                height: screenSize.height * 0.3,
              ),
              Text(
                'Personal Information',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.bold),
              ),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  print(number.phoneNumber);

                },
                onInputValidated: (bool value) {
                  print(value);
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                maxLength: 8,
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: Colors.white),
                textStyle: TextStyle(color: Colors.white),
                inputDecoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                initialValue: number,
//                            textFieldController: controller,
                formatInput: false,
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                inputBorder: OutlineInputBorder(),
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                },
              ),
            ],
          )),
        ),
      ),
    );
  }
}
