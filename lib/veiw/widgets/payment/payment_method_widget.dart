import 'package:flutter/material.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

class PaymentMethodWidget extends StatefulWidget {
  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  int radioContainerIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          methodContainer(
              image: 'assets/images/paypal.png',
              imageScale: 0.5,
              methodName: 'Paypal',
              value: 1,
              onChanged: (value) {
                setState(() {
                  radioContainerIndex = value;
                });

              }),
          SizedBox(
            height: 15,
          ),
          methodContainer(
              image: 'assets/images/google.png',
              imageScale: 0.7,
              methodName: 'Google Play',
              value: 2,
              onChanged: (value) {
                setState(() {
                  radioContainerIndex = value;
                });
              }),
          SizedBox(
            height: 15,
          ),
          methodContainer(
            image: 'assets/images/credit.png',
            imageScale: 0.55,
            methodName: 'Credit Card',
            value: 3,
            onChanged: (value) {
              setState(() {
                radioContainerIndex = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget methodContainer({
    required String image,
    required String methodName,
    required int value,
    required Function onChanged,
    required double imageScale,
  }) {
    return Container(
      color: Colors.grey[300],
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Image.asset('${image}',scale: imageScale,),
          ),
          SizedBox(
            width: 10,
          ),
          TextUtils(
            text: methodName,
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          Expanded(child: SizedBox()),
          Radio(
            value: value,
            groupValue: radioContainerIndex,
            fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
            onChanged: (value) {
              onChanged(value);
            },
          ),
        ],
      ),
    );
  }
}
