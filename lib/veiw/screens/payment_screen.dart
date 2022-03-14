import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/logic/controllers/cart_controller.dart';
import 'package:shop/utils/theme.dart';
import 'package:shop/veiw/widgets/payment/delivery_container_widget.dart';
import 'package:shop/veiw/widgets/payment/payment_button_widget.dart';
import 'package:shop/veiw/widgets/payment/payment_method_widget.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

class PaymentScreen extends StatelessWidget {
  final controller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        title: Text('PayMent'),
        elevation: 0,
        backgroundColor: Get.isDarkMode ? darkGreyClr : mainColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextUtils(
                text: 'Shipping to',
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 20,
              ),
              DeliveryContainerWidget(),
              SizedBox(
                height: 20,
              ),
              TextUtils(
                text: 'Payment method',
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 20,
              ),
              PaymentMethodWidget(),
              SizedBox(height: 10,),
              PaymentButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
