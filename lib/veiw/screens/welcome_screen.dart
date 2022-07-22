import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../utils/my_string.dart';
import '../../utils/theme.dart';
import '../widgets/text_utils.dart';

class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final  height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.2),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height*0.17
                  ),
                  Container(
                    height: height*0.1,
                    width: 190,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                        child: TextUtils(
                      text: tr(StringManger.welcome),
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                  SizedBox(
                    height: height*0.03,
                  ),
                  Container(
                    height: height*0.1,
                    width: 230,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextUtils(
                            text: tr(StringManger.icho),
                            color: mainColor,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                        SizedBox(
                          width: 7,
                        ),
                        TextUtils(
                            text:  tr(StringManger.shop),
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height*0.2,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: mainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12)),
                      onPressed: () {
                        Get.offNamed(Routes.LoginScreen);
                      },
                      child: TextUtils(
                          text: tr(StringManger.getStart),
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: height*0.07,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextUtils(
                          text: tr(StringManger.dontHaveAccount),
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                      TextButton(
                          onPressed: () {
                            Get.offNamed(Routes.SignUpScreen);
                          },
                          child: TextUtils(
                            text: tr(StringManger.signUp),
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            underLine: TextDecoration.underline,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
