import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../utils/theme.dart';
import '../widgets/text_utils.dart';
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset( 'assets/images/background.png',
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
                  SizedBox(height: 100,),
                  Container(
                    height: 60,
                    width: 190,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Center(child:TextUtils(
                      text: 'Welcome',
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    )
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    height: 60,
                    width: 230,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextUtils(text: 'ICHO', color: mainColor, fontSize: 35, fontWeight: FontWeight.bold),
                        SizedBox(width: 7,),
                        TextUtils(text: 'ShOP', color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)
                      ],
                    ),
                  ),
                  SizedBox(height: 250,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 12)
                    ),
                      onPressed: (){
                        Get.offNamed(Routes.LoginScreen);
                      }, child: TextUtils(text: 'Get Start', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    TextUtils(text: 'Don\'t have an Account?', color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                      TextButton(onPressed: (){
                        Get.offNamed(Routes.SignUpScreen);
                      }, child: TextUtils(text: 'SignUp', color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal,underLine: TextDecoration.underline,))
                  ],)
                ],
              ),
            ),



          ],
        ),
      ),
    );
  }
}
