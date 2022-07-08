import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/cart_controller.dart';
import 'package:shop/routes/routes.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/text_utils.dart';
import 'package:http/http.dart' as http;
import '../../../utils/my_string.dart';

class PaymentButtonWidget extends StatelessWidget {
  final controller=Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            children: [
              TextUtils(
                text: tr(StringManger.total),
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              TextUtils(
                text: '\$${controller.total.toStringAsFixed(2)}',
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: Container(
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                        primary: Get.isDarkMode ? pinkClr : mainColor,
                      ),
                      onPressed: () {
                             makePayment(amount: controller.total.toStringAsFixed(2), currency: "EGP");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextUtils(
                            text: tr(StringManger.payNow),
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ))))
        ],
      ),
    );});;
  }
}
Map<String, dynamic>? paymentIntentData;

Future<void> makePayment(
    {required String amount, required String currency}) async {
  try {
    paymentIntentData = await createPaymentIntent(amount, currency);
    if (paymentIntentData != null) {
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            applePay: true,
            googlePay: true,
            testEnv: true,
            merchantCountryCode: 'US',
            merchantDisplayName: 'Prospects',
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
          ));
      await  displayPaymentSheet();
      print("aaa777aaa");
    }
  } catch (e, s) {
    print('exception:$e$s');
  }
}

displayPaymentSheet() async {
  try {
    await Stripe.instance.presentPaymentSheet(

        parameters: PresentPaymentSheetParameters(
          clientSecret: paymentIntentData?['client_secret'],
          confirmPayment: true,
        ));
  } catch (e) {
    print("exception:$e");
  }
}

//  Future<Map<String, dynamic>>
createPaymentIntent(String amount, String currency) async {
  try {
    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
      'payment_method_types[]': 'card',
      "payment_method_options[card][request_three_d_secure]":"any",
    };
    var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization':
          'Bearer sk_test_51L7tTkF5uinudAWIhzQSQ8S6tmh5JAufqsXZMNIvqizsZXJwLqIMXhWjnmMoEwbGtLFvhbdHwwxnEoETyc8RUN0W00nz3pVz3Y',
          'Content-Type': 'application/x-www-form-urlencoded'
        });
    return jsonDecode(response.body);
  } catch (err) {
    print('err charging user: ${err.toString()}');
  }
}

calculateAmount(String amount) {
  final a = ((double.parse(amount)) * 100).toInt();

  return a.toString();
}
