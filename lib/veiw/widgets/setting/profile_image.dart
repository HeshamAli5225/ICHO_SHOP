import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/veiw/widgets/text_utils.dart';

class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        CircleAvatar(
         backgroundColor: Colors.teal,
          //child:
          minRadius: 30,
          maxRadius: 45,
          backgroundImage: NetworkImage('https://images.unsplash.com/photo-1613591761556-01126c708410?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80'),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextUtils(
                text: 'Hesham Ali',
                color: Get.isDarkMode?Colors.white:Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
            ),
            TextUtils(
              text: 'hesham.ali.3959@gmail.com',
              color: Get.isDarkMode?Colors.white:Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),

      ],
    );
  }
}
