// ignore_for_file: avoid_print
//1234561   test Card
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../logic/controllers/cart_controller.dart';
import '../widgets/payment/green_button.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedValue = 1;
  late String orderId;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  void showProgress() {
    ProgressDialog progress = ProgressDialog(context: context);
    progress.show(max: 100, msg: 'please wait ..', progressBgColor: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    return FutureBuilder<DocumentSnapshot>(
        future: customers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Material(
                child: Center(
              child: CircularProgressIndicator(),
            ));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Obx(
              () {
                return Material(
                  color: Colors.grey.shade200,
                  child: SafeArea(
                    child: Scaffold(
                      backgroundColor: Colors.grey.shade200,
                      appBar: AppBar(
                        elevation: 0,
                        backgroundColor: Colors.grey.shade200,
                        leading: const BackButton(),
                        title: Text('Payment'),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Total',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          '${(controller.total.toDouble() + 10.0).toStringAsFixed(2)} EGP',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Total order',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                        Text(
                                          '${controller.total.toStringAsFixed(2)} EGP',
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'Shipping Coast',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                        Text(
                                          '10.00' + (' EGP'),
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    RadioListTile(
                                      activeColor: Colors.deepOrange,
                                      value: 1,
                                      groupValue: selectedValue,
                                      onChanged: (int? value) {
                                        setState(() {
                                          selectedValue = value!;
                                        });
                                      },
                                      title: const Text('Cash On Delivery'),
                                      subtitle: const Text('Pay Cash At Home'),
                                    ),
                                    RadioListTile(
                                      activeColor: Colors.deepOrange,
                                      value: 2,
                                      groupValue: selectedValue,
                                      onChanged: (int? value) {
                                        setState(() {
                                          selectedValue = value!;
                                        });
                                      },
                                      title: const Text(
                                          'Pay via visa / Master Card'),
                                      subtitle: Row(
                                        children: const [
                                          Icon(Icons.payment,
                                              color: Colors.deepOrange),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Icon(
                                                FontAwesomeIcons.ccMastercard,
                                                color: Colors.deepOrange),
                                          ),
                                          Icon(FontAwesomeIcons.ccVisa,
                                              color: Colors.deepOrange)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      bottomSheet: Container(
                        color: Colors.grey.shade200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GreenButton(
                            label:
                                'Confirm ${(controller.total.toDouble() + 10.0).toStringAsFixed(2)} EGP',
                            width: 1,
                            onPressed: () {
                              if (selectedValue == 1) {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 100),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    'Pay At Home ${(controller.total.toDouble() + 10.0).toStringAsFixed(2)} \$',
                                                    style: const TextStyle(
                                                        fontSize: 24),
                                                  ),
                                                  GreenButton(
                                                      label:
                                                          'Confirm ${(controller.total.toDouble() + 10.0).toStringAsFixed(2)} \$',
                                                      onPressed: () async {
                                                        showProgress();
                                                        for (var item
                                                            in controller
                                                                .productMap
                                                                .values) {
                                                          CollectionReference
                                                              orderRef =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'orders');
                                                          orderId =
                                                              const Uuid().v4();
                                                          await orderRef
                                                              .doc(orderId)
                                                              .set({
                                                            'cid': data['cid'],
                                                            'custname':
                                                                data['name'],
                                                            'email':
                                                                data['email'],
                                                            'address':
                                                                data['address'],
                                                            'phone':
                                                                data['phone'],
                                                            'sid': item.suppId,
                                                            'proid':
                                                                item.documentId,
                                                            'orderid': orderId,
                                                            'ordername':
                                                                item.name,
                                                            'orderimage': item
                                                                .imagesUrl
                                                                .first,
                                                            'orderqty':
                                                                item.qty,
                                                            'orderprice':
                                                                item.qty *
                                                                    item.price,
                                                            'deliverystatus':
                                                                'preparing',
                                                            'deliverydate': '',
                                                            'orderdate':
                                                                DateTime.now(),
                                                            'paymentstatus':
                                                                'cash on delivery',
                                                            'orderreview':
                                                                false,
                                                          }).whenComplete(
                                                                  () async {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .runTransaction(
                                                                    (transaction) async {
                                                              DocumentReference
                                                                  documentReference =
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'products')
                                                                      .doc(item
                                                                          .documentId);
                                                              DocumentSnapshot
                                                                  snapshot2 =
                                                                  await transaction
                                                                      .get(
                                                                          documentReference);
                                                              transaction.update(
                                                                  documentReference,
                                                                  {
                                                                    'instock': snapshot2[
                                                                            'instock'] -
                                                                        item.qty
                                                                  });
                                                            });
                                                          });
                                                        }
                                                        controller
                                                            .removeAllCart();
                                                        Navigator.popUntil(
                                                            context,
                                                            ModalRoute.withName(
                                                                '/customer_home'));
                                                      },
                                                      width: 0.9)
                                                ]),
                                          ),
                                        ));
                              } else if (selectedValue == 2) {
                                makePayment(
                                    amount: (controller.total + 10)
                                        .toStringAsFixed(2),
                                    currency: "EGP");
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    //   },
    // );
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
      await displayPaymentSheet();
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
      "payment_method_options[card][request_three_d_secure]": "any",
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

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shop/logic/controllers/cart_controller.dart';
// import 'package:shop/utils/theme.dart';
// import 'package:shop/veiw/widgets/payment/delivery_container_widget.dart';
// import 'package:shop/veiw/widgets/payment/payment_button_widget.dart';
// import 'package:shop/veiw/widgets/payment/payment_method_widget.dart';
// import 'package:shop/veiw/widgets/text_utils.dart';
//
// import '../../utils/my_string.dart';
//
// class PaymentScreen extends StatelessWidget {
//   final controller = Get.find<CartController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.theme.backgroundColor,
//       appBar: AppBar(
//         title: Text(
//           tr(StringManger.payment),
//         ),
//         elevation: 0,
//         backgroundColor: Get.isDarkMode ? darkGreyClr : mainColor,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextUtils(
//                 text:    tr(StringManger.shipTo),
//                 color: Get.isDarkMode ? Colors.white : Colors.black,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               DeliveryContainerWidget(),
//               SizedBox(
//                 height: 20,
//               ),
//               TextUtils(
//                 text: tr(StringManger.paymentMethod),
//                 color: Get.isDarkMode ? Colors.white : Colors.black,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               PaymentMethodWidget(),
//               SizedBox(
//                 height: 10,
//               ),
//               PaymentButtonWidget(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
