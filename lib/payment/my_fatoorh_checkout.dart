import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:q_market_n/Assistants/globals.dart';

import '../controllers/base_controller.dart';
import '../controllers/cart_controller.dart';
import '../services/app_exceptions.dart';
import '../views/widgets/progressDialog.dart';

class MyFatoorah with BaseController {
  final CartController cartController = Get.find();
  Future initiate(
      BuildContext context, double amount, int paymentMethodId) async {
    var request =
        new MFInitiatePaymentRequest(amount, MFCurrencyISO.KUWAIT_KWD);

     MFSDK.initiatePayment(
        request,
        MFAPILanguage.EN,
        (MFResult<MFInitiatePaymentResponse> result) => {
              if (result.isSuccess())
                {
                  print(result.response!.toJson().toString()),
                }
              else
                {print(result.error!.message)}
            });
    setAppBar();
    await executePayment(context, amount, paymentMethodId);
    return request;
  }

  var res;

  //Execute Payment
  Future executePayment(
      BuildContext context, double amount, int paymentMethodId) async {
    int paymentMethod = paymentMethodId;

    var request = new MFExecutePaymentRequest(
      paymentMethod,
      amount,
    );

    MFSDK.executePayment(
        context,
        request,
        MFAPILanguage.EN,
        (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
              if (result.isSuccess())
                {
                  res = result.response!.toJson(),
               cartController.addNewOrder(res['InvoiceId'].toString(),res['InvoiceTransactions'][0]['PaymentGateway'], res['InvoiceValue'],1 ),

                  print(result.response!.toJson().toString()),
                  // print("booody :: ${result.response!.toJson()}"),
                  // chargeSaved.invoiceId = res['InvoiceId'],
                  // chargeSaved.invoiceValue = res['InvoiceValue'],
                  // chargeSaved.createdDate = res['CreatedDate'],
                  // chargeSaved.paymentGateway =
                  //     res['InvoiceTransactions'][0]['PaymentGateway'],
                 //  Get.offAll(const MainScreen())
                }
              else
                {
        DialogHelper.showErroDialog(description: 'Something went wrong!\n\n${result.error!.message}'),
                  print('wrong card'),
                  print(result.error!.message),
                print(result.error!.code)

  }
            });
    return request;
  }

  //Direct Payment / Tokenization
  Future directPayment(BuildContext context) async {
    MFCardInfo(cardToken: "put your token here");
    // The value 2 is the paymentMethodId of Visa/Master payment method.
// You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    int paymentMethod = 2;

    var request = new MFExecutePaymentRequest(paymentMethod, 0.100);

// var mfCardInfo = new MFCardInfo(cardToken: "Put your token here");

    var mfCardInfo = new MFCardInfo(
        cardToken: '2ewwwd',
        cardNumber: "4508750015741019",
        expiryMonth: "05",
        expiryYear: "22",
        securityCode: "100",
        bypass3DS: false,
        saveToken: false);

    MFSDK.executeDirectPayment(
        context,
        request,
        mfCardInfo,
        MFAPILanguage.EN,
        (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
              if (result.isSuccess())
                {print(result.response!.toJson().toString())}
              else
                {print(result.error!.message)}
            });
    return request;
  }

  //Payment Enquiry
  Future paymentEnquiry(BuildContext context) async {
    var request = MFPaymentStatusRequest(
        invoiceId: "1099724", paymentId: '0706109972487861669');

    MFSDK.getPaymentStatus(
        MFAPILanguage.EN,
        request,
        (MFResult<MFPaymentStatusResponse> result) => {
              if (result.isSuccess())
                {print(result.response!.toJson().toString())}
              else
                {print(result.error!.message)}
            });
    return request;
  }

  //set app bar
  void setAppBar() {
    MFSDK.setUpAppBar(
        title: "Q Market",
        titleColor: Colors.white, // Color(0xFFFFFFFF)
        backgroundColor: myHexColor, // Color(0xFF000000)
        isShowAppBar: true); // For Android platform o
  }
}
